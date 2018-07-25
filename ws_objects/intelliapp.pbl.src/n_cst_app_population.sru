$PBExportHeader$n_cst_app_population.sru
$PBExportComments$ole outlook add by Appeon:Kater 04.02.2001
forward
global type n_cst_app_population from nonvisualobject
end type
end forward

global type n_cst_app_population from nonvisualobject autoinstantiate
end type

type variables
integer	ii_AppType
pfc_cst_u_popwebsite  iu_WebPainter
pfc_cst_u_create_app2 iu_AppPainter

long		ii_app_id
integer	ii_from_page
integer	ii_to_page
long	ii_facility_id  //maha 04.07.2014 changed from int to long
n_ds		ids_ScreenList
n_ds		ids_AppField
n_ds		ids_ScreenField
n_ds		ids_App
n_ds		ids_ScreenData
n_ds		ids_ScreenDataAll[]
n_ds		ids_ScreenAddress
string	is_save_as
string	is_sort_syntax
integer	ii_err_handling
long 		il_prac
long		il_prac_org
long 		il_loc_id  //maha 04.07.2014 added
long		il_state_passed //maha 06.10.2014
boolean	ib_single_page
boolean	ib_group
integer	ii_table_id
integer	ii_record_number
integer	ii_master
string	is_screen_name
string	is_field_name
string	is_past_filter
integer	ii_scr_array[]
string	is_sort_arr[]
Boolean	ib_page_populated[]
String	is_data_value[500, 500]
pfc_cst_nv_data_entry_functions	inv_de_functions

string	is_ActiveElement
string	is_AttributeName
string	is_ElementType
string	is_ElementIndex
oleobject iole_Document
string is_user_name = "@name" //maha 04.08.20name
string is_user_email = "@email" //maha 04.08.2email
string is_user_street = "@street"  //maha 11.03.2016
string is_user_street2 = "@street2"  //maha 11.03.2016
string is_user_city = "@city"  //maha 11.03.2016
string is_user_state = "@state"  //maha 11.03.2016
string is_user_zip = "@zip"  //maha 11.03.2016
string is_user_phone = "@phone"  //maha 11.03.2016
string is_user_fax = "@fax"  //maha 11.03.2016
string is_table_name

constant	integer TIF_FORM = 1
constant	integer WEB_FORM = 2
end variables

forward prototypes
protected function string of_getactiveelement (oleobject aole_object)
public function integer of_presetup ()
public function integer of_cachedata ()
public function integer of_postsetup ()
public function integer of_getallscreendata ()
public function integer of_displayimage ()
protected function integer of_setup ()
public function integer of_displaypage (integer ai_page)
public function integer of_destroy ()
public function integer of_drawspecialfields (integer ai_page)
public function integer of_getgroupdata (integer ai_screen_id)
public function integer of_getscreendata (integer ai_screen_id)
public function integer of_getappfielddata (integer ai_screen_id, integer ai_page)
public function integer of_drawconnectfields (integer ai_page)
public function integer of_saveimage ()
public function integer of_additionalpageproc ()
public function integer of_drawobject (integer ai_page, integer ai_field, string as_data)
public function integer of_sortscreendata ()
public function integer of_error_msg (long al_prac, integer ai_facil_id, long al_app_id, long al_app_field_id, integer ai_cur_page, string as_error, integer ai_err_hand)
public function string of_format (string as_value, string as_format)
public function string of_get_luvalue (string as_link_type, string as_link_field, long al_lu_code)
public function integer of_getfieldvalue (integer ai_field, ref string as_value)
public function string of_billing_address (n_ds ads_detail, string as_query, integer ai_record_number, integer ai_screen)
public function integer of_filterscreendata (integer ai_screen_id, integer ai_field, string as_query)
public function integer of_correctfieldname (integer ai_screen_id, integer ai_field)
public function string of_field_name (integer ai_screen, string as_field)
public function string of_address_query (string as_type)
public function integer of_groupdataprocess (integer ai_screen_id, integer ai_field)
public function integer of_pastyearsfilter (integer ai_screen_id, integer ai_field)
public function string of_buildqueryfilters (integer ai_screen_id, integer ai_field)
public function integer of_fieldprocbegin (integer ai_field)
public function integer of_screenprocbegin (integer ai_screen)
public function integer of_setup (pfc_cst_u_popwebsite au_webpainter, long ai_app_id, integer ai_from_page, integer ai_to_page, integer ai_facility_id)
public function integer of_getmappingdata (integer ai_field, string as_data)
public function integer of_getlogininfo ()
protected function integer of_getactiveelementinfo (oleobject aole_object)
public function integer of_getactiveelement (oleobject aole_object, ref string as_element, ref string as_elementtype, ref string as_execommand)
public function integer of_get_norowcount ()
public function boolean of_is_default_field (integer ai_row)
public function integer of_setup (pfc_cst_u_create_app2 au_apppainter, long ai_app_id, integer ai_from_page, integer ai_to_page, long ai_facility_id, long al_loc_id, long al_state)
public function long of_get_lucode_by_code (string as_link_type, string as_lookup_name, string as_code)
public function integer of_evaluate_sort (n_ds adw_data, string as_from_field, string as_type, string as_lu_field, integer ai_screenid)
end prototypes

protected function string of_getactiveelement (oleobject aole_object);//====================================================================
// $<function> of_getactiveelement()
// $<arguments>
// 	value	oleobject	aole_object
// $<returns> integer
// $<description> Get active element object in web page
//						V12.1 Website Population
// $<add> (Appeon) evan 10.20.2011
//====================================================================

long i, ll_Len
string ls_Path
string ls_Type
string ls_tagName
oleobject lole_frame

ls_tagName = Upper(aole_object.tagName)
choose case ls_tagName
	case "INPUT"
		is_ElementType = Upper(aole_object.type)
		if is_ElementType = "TEXT" or is_ElementType = "PASSWORD" then
			is_ElementType = "T"
			of_GetActiveElementInfo(aole_object)
		elseif is_ElementType = "CHECKBOX" then
			is_ElementType = "C"
			of_GetActiveElementInfo(aole_object)
		elseif is_ElementType = "RADIO" then
			is_ElementType = "R"
			of_GetActiveElementInfo(aole_object)
		end if
	
	case "TEXTAREA"
		is_ElementType = "T"
		of_GetActiveElementInfo(aole_object)
		
	case "SELECT"
		is_ElementType = "D"
		of_GetActiveElementInfo(aole_object)
		
	case "FRAME", "IFRAME" // Nesting HTML
		ll_Len = aole_object.document.frames.length
		for i = 0 to ll_Len - 1
			lole_frame = aole_object.document.frames[i]
			iole_Document = lole_frame.document
			ls_Path = of_GetActiveElement(iole_Document.activeElement)
			if is_ActiveElement <> "" then
				if ls_Path <> "" then ls_Path = "." + ls_Path
				ls_Path = "frames[" + String(i) + "]" + ls_Path
			end if
		next
end choose

Return ls_Path
end function

public function integer of_presetup ();//====================================================================
// $<function> of_presetup()
// $<arguments>
// $<returns> integer
// $<description> N/A
// $<add> (Appeon) evan 11.07.2011
//====================================================================

string ls_Rtn

// Get error handling parameter
ii_err_handling = 0
ii_err_handling = of_get_app_setting("set_21","I")

// TIF form
if ii_AppType = TIF_FORM then
	// Get prac id
	il_prac = iu_AppPainter.ii_prac_id
	il_prac_org = iu_AppPainter.ii_prac_id

	// Get save as path
	if gi_citrix = 1 then
		is_save_as = of_letter_paths("L")
	else
		is_save_as = gs_temp_path + "\" 
	end if
	ls_Rtn = f_ExaWriteRight(is_save_as)
	if LenA(ls_Rtn) > 0 then
		MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
		Return -1
	end if
	is_save_as += String(ii_app_id) + "-" + String(il_prac) + ".tif"
	
	// Show each field during IntelliApp population (redraw on)
	if of_get_app_setting("set_3","I") = 1 then
		iu_AppPainter.SetRedraw(False)
	end if
	
	// Display image
	of_DisplayImage()
else
	// Get prac id
	il_prac = iu_WebPainter.il_prac_id
	il_prac_org = iu_WebPainter.il_prac_id
end if

// Check page
if ii_from_page > ii_to_page then
	messagebox("User Error","You have entered a page range greater than the number of pages in the Application.")
	if ii_AppType = TIF_FORM then iu_AppPainter.SetRedraw(true)
	Return -1
end if
	
// Create objects
ids_ScreenData = CREATE n_ds
ids_ScreenData.DataObject = ""
ids_ScreenAddress = CREATE n_ds
ids_ScreenAddress.DataObject = ""
inv_de_functions = CREATE pfc_cst_nv_data_entry_functions

// Cache related data
of_CacheData()

// Get all related screens data
of_GetAllScreenData()

Return 1
end function

public function integer of_cachedata ();//====================================================================
// $<function> of_cachedata()
// $<arguments>
// $<returns> integer
// $<description> Cache related data
// $<add> (Appeon) evan 11.07.2011
//====================================================================

integer li_Count

ids_ScreenList = CREATE n_ds
ids_ScreenList.DataObject = "d_app_screen_ids_in_page_ranges_appeon"
ids_ScreenList.of_SetTransObject(SQLCA) //(iu_AppPainter.tr_app_data)

ids_AppField = CREATE n_ds
ids_AppField.DataObject = "d_app_data_page_ranges_appeon"
ids_AppField.of_SetTransObject(SQLCA) //(iu_AppPainter.tr_app_data)

ids_ScreenField = CREATE n_ds
ids_ScreenField.DataObject = "d_screen_fields_appeon"
ids_ScreenField.of_SetTransObject(SQLCA) //(iu_AppPainter.tr_app_data)

ids_App = CREATE n_ds
ids_App.DataObject = "d_app_detail"
ids_App.of_SetTransObject(SQLCA) //(iu_AppPainter.tr_app_data)

gnv_appeondb.of_StartQueue()
ids_ScreenList.Retrieve(ii_app_id)
ids_AppField.Retrieve(ii_app_id)
ids_ScreenField.Retrieve(1)
ids_App.Retrieve(ii_app_id)
select count(*) into :li_Count from pbcatcol;
gnv_appeondb.of_CommitQueue()

if li_Count > 0 then
	ii_master = 1
else
	ii_master = 0
end if

Return 1
end function

public function integer of_postsetup ();//====================================================================
// $<function> of_postsetup()
// $<arguments>
// $<returns> integer
// $<description> N/A
// $<add> (Appeon) evan 11.07.2011
//====================================================================

if ii_AppType = TIF_FORM then
	iu_AppPainter.ii_current_page = iu_AppPainter.ole_edit.Object.page()
	iu_AppPainter.st_page_num.Text = "Page " + String( iu_AppPainter.ii_current_page ) + " of " + String( iu_AppPainter.ole_edit.Object.PageCount() )
	
	IF iu_AppPainter.ii_current_page > 1 THEN
		iu_AppPainter.cb_prior.Enabled = True
	ELSE
		iu_AppPainter.cb_prior.Enabled = False
	END IF
	IF iu_AppPainter.ii_current_page < iu_AppPainter.ole_edit.Object.PageCount( ) THEN
		iu_AppPainter.cb_next.Enabled = True
	Else
		iu_AppPainter.cb_next.Enabled = False
	END IF
	iu_AppPainter.SetRedraw( True )
	iu_AppPainter.ole_edit.Object.ScrollBars( True )
end if

of_Destroy()

Return 1
end function

public function integer of_getallscreendata ();//====================================================================
// $<function> of_getallscreendata()
// $<arguments>
// $<returns> integer
// $<description> Get all related screens data
// $<add> (Appeon) evan 11.07.2011
//====================================================================

integer	li_screen_id
integer	li_last_scrid
integer	li_scr_index
integer	s, p, li_screen_cnt
integer r, nr
string ls_sort_field  //maha 06.20.2017
datastore lds_sorts  //maha 11.10.2016

li_screen_cnt = ids_ScreenList.Rowcount()
ids_ScreenList.SetSort("screen_id A")
ids_ScreenList.Sort()

//Start Code Change ----11.10.2016 #V153 maha - sort fields for lookups
lds_sorts = create datastore
lds_sorts.dataobject = "d_sort_fields_4_lookup"
lds_sorts.settransobject(sqlca)
lds_sorts.retrieve()
//End Code Change ----11.10.2016 

// Loop screens processing
inv_de_functions.ib_retrieve_enabled = FALSE //stop retrieving in dynimic create fun
FOR s = 1 to li_screen_cnt
	li_screen_id = ids_ScreenList.GetItemNumber(s, "screen_id" ) 
	p = ids_ScreenList.GetItemNumber(s, "app_field_prop_page" ) 
	IF li_screen_id <> li_last_scrid AND p >= ii_from_page AND p <= ii_to_page THEN
		// Create datastore object
		li_scr_index ++
		ids_ScreenList.GetItemNumber(s, "screen_id" )
		ii_scr_array[li_scr_index] = li_screen_id
		ids_ScreenDataAll[li_scr_index] = CREATE n_ds
		ids_ScreenDataAll[li_scr_index].DataObject = ""
		li_last_scrid = li_screen_id
		
		// Dynamically create datawindow - data is retrieved below
		inv_de_functions.of_create_dynamic_ds( il_prac, 1, li_screen_id, ids_ScreenDataAll[li_scr_index], ii_facility_id, sqlca )
		is_sort_arr[li_scr_index] = inv_de_functions.is_sort_syntax
		
		//---------Begin Added by (Appeon)Stephen 06.20.2017 for Bug id 5703 - Getting sort error when trying to preview a page in Application Mapping. C/S Version 15.309 Build Date 5/11/2017--------
	//Start Code Change ----06.20.2017 #V154 maha	- removed
//		// Get screen fields
//		ids_ScreenField.SetFilter( "data_view_fields_screen_id = " + string(li_screen_id) )
//		ids_ScreenField.Filter()
//		IF ids_ScreenField.RowCount() > 0 THEN 
//			is_table_name = ids_ScreenField.GetItemstring( 1, "db_table_name" ) 
//		end if
		//---------End Added ------------------------------------------------------
	END IF
END FOR
inv_de_functions.ib_retrieve_enabled = TRUE //resume retrieving in dynamic create fun

// Retrieve all screens data
gnv_appeondb.of_startqueue( )
FOR li_scr_index = 1 TO UpperBound(ii_scr_array)
	ids_ScreenDataAll[li_scr_index].Retrieve()
	
	//Start Code Change ----06.20.2017 #V154 maha
	li_screen_id =  ii_scr_array[li_scr_index] 
	
	//Start Code Change ----11.10.2016 #V153 maha - check to see if there are any sort by lookup fields and set data values
	lds_sorts.setfilter("screen_id =" + string( ii_scr_array[li_scr_index]))
	lds_sorts.filter()
	if lds_sorts.rowcount() > 0 then
		for r = 1 to lds_sorts.rowcount()
			of_evaluate_sort( ids_ScreenDataAll[li_scr_index],  lds_sorts.getitemstring(r, "field_name") , lds_sorts.getitemstring(r, "lookup_type"), lds_sorts.getitemstring(r, "lookup_field_name") , li_screen_id )
	//End Code Change ----06.20.2017 
		next
	end if
	//End Code Change ----11.10.2016
END FOR
gnv_appeondb.of_commitqueue( )

Return 1
end function

public function integer of_displayimage ();//====================================================================
// $<function> of_displayimage()
// $<arguments>
// $<returns> integer
// $<description> Display image
// $<add> (Appeon) evan 11.07.2011
//====================================================================

string ls_app_image_name
//Start Code Change ----10.16.2009 #V10 maha - For Lehigh
//---------Begin Modified by (Appeon)Harry 06.29.2013 for V141 ISG-CLX--------
//if of_get_app_setting("set_58","I") = 1 then
if of_get_app_setting("set_91","I") = 1 then
//---------End Modfiied ------------------------------------------------------
	iu_AppPainter.ole_edit.Object.SaveAs( is_save_as )
else
	//------------------- APPEON BEGIN -------------------
	//$<modify> Stephen 02.16.2012
	//$<reason> Bug Bug 2918 : pdf file preview is poor quality and prints the same way
	/*
	iu_AppPainter.ole_edit.Object.SaveAs( is_save_as,1,1,1,0,false )  
	*/
	ls_app_image_name	= 	iu_AppPainter.ole_edit.Object.Image()
	if fileexists(ls_app_image_name) then
		filedelete(is_save_as)
		filecopy(ls_app_image_name, is_save_as)
	else
		iu_AppPainter.ole_edit.Object.Saveas( is_save_as,1,2,1,0,false )  
	end if
	//------------------- APPEON END -------------------
end if
//End Code Change---10.16.2009

iu_AppPainter.ole_edit.Object.ClearDisplay()
iu_AppPainter.ole_edit.Object.Image( is_save_as )
iu_AppPainter.ole_edit.Object.FitTo(3)
iu_AppPainter.ole_edit.Object.Annotationtype(11)	
iu_AppPainter.ole_edit.Object.Display()

IF ii_to_page = 99 THEN
	ii_from_page = 1
	ii_to_page = iu_AppPainter.ole_edit.Object.PageCount()
END IF
if ii_from_page = ii_to_page then
	ib_single_page = true  //Start Code Change ----01.25.2008 #V8 maha
else
	ib_single_page = false
end if

IF IsValid(w_infodisp) THEN
	w_infodisp.wf_set_min_max(1, ii_to_page)
END IF
iu_AppPainter.setredraw(true)

Return 1
end function

protected function integer of_setup ();//====================================================================
// $<function> of_setup()
// $<arguments>
// $<returns> integer
// $<description>
//		1.Populate application type of TIF form
//		2.Populate application type of Website form
// $<add> (Appeon) evan 11.07.2011
//====================================================================

string	ls_Query, ls_Data 
string ls_default  //maha 12.10.2012
Integer	li_Page, li_screen_id
integer	li_Screen, li_ScreenCount
integer	li_Field, li_AppFieldCount
integer 	li_default  //maha 12.10.2012
boolean lb_no_rows = false  //maha 12.10.2012
boolean lb_none  //maha 12.10.2012

// Prepare setup
if of_PreSetup() <> 1 then Return -1

// Loop pages processing
for li_Page = ii_from_page to ii_to_page
	il_prac = il_prac_org //Start Code Change ----05.03.2012 #V12 maha
	if ii_AppType = TIF_FORM then
		of_DisplayPage(li_Page)
		of_DrawSpecialFields(li_Page)
	end if
	
	// Get screen list for this page
	ids_ScreenList.SetFilter("app_field_prop_page = " + String(li_Page))
	ids_ScreenList.Filter()
	li_ScreenCount = ids_ScreenList.Rowcount()

	// Loop screens processing
	for li_Screen = 1 to li_ScreenCount
		of_ScreenProcBegin(li_Screen)  //gets  screen name
		lb_no_rows = false //**************

		// Get related data
		li_screen_id = ids_ScreenList.GetItemNumber(li_Screen, "screen_id")
		li_AppFieldCount = of_GetAppFieldData(li_screen_id, li_Page)  //filters for the specific screen and get field count

		if	li_AppFieldCount < 1 then continue
//Start Code Change ----12.10.2012 #V12 maha - coding for no row defaults			
		li_default = of_get_norowcount( )  //gets the number of mapping fields with the use default for no existing rows
//		if li_default > 0 then ls_default = ids_AppField.GetItemString(li_Field,"default_val")
		
		//if of_GetGroupData(li_screen_id) <> 1 then continue
		if of_GetGroupData(li_screen_id) <> 1 then 
			if li_default = 0 then continue
		end if
		//if of_GetScreenData(li_screen_id) <> 1 then Continue
		if of_GetScreenData(li_screen_id) <> 1 then //creates the data store for the screen
			if li_default = 0 then
				Continue
			else
				lb_no_rows = true
			end if
		end if
		// Loop application fields processing
		
		for li_Field = 1 to li_AppFieldCount
			if lb_no_rows then  //exception for no rows default value
				ls_data = ''
				if of_is_default_field(li_field) then
					ls_default = ids_AppField.GetItemString(li_Field,"default_val")
					ls_data = ls_default
				end if		
			else //get data from the fields
				if of_FieldProcBegin(li_Field) <> 1 then //gets field name and record #
					Continue
				end if
			
				// Past years filter
				of_PastYearsFilter(li_screen_id, li_Field)
		
				// Correct field name
				if of_CorrectFieldName(li_screen_id, li_Field) <> 1 then
					Continue
				end if
	
				//process group data
				if of_GroupDataProcess(li_screen_id, li_Field) <> 1 then Continue

	
				// Filter screen data
				ls_Query = of_BuildQueryFilters(li_screen_id, li_Field)
				if of_FilterScreenData(li_screen_id, li_Field, ls_Query) <> 1 then continue
				
	
				// Get field value
				if of_GetFieldValue(li_Field, ls_Data) <> 1 then continue
			
			end if  //no rows default
			//End Code Change ----05.10.2013 #V12 maha - no rows - corrected prior code
	
				// Draw object or get mapping data
			if ii_AppType = TIF_FORM then
				of_DrawObject(li_Page, li_Field, ls_Data)
			else
				of_GetMappingData(li_Field, ls_Data)
			end if
		next //field
		
	next  //screen

	// Draw connected fields and save image
	if ii_AppType = TIF_FORM then
		of_DrawConnectFields(li_Page)
		of_SaveImage()
	end if
next

// Additional pages processing
if ii_AppType = TIF_FORM then
	of_AdditionalPageProc()
end if

// Post setup
of_PostSetup()

Return 0
end function

public function integer of_displaypage (integer ai_page);//====================================================================
// $<function> of_displaypage()
// $<arguments>
//		integer	ai_page
// $<returns> integer
// $<description> Display specified page
// $<add> (Appeon) evan 11.08.2011
//====================================================================

iu_AppPainter.ole_edit.Object.Page( ai_Page )
iu_AppPainter.ole_edit.Object.Display()
iu_AppPainter.of_clear_annotations( ai_Page)
iu_AppPainter.ii_current_page = ai_Page
ib_page_populated[ ai_Page ] = False

IF iu_AppPainter.ib_sever_started THEN
	//iapply; not used
ELSE
	iu_AppPainter.st_page_num.Text = "Page " + String( iu_AppPainter.ii_current_page ) + " of " + String( iu_AppPainter.ole_edit.Object.PageCount()	)
END IF

Return 1
end function

public function integer of_destroy ();//====================================================================
// $<function> of_destroy()
// $<arguments>
// $<returns> integer
// $<description> N/A
// $<add> (Appeon) evan 11.08.2011
//====================================================================

integer	li_Null[]
string	ls_Null[]
Boolean	lb_Null[]
n_ds		lds_Null[]
integer	i, li_Count

// Set array as null
ii_scr_array[] = li_Null[]
is_sort_arr[] = ls_Null[]
ib_page_populated[] = lb_Null[]

// Destroy all objects
if IsValid(ids_ScreenList) then Destroy ids_ScreenList
if IsValid(ids_AppField) then Destroy ids_AppField
if IsValid(ids_ScreenField) then Destroy ids_ScreenField
if IsValid(ids_App) then Destroy ids_App
if IsValid(ids_ScreenData) then Destroy ids_ScreenData
if IsValid(ids_ScreenAddress) then Destroy ids_ScreenAddress
if IsValid(inv_de_functions) then Destroy inv_de_functions

li_Count = UpperBound(ids_ScreenDataAll[])
for i = 1 to li_Count
	if IsValid(ids_ScreenDataAll[i]) then
		Destroy ids_ScreenDataAll[i]
	end if
next
ids_ScreenDataAll[] = lds_Null[]

Return 1
end function

public function integer of_drawspecialfields (integer ai_page);//====================================================================
// $<function> of_drawspecialfields()
// $<arguments>
//		integer	ai_page
// $<returns> integer
// $<description> Draw special fields
// $<add> (Appeon) evan 11.08.2011
//====================================================================

date ld_futuredate
long li_app_field_id
long ll_color //maha 06.19.2012
integer sf, li_x, li_y
integer li_special_fld_cnt
integer li_box_height, li_box_width
string  ls_val, ls_special_field
string ls_color  //maha 06.19.2012
boolean lb_label = false

ids_AppField.SetFilter( "table_id = 99 and page = " + string(ai_Page) )
ids_AppField.Filter()
li_special_fld_cnt = ids_AppField.RowCount()

FOR sf = 1 TO li_special_fld_cnt
	ls_val = ""
	li_app_field_id = ids_AppField.GetItemNumber( sf, "app_field_id" )
	li_x = ids_AppField.GetItemNumber( sf, "x_pos" )
	li_y = ids_AppField.GetItemNumber( sf, "y_pos" )		
	li_box_height = ids_AppField.GetItemNumber( sf, "box_height" )		
	li_box_width = ids_AppField.GetItemNumber( sf, "box_width" )		
	ls_special_field = ids_AppField.GetItemString( sf, "field_description" )
	ls_color =  ids_AppField.GetItemString( sf, "font_background" )
	//Start Code Change ----08.02.2017 #V154 maha - trap for labels populating as specail fields - includes regerences to lb_label below
	if Upper(MidA( ls_special_field, 1, 6 )) = "LABEL-" then 
		lb_label = true
	else
		lb_label = false
	end if
	//End Code Change ----08.02.2017
	IF PosA( ls_special_field, "Todays Date" ) > 0 and not lb_label THEN
		ls_val = String( Today(), "mm/dd/yyyy" )
	ELSEIF PosA( ls_special_field, "Current Time" ) > 0 and not lb_label THEN			
		ls_val = String( Now(), "hh:mm am/pm" )
	ELSEIF PosA( ls_special_field, "User Id" ) > 0 and not lb_label THEN			
		ls_val = gs_user_id
	//Start Code Change ----04.08.2013 #V12 maha
	ELSEIF PosA( ls_special_field, "User Name" ) > 0 and not lb_label THEN	
			if is_user_name = "@name" then
				select user_name into :is_user_name from security_users where user_id = :gs_user_id;
			end if
			ls_val = is_user_name	
	ELSEIF PosA( ls_special_field, "User Email" ) > 0 and not lb_label THEN	
			if is_user_email  = "@email" then
				select email_id into :is_user_email from security_users where user_id = :gs_user_id;
			end if
			ls_val = is_user_email	
	//End Code Change ----04.08.2013
	//Start Code Change ----11.03.2016 #V153 maha
	ELSEIF PosA( upper(ls_special_field), "USER STREET"  ) > 0 and not lb_label THEN	
			if  is_user_street = "@street" then
				select user_street1 into :is_user_street from security_users where user_id = :gs_user_id;
			end if
			ls_val = is_user_street
	ELSEIF PosA( upper(ls_special_field), "USER STREE2"  ) > 0 and not lb_label THEN	
			if is_user_street2 = "@street2" then
				select user_street2 into :is_user_street2 from security_users where user_id = :gs_user_id;
			end if
			ls_val = is_user_street2
	ELSEIF PosA( upper(ls_special_field), "USER CITY"  ) > 0 and not lb_label THEN	
			if is_user_city = "@city"  then
				select user_city into :is_user_city from security_users where user_id = :gs_user_id;
			end if
			ls_val = is_user_city
	ELSEIF PosA( upper(ls_special_field), "USER STATE"  ) > 0 and not lb_label THEN	
			if is_user_state = "@state" then
				select user_state into :is_user_state from security_users where user_id = :gs_user_id;
			end if
			ls_val = is_user_state
	ELSEIF PosA( upper(ls_special_field),"USER ZIP"  ) > 0 and not lb_label THEN	
			if is_user_zip = "@zip"	then	
				select user_zip into :is_user_zip from security_users where user_id = :gs_user_id;
			end if
			ls_val = is_user_zip
	ELSEIF PosA( upper(ls_special_field), "USER PHONE"  ) > 0 and not lb_label THEN	
			if is_user_phone = "@phone" 	then	
				select user_phone into :is_user_phone from security_users where user_id = :gs_user_id;
			end if
			ls_val = is_user_phone
	ELSEIF PosA( upper(ls_special_field), "USER FAX"  ) > 0 and not lb_label THEN	
			if is_user_fax = "@fax" then
				select user_fax into :is_user_fax from security_users where user_id = :gs_user_id;
			end if
			ls_val = is_user_fax
	//Start Code Change ----11.03.2016
	ELSEIF PosA( ls_special_field, "HollowRectangle" ) > 0 THEN	//alfee 01.25.2011				
		ls_val = "HollowRectangle"						
	ELSEIF PosA( ls_special_field, "Rectangle" ) > 0 THEN						
		ls_val = "RECTANGLE"
//	ELSEIF PosA(ls_special_field,"Signature") > 0 THEN		// E-sign : added by long.zhang 06.15.2011
	ELSEIF lower(ls_special_field) = "signature"  THEN		// long.zhang 06.28.2013 Bug3480
		ls_val = "SIGNATURE"	
	ELSEIF PosA( ls_special_field, "Future Date" ) > 0 THEN //Start Code Change ----09.26.2011 #V12 maha - ability to add future date
		ls_val = mid(ls_special_field,12, posa(ls_special_field,"@",11) - 12)
		ld_futuredate = RelativeDate ( today(), integer(ls_val) )
		ls_val = String( ld_futuredate, "mm/dd/yyyy" )
	ELSE
		ls_val = ls_special_field
	END IF

	IF ls_val <> "" AND ls_val <> "RECTANGLE" AND ls_val <> "HollowRectangle" AND ls_val <> "SIGNATURE" THEN //alfee 01.25.2011	E-sign: Modified by long.zhang 06.15.2011
		iu_AppPainter.ole_edit.Object.AddAnnotationGroup( String(li_app_field_id) )			
		IF Upper(MidA( ls_val, 1, 6 )) = "LABEL-" THEN
			ls_val = MidA( ls_val, 7, 240 )   //Start Code Change ----08.26.2015 #V15 maha - ls_val = MidA( ls_val, 7, 100 )
		END IF			
		iu_AppPainter.ole_edit.object.AnnotationStampText( ls_val )
		iu_AppPainter.ole_edit.object.AnnotationFontColor( RGB(0,0,128) ) //RGB(0,0,128) )255 //maha101101
		iu_AppPainter.ole_edit.object.Annotationtype(8)
		CHOOSE CASE ids_AppField.GetItemNumber( sf, "font_size" )
			CASE 1
				iu_AppPainter.ole_edit.Object.AnnotationFont.Name = "MS Serif"
				iu_AppPainter.ole_edit.Object.AnnotationFont.Size = 7
			CASE 2
				iu_AppPainter.ole_edit.Object.AnnotationFont.Name = "Times New Roman"
				iu_AppPainter.ole_edit.Object.AnnotationFont.Size = 8				
			CASE 3
				iu_AppPainter.ole_edit.Object.AnnotationFont.Name = "Times New Roman"
				iu_AppPainter.ole_edit.Object.AnnotationFont.Size = 12				
		END CHOOSE
		IF ids_AppField.GetItemNumber( sf, "font_bold" ) = 1 THEN
			iu_AppPainter.ole_edit.Object.AnnotationFont.Bold = True
		ELSE
			iu_AppPainter.ole_edit.Object.AnnotationFont.Bold = False
		END IF					
		iu_AppPainter.ole_edit.object.Draw(li_x, li_y, 0, 0 )
	ELSEIF ls_val = "HollowRectangle" THEN //alfee 01.25.2011
		iu_AppPainter.ole_edit.Object.AddAnnotationGroup( String(li_app_field_id) )		
		iu_AppPainter.ole_edit.object.Annotationtype(3)		
		iu_AppPainter.ole_edit.object.Draw( li_x, li_y, li_box_width,li_box_height)					
	ELSEIF ls_val = "RECTANGLE" THEN //highlight
		iu_AppPainter.ole_edit.Object.AddAnnotationGroup( String(li_app_field_id) )		
		iu_AppPainter.ole_edit.object.Annotationtype(4)
		//Start Code Change ----06.19.2012 #V12 maha - get highlight color
		ll_color = of_highlight_color(ls_color)
		iu_AppPainter.ole_edit.object.AnnotationFillColor( ll_color )	
		//iu_AppPainter.ole_edit.object.AnnotationFillColor( 8454143 )	
		//End Code Change ----06.19.2012  
		iu_AppPainter.ole_edit.object.AnnotationFillStyle( 0 )									
		iu_AppPainter.ole_edit.object.Draw( li_x, li_y, li_box_width,li_box_height)
	ElSEIF ls_val = "SIGNATURE" THEN	//E-sign: Added by long.zhang 06.15.2011	
		ls_val = f_signature_download(il_prac)
		IF ls_val <> "None" THEN
			iu_AppPainter.ole_edit.Object.AddAnnotationGroup(String( li_app_field_id ))	
			iu_AppPainter.ole_edit.Object.AnnotationImage = ls_val
			iu_AppPainter.ole_edit.Object.AnnotationFillStyle(1)  //Start Code Change ----09.25.2012 #V12 maha - changed so annotation is not black when printing
			iu_AppPainter.ole_edit.Object.AnnotationType(5)
			iu_AppPainter.ole_edit.Object.Draw(li_x,li_y)
			iu_AppPainter.ole_edit.Object.SelectTool(1)
		END IF
	END IF
END FOR

Return 1
end function

public function integer of_getgroupdata (integer ai_screen_id);//====================================================================
// $<function> of_getgroupdata()
// $<arguments>
//		integer	ai_screen_id
// $<returns> integer
// $<description> N/A
// $<add> (Appeon) evan 11.08.2011
//====================================================================

if ai_screen_id >= 80 and ai_screen_id < 90 then
	ib_group = true
	if ids_ScreenAddress.rowcount() < 1 then
		inv_de_functions.of_create_dynamic_ds( il_prac, 1, 2, ids_ScreenAddress, ii_facility_id, sqlca )
	end if
	if ids_ScreenAddress.rowcount() < 1 then Return -1
else
	ib_group = false
end if
		
Return 1
end function

public function integer of_getscreendata (integer ai_screen_id);//====================================================================
// $<function> of_getscreendata()
// $<arguments>
//		integer	ai_screen_id
// $<returns> integer
// $<description> N/A
// $<add> (Appeon) evan 11.08.2011
//====================================================================

integer li_Count
integer li_scr_index
integer s  //maha 11.10.2016
string ls_sort_add_field[] //maha 11.10.2016

is_sort_syntax = ""
li_Count = UpperBound(ii_scr_array)

FOR li_scr_index = 1 to li_Count
	IF ii_scr_array[li_scr_index] = ai_screen_id THEN
		ids_ScreenData = ids_ScreenDataAll[li_scr_index]
		is_sort_syntax = is_sort_arr[li_scr_index]
		EXIT
	END IF
END FOR

IF li_scr_index > UpperBound(ii_scr_array) THEN
	inv_de_functions.of_create_dynamic_ds( il_prac, 1, ai_screen_id, ids_ScreenData, ii_facility_id, sqlca )
	is_sort_syntax = inv_de_functions.is_sort_syntax
END IF

//Start Code Change ----11.10.2016 #V153 maha - resort if using lookups for sort
ls_sort_add_field = inv_de_functions.is_sort_lookup_fields

if  upperbound(ls_sort_add_field) > 0 then
	//ls_sort_name = ""
	//set display values
	for s = 1 to upperbound(ls_sort_add_field)
		//of_evaluate_sort( ids_ScreenData, ls_sort_add_field[s] )
	next
end if
//Start Code Change ----11.10.2016

//messagebox("",  ids_ScreenData.rowcount())
ids_ScreenData.SetFilter("")
ids_ScreenData.Filter()
if ib_group = false then
	IF ids_ScreenData.RowCount() = 0 THEN Return -1
end if
		
Return 1
end function

public function integer of_getappfielddata (integer ai_screen_id, integer ai_page);//====================================================================
// $<function> of_getappfielddata()
// $<arguments>
//		integer	ai_screen_id
//		integer	ai_page
// $<returns> integer
// $<description> N/A
// $<add> (Appeon) evan 11.08.2011
//====================================================================

integer li_AppFieldCount

// Get screen fields
ids_ScreenField.SetFilter( "data_view_fields_screen_id = " + string(ai_screen_id) )
ids_ScreenField.Filter()
IF ids_ScreenField.RowCount() = 0 THEN Return -1
ii_table_id = ids_ScreenField.GetItemNumber( 1, "table_id" )

// Get application fields
IF ai_screen_id = 27 THEN //trap for personal data screen
	ids_AppField.SetFilter("table_id = " + string( ii_table_id ) + " and page = " + string(ai_Page) + " and personal_data = 'Y'")
Else
	ids_AppField.SetFilter("table_id = " + string( ii_table_id ) + " and page = " + string(ai_Page) + " and personal_data = 'N'")
End If
ids_AppField.Filter()
li_AppFieldCount = ids_AppField.RowCount()

Return li_AppFieldCount
end function

public function integer of_drawconnectfields (integer ai_page);//====================================================================
// $<function> of_drawconnectfields()
// $<arguments>
//		integer	ai_page
// $<returns> integer
// $<description> Draw connected fields
// $<add> (Appeon) evan 11.09.2011
//====================================================================

Integer li_sort_cnt
Integer c, li_field_cnt
Integer li_anc_calc_field
Integer li_temp_calc_field
Integer li_cal_field_id
Integer li_x
Integer li_y
Integer li_font
Integer li_width
Integer li_height
Integer li_bold
Boolean lb_lastconn
String ls_calc_field
Long li_app_field_id

// Get connected fields of current page
ids_AppField.SetFilter("page = " + string(ai_Page) + " and connect_field_id > 0 ")
ids_AppField.Filter()
li_field_cnt = ids_AppField.RowCount()
IF li_field_cnt < 1 THEN
	iu_AppPainter.ole_edit.object.Annotationtype(11)	//added by long.zhang 04.13.2012
	Return 1
END IF	

// Sort connected fields
ids_AppField.SetSort("connect_field_id, connect_field_sort")
ids_AppField.Sort()

// Loop connected fields processing
FOR c = 1 TO li_field_cnt
	lb_lastconn = false
	li_cal_field_id = ids_AppField.GetItemNumber( c, "connect_field_id" )
	
	IF li_temp_calc_field <> li_cal_field_id THEN //new connect field
		li_anc_calc_field = ids_AppField.GetItemNumber( c, "app_field_id" )
		li_temp_calc_field = li_cal_field_id
		ls_calc_field = ""
		li_x = ids_AppField.GetItemNumber( c, "x_pos" ) - 5
		li_y = ids_AppField.GetItemNumber( c, "y_pos" )
		li_font = ids_AppField.GetItemNumber( c, "font_size" )	
		li_width = ids_AppField.GetItemNumber( c, "annotation_width" )
		li_height = ids_AppField.GetItemNumber( c, "height" )
		IF ids_AppField.GetItemNumber(c , "font_bold" ) = 1 THEN
			li_bold = 1
		ELSE
			li_bold = 0
		END IF
		li_sort_cnt = 0
	else //maha 4.10.07  identify  last field of a group
		if c < li_field_cnt then
			if li_cal_field_id <> ids_AppField.GetItemNumber( c + 1, "connect_field_id" ) then
				lb_lastconn  = true
			end if
		end if
	END IF
	li_sort_cnt ++
	li_app_field_id = ids_AppField.GetItemNumber( c, "app_field_id" )
	iu_AppPainter.ole_edit.Object.SelectAnnotationGroup( "" )
	iu_AppPainter.ole_edit.Object.SelectAnnotationGroup( String( li_app_field_id ) )
	iu_AppPainter.ole_edit.Object.DeleteAnnotationGroup( String( li_app_field_id ) )
	ls_calc_field = ls_calc_field + " " + is_data_value[ li_cal_field_id, li_sort_cnt ]

	// Draw connected fields
	IF c = li_field_cnt OR lb_lastconn then
		iu_AppPainter.ole_edit.Object.AddAnnotationGroup( String(li_anc_calc_field) )
		iu_AppPainter.ole_edit.object.AnnotationStampText( ls_calc_field )
		iu_AppPainter.ole_edit.object.AnnotationFontColor( RGB(0,0,128) )
		iu_AppPainter.ole_edit.object.Annotationtype(8)
		CHOOSE CASE li_font
			CASE 1
				iu_AppPainter.ole_edit.Object.AnnotationFont.Name = "MS Serif"
				iu_AppPainter.ole_edit.Object.AnnotationFont.Size = 7
			CASE 2
				iu_AppPainter.ole_edit.Object.AnnotationFont.Name = "Times New Roman"
				iu_AppPainter.ole_edit.Object.AnnotationFont.Size = 8
			CASE 3
				iu_AppPainter.ole_edit.Object.AnnotationFont.Name = "Times New Roman"
				iu_AppPainter.ole_edit.Object.AnnotationFont.Size = 12
		END CHOOSE
		IF li_bold = 1 THEN
			iu_AppPainter.ole_edit.Object.AnnotationFont.Bold = True
		ELSE
			iu_AppPainter.ole_edit.Object.AnnotationFont.Bold = False
		END IF
		iu_AppPainter.ole_edit.object.Draw(li_x, li_y, li_width, li_height)
		ib_page_populated[ ai_Page ] = True
	END IF
END FOR

iu_AppPainter.ole_edit.object.Annotationtype(11)
Return 1
end function

public function integer of_saveimage ();//====================================================================
// $<function> of_saveimage()
// $<arguments>
// $<returns> integer
// $<description> Display image
// $<add> (Appeon) evan 11.09.2011
//====================================================================

string ls_Rtn

ls_Rtn = f_ExaWriteRight(iu_AppPainter.ole_edit.Object.Image)
if LenA(ls_Rtn) > 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
else
	iu_AppPainter.ole_edit.Object.Save()
end if

Return 1
end function

public function integer of_additionalpageproc ();//====================================================================
// $<function> of_additionalpageproc()
// $<arguments>
// $<returns> integer
// $<description> Additional pages processing
// $<add> (Appeon) evan 11.09.2011
//====================================================================

integer li_count
integer ap, li_Page
integer li_noblank = 0
integer li_delete_p = 0
integer li_add_page[]
string ls_add_pages
string ls_blankpage
n_appeon_download lnv_down

// Get additional pages
IF ids_App.RowCount() > 0 THEN
	ls_add_pages = ids_App.GetItemString( 1, "additional_info_pages" )
END IF
IF LenA( ls_add_pages ) > 0 THEN
	IF PosA( ls_add_pages, "," ) = 0 THEN
		IF MidA( ls_add_pages, 1, 1 ) = "A" THEN
			li_add_page[ 1 ] = Integer( MidA( ls_add_pages, 2, 10 ) )
		ELSE
			li_add_page[ 1 ] = Integer( ls_add_pages )
		END IF
	ELSE
		DO WHILE TRUE
			li_count++
			IF MidA( ls_add_pages, 1, 1 ) = "A" THEN
				li_add_page[li_count] = Integer( MidA( ls_add_pages, 2, PosA( ls_add_pages, "," ) -1) )				
			ELSE
				li_add_page[li_count] = Integer( MidA( ls_add_pages, 1, PosA( ls_add_pages, "," ) -1) )
			END IF			
			ls_add_pages = MidA( ls_add_pages, PosA( ls_add_pages, "," ) +1, 1000 )				
			
			IF PosA( ls_add_pages, "," ) = 0 THEN
				li_count++
				IF MidA( ls_add_pages, 1, 1 ) = "A" THEN
					li_add_page[li_count] = Integer( MidA( ls_add_pages, 2, 10 ) )
				ELSE
					li_add_page[li_count] = Integer( ls_add_pages )					
				END IF			
				Exit
			END IF			
		LOOP
	END IF
END IF

// Additional pages processing
if ib_single_page = false then ////Start Code Change ----1.25.2008 #V8 maha - skip this if a single page from mapping
	IF LenA( ls_add_pages ) > 0  THEN		
		if LenA(gs_app_image_path) < 1 then gs_app_image_path = gnv_data.of_getitem("ids","intelliapp_app_path",false) //Start Code Change ---- 01.25.2008 #V8 maha
		ls_blankpage=of_check_path(gs_app_image_path,1)
		ls_blankpage=ls_blankpage+ "blankpage.tif" 

		If appeongetclienttype() = 'PB' Then
			If not fileexists(ls_blankpage) Then 
				//------------------- APPEON BEGIN -------------------
				//$<modify> Stephen 02.28.2013
				//$<reason> Bug 3425 -Mapping is missing from the application
				/*
				Messagebox('File',ls_blankpage +  " file is missing.")
				li_noblank = -1
				*/
				ls_blankpage = gs_current_path + "\blankpage.tif"
				if not fileexists(ls_blankpage) Then lnv_down.of_downloadfile("" ,ls_blankpage)
				if not fileexists(ls_blankpage) Then
					Messagebox('File',ls_blankpage +  " file is missing.")
					li_noblank = -1
				end if
				//------------------- APPEON END -------------------	
			end if
		Else
			if not fileexists(ls_blankpage) Then lnv_down.of_downloadfile("" ,ls_blankpage)
			if not fileexists(ls_blankpage) Then
				Messagebox('Download','Failed to download blankpage.tif file to ' + gs_app_image_path  + '.')
				li_noblank = -1
			end if
		End If
	
		if li_noblank = 0 then  //maha 0125508 trap for no blank page - don't display if filedoes not exist will crash
			iu_AppPainter.ole_edit.Object.Image(ls_blankpage ) 
			iu_AppPainter.ole_edit.Object.Page(1)
			iu_AppPainter.ole_edit.Object.Display()	
		end if
		iu_AppPainter.ole_admin.object.image( is_save_as )

		// Delete pages not populated
		FOR li_Page = 1 TO ii_to_page
			FOR ap = 1 TO UpperBound( li_add_page )
				IF li_Page = li_add_page[ ap ] AND NOT ib_page_populated[ li_Page ] THEN
					if iu_AppPainter.ole_admin.Object.PageCount() <= 1 then //maha012508 don't delete last page.//Evan 11.26.2010 --- Add '<' condition
						exit
					else
						iu_AppPainter.ole_admin.object.DeletePages( li_Page - li_delete_p, 1 )
						li_delete_p ++
					end if
				END IF
			END FOR
		END FOR
	
		If Not fileexists(is_save_as) Then //maha 012508 coded to not delete all pages so this should never happen.
			iu_AppPainter.ole_edit.Object.Image( ls_blankpage )
		Else
			iu_AppPainter.ole_edit.Object.Image( is_save_as )
		End If
	END IF
end if

// If it is blank page, the page need set to 1
If Not fileexists(is_save_as) Then
	iu_AppPainter.ole_edit.Object.Page( 1 )
Else
	If li_delete_p > 0 Then
		iu_AppPainter.ole_edit.Object.Page( 1 )
	Else
		iu_AppPainter.ole_edit.Object.Page( ii_from_page )
	End If
End If
iu_AppPainter.ole_edit.Object.FitTo(3)
iu_AppPainter.ole_edit.Object.Display()

Return 1
end function

public function integer of_drawobject (integer ai_page, integer ai_field, string as_data);//====================================================================
// $<function> of_drawobject()
// $<arguments>
//		integer	ai_page
//		integer	ai_field
//		string	as_data
// $<returns> integer
// $<description> Draw object
// $<add> (Appeon) evan 11.09.2011
//====================================================================

integer li_x
integer li_y
integer li_width
integer li_height
string ls_true_value
string ls_false_value
string ls_object_type
long li_app_field_id

// Get field properties
ls_object_type = ids_AppField.GetItemString(ai_Field, "box_type")
li_app_field_id = ids_AppField.GetItemNumber(ai_Field, "app_field_id")
li_x = ids_AppField.GetItemNumber(ai_Field, "x_pos")
li_y = ids_AppField.GetItemNumber(ai_Field, "y_pos")

// Draw object
CHOOSE CASE Upper(ls_object_type)
	CASE "T" // Text
		iu_AppPainter.ole_edit.Object.AddAnnotationGroup( String(li_app_field_id) )
		iu_AppPainter.ole_edit.object.AnnotationStampText( as_data + "    " )
		iu_AppPainter.ole_edit.object.AnnotationFontColor( RGB(0,0,128) )
		iu_AppPainter.ole_edit.object.Annotationtype(8)
		CHOOSE CASE ids_AppField.GetItemNumber(ai_Field, "font_size")
			CASE 1
				iu_AppPainter.ole_edit.Object.AnnotationFont.Name = "MS Serif"
				iu_AppPainter.ole_edit.Object.AnnotationFont.Size = 7
			CASE 2
				iu_AppPainter.ole_edit.Object.AnnotationFont.Name = "Times New Roman"
				iu_AppPainter.ole_edit.Object.AnnotationFont.Size = 8
			CASE 3
				iu_AppPainter.ole_edit.Object.AnnotationFont.Name = "Times New Roman"
				iu_AppPainter.ole_edit.Object.AnnotationFont.Size = 12			
		END CHOOSE
		IF ids_AppField.GetItemNumber(ai_Field, "font_bold") = 1 THEN
			iu_AppPainter.ole_edit.Object.AnnotationFont.Bold = True
		ELSE
			iu_AppPainter.ole_edit.Object.AnnotationFont.Bold = False
		END IF
		li_width = ids_AppField.GetItemNumber(ai_Field, "annotation_width")
		if  li_width > 255 then  li_width = 255
		li_height = ids_AppField.GetItemNumber(ai_Field, "height")
		iu_AppPainter.ole_edit.object.Draw(li_x, li_y, li_width, li_height)
		ib_page_populated[ ai_Page ] = True
		
	CASE "Y1"
		ls_true_value = ids_AppField.GetItemString(ai_Field, "box_yes_value")
		ls_false_value = ids_AppField.GetItemString(ai_Field, "box_no_value")
		IF ls_true_value = as_data THEN
			iu_AppPainter.ole_edit.Object.ShowAnnotationGroup( String( li_app_field_id ) + "YesBox")
		ELSEIF ls_false_value = as_data THEN
			iu_AppPainter.ole_edit.Object.ShowAnnotationGroup( String( li_app_field_id ) + "NoBox")															
		END IF
		
	CASE "C" // Checkbox
		ls_true_value = ids_AppField.GetItemString(ai_Field, "box_yes_value")
//		IF ( ls_true_value = as_data ) OR ( PosA( Upper(ls_true_value), "NOT NULL") > 0 AND LenA(as_data) >0) OR + & //long.zhang 01.17.2013 Bug3385
		IF ( Upper(ls_true_value) = Upper(as_data) ) OR ( PosA( Upper(ls_true_value), "NOT NULL") > 0 AND LenA(as_data) >0) OR + &	
			( (LenA(as_data) = 0 OR IsNull( as_data ) ) AND PosA( Upper(ls_true_value), "IS NULL") > 0 ) THEN
			iu_AppPainter.ole_edit.Object.AddAnnotationGroup( String(li_app_field_id) )
			iu_AppPainter.ole_edit.object.AnnotationStampText( "X" )
			iu_AppPainter.ole_edit.object.AnnotationFontColor( RGB(0,0,128) )
			iu_AppPainter.ole_edit.object.Annotationtype(8)
			CHOOSE CASE ids_AppField.GetItemNumber(ai_Field, "font_size")
				CASE 1
					iu_AppPainter.ole_edit.Object.AnnotationFont.Name = "MS Serif"
					iu_AppPainter.ole_edit.Object.AnnotationFont.Size = 7
				CASE 2
					iu_AppPainter.ole_edit.Object.AnnotationFont.Name = "Times New Roman"
					iu_AppPainter.ole_edit.Object.AnnotationFont.Size = 8
				CASE 3
					iu_AppPainter.ole_edit.Object.AnnotationFont.Name = "Times New Roman"
					iu_AppPainter.ole_edit.Object.AnnotationFont.Size = 12			
			END CHOOSE
			IF ids_AppField.GetItemNumber(ai_Field, "font_bold") = 1 THEN
				iu_AppPainter.ole_edit.Object.AnnotationFont.Bold = True
			ELSE
				iu_AppPainter.ole_edit.Object.AnnotationFont.Bold = False
			END IF
			li_width = ids_AppField.GetItemNumber(ai_Field, "annotation_width")
			li_height = ids_AppField.GetItemNumber(ai_Field, "height")
			iu_AppPainter.ole_edit.object.Draw(li_x, li_y, li_width, li_height)
		END IF
END CHOOSE

Return 1
end function

public function integer of_sortscreendata ();//====================================================================
// $<function> of_sortscreendata()
// $<arguments>
// $<returns> integer
// $<description> Sort screen data
// $<add> (Appeon) evan 11.09.2011
//====================================================================

integer res
string ls_syntax  //maha 11.10.2016

//Start Code Change ----11.10.2016 #V153 maha = modified to refer to the local variable rather than the instance
ls_syntax = is_sort_syntax

IF LenA( ls_syntax ) > 0 THEN
	res = ids_ScreenData.SetSort(ls_syntax )
	//messagebox("", ls_syntax)
	if res = -1 then
		ls_syntax = "pd_address_rec_id A"
		res = ids_ScreenData.SetSort( ls_syntax )
		if res = -1 then
			ls_syntax = "pd_hosp_affil_rec_id A"
			res = ids_ScreenData.SetSort( ls_syntax)
		end if
	end if
	if res = -1 then  //maha tested in the create dynamic dw
		messagebox("Error sorting " ,is_sort_syntax)
	end if
	ids_ScreenData.Sort( )
END IF
//End Code Change ----11.10.2016

Return 1
end function

public function integer of_error_msg (long al_prac, integer ai_facil_id, long al_app_id, long al_app_field_id, integer ai_cur_page, string as_error, integer ai_err_hand);//====================================================================
// $<function> of_error_msg()
// $<arguments>
// $<returns> integer
// $<description> Error processing
// $<add> (Appeon) evan 11.09.2011
//====================================================================

long ll_rec_id

IF ai_err_hand = 1 THEN
	  ll_rec_id = gnv_app.of_Get_Id( "RECORD_ID" )
	 
	  if Len(as_error) > 100 then as_error = Left(as_error, 100)  //(Appeon) Added by Harry 09.29.2016 

	  INSERT INTO app_err_log  
		  ( prac_id,   
		  facility_id,   
		  app_id,   
		  app_fld_id,   
		  page_no,   
		  err_msg,   
		  rec_id )  
	  VALUES ( :al_prac,   
		  :ai_facil_id,   
		  :al_app_id,
		  :al_app_field_id,   
		  :ai_cur_page,   
		  :as_error,   
		  :ll_rec_id ) ;
ELSE
	MessageBox("Error", as_error)
END IF

Return 1
end function

public function string of_format (string as_value, string as_format);//Start Code Change ---- 06.02.2006 #496 maha //function added 06.02.06
string ls_ret
integer li_pos

li_pos = PosA(as_value," ",1)

choose case as_format
	case "Before Space"
		if li_pos > 0 then
			ls_ret = MidA(as_value,1,li_pos - 1)	
		else //if no space return the sent value
			ls_ret = as_value
		end if
	case "After Space"
		if li_pos > 0 then
			ls_ret = MidA(as_value,li_pos + 1)
		else
			ls_ret = as_value
		end if
	case "CAQH Code"  //Start Code Change ---- 02.23.2007 #V7 maha
		if LenA(as_value) = 1 then
			ls_ret = "00" + as_value
		elseif LenA(as_value) = 2 then
			ls_ret = "0" + as_value
		end if
	case "Last4"  //Start Code Change ---- 04.27.2010 #V10 maha
		ls_ret = RightA(as_value,4) 
	case else
		ls_ret = as_value
		
end choose


return ls_ret
end function

public function string of_get_luvalue (string as_link_type, string as_link_field, long al_lu_code);//Get value from the lookup table - alfee 09.08.2009
Long ll_findrow
String ls_lu_table, ls_value, ls_condition
String ls_notfound = '***NOT FOUND***'

IF IsNull(as_link_field) OR LenA(Trim(as_link_field)) < 1  THEN RETURN ls_notfound

CHOOSE CASE Upper(as_link_type)
	CASE 'C'
		ls_lu_table = 'code_lookup'
		//------------------------------------------------------------------------
		// 2.24.2016 RP added
		gnv_data.of_retrieveIfNecessary("code_lookup", FALSE)
		//------------------------------------------------------------------------
		ls_condition = "lookup_code = " + string(al_lu_code)		
		ll_findrow = gnv_data.ids_code_lookup.Find(ls_condition , 1, gnv_data.ids_code_lookup.rowcount())
		IF ll_findrow <= 0 THEN RETURN ls_notfound

		ls_value = gnv_data.of_getitem(ls_lu_table, as_link_field, ls_condition)		
	CASE 'A'
		//------------------------------------------------------------------------
		// 2.24.2016 RP added
		gnv_data.of_retrieveIfNecessary("address_lookup", FALSE)
		//------------------------------------------------------------------------
		ls_lu_table = 'address_lookup'		
		ls_condition = "lookup_code = " + string(al_lu_code)
		IF gnv_data.ids_address_lookup.RowCount() < 1 THEN 
			//gnv_data.of_retrieve(ls_lu_table)
			IF gnv_data.of_retrieve(ls_lu_table) = -1 THEN messagebox("Retrieve Error","Address lookup retrieve failed.") //trap error - alfee 04.15.2010
		END IF
		ll_findrow = gnv_data.ids_address_lookup.Find(ls_condition , 1, gnv_data.ids_address_lookup.rowcount())
		IF ll_findrow <= 0 THEN RETURN ls_notfound
		
		Choose Case Lower(as_link_field)
			case "code", "lookup_name", "entity_name", "city", "state", "zip", "country", "phone", "fax"
				ls_value = gnv_data.ids_address_lookup.getitemstring(ll_findrow,  as_link_field)
			case "custom_3", "custom_4", "custom_5", "custom_6","contact_name", "contact_salutation", "email_address", "web_address" 
				ls_value = gnv_data.ids_address_lookup.getitemstring(ll_findrow,  as_link_field)
			case "street1", "street2", " web_title", "audit_flag", "ic_c", "large_description_1", "large_description_2"
				ls_value = gnv_data.ids_address_lookup.getitemstring(ll_findrow,  as_link_field)
			case "lookup_code", "custom_1", "custom_2", "fee", "caqh_code", "ic_n", "money_1", "money_2" 
				ls_value = String(gnv_data.ids_address_lookup.getitemnumber( ll_findrow, as_link_field))
			case "integer_1", "integer_2", "integer_3", "integer_4", "integer_5", "integer_6", "integer_7", "integer_8"
				ls_value = String(gnv_data.ids_address_lookup.getitemnumber( ll_findrow, as_link_field))
			case "datetime_1", "datetime_2"
				ls_value = String(gnv_data.ids_address_lookup.getitemdatetime(ll_findrow,  as_link_field))
		End Choose			
	CASE 'Q'
		//------------------------------------------------------------------------
		// 2.24.2016 RP added
		gnv_data.of_retrieveIfNecessary("question_lookup", FALSE)
		//------------------------------------------------------------------------
		ls_lu_table = 'question_lookup'		
		ls_condition = "question_id = " + string(al_lu_code)	
		ll_findrow = gnv_data.ids_question_lookup.Find(ls_condition , 1, gnv_data.ids_question_lookup.rowcount())
		IF ll_findrow <= 0 THEN RETURN ls_notfound
		
		//------------------------------------------------------------------------
		// 2.24.2016 RP added
		gnv_data.of_retrieveIfNecessary("code_lookup", FALSE)
		//------------------------------------------------------------------------
		Choose Case Lower(as_link_field)
			Case "short_quest","full_quest"
				ls_value = gnv_data.ids_code_lookup.getitemstring(ll_findrow,  as_link_field)
			case "quest_type"
				ls_value = String(gnv_data.ids_code_lookup.getitemnumber( ll_findrow, as_link_field))
		End Choose
	CASE ELSE
		RETURN ls_notfound				
END CHOOSE

RETURN ls_value
end function

public function integer of_getfieldvalue (integer ai_field, ref string as_value);//====================================================================
// $<function> of_getfieldvalue()
// $<arguments>
//		value	integer	ai_field
//		ref	string	as_value
// $<returns> integer
// $<description> Get field value
// $<add> (Appeon) evan 11.10.2011
//====================================================================

string ls_object_type
string ls_link_type
string ls_field_type
string ls_data
string ls_error
string ls_link_field
string ls_find
string ls_format
string ls_default_val
String ls_lookup_name //Added by Appeon long.zhang 04.25.2017
integer li_retval
integer li_current_page = 1
integer li_use_default
integer li_width
integer li_array
long ll_found
long ll_data
long li_app_field_id
long ll_start
long li_cal_field_id
Long ll_field_id //Added by Appeon long.zhang 04.25.2017
Long ll_find //Added by Appeon long.zhang 04.25.2017
datetime ldt_data
datawindowchild dwchild

// Get field properties
ls_object_type = Upper(ids_AppField.GetItemString(ai_Field, "box_type"))
ls_link_type = ids_AppField.GetItemString(ai_Field, "lookup_link_type")
ls_field_type = ids_AppField.GetItemString(ai_Field, "field_type")
ls_link_field = Lower(ids_AppField.GetItemString(ai_Field, "lookup_link_field"))
li_app_field_id = ids_AppField.GetItemNumber(ai_Field, "app_field_id")
ls_format =	ids_AppField.GetItemString( ai_Field, "format" )
ll_start = ids_AppField.GetItemNumber(ai_Field, "start_char")
if isnull(ll_start) or ll_start = 0 then ll_start = 1

// Get field value
SetNull(as_Value)
IF ls_link_type = "A" OR ls_link_type = "C" or ls_link_type = "Q" THEN
	if ls_field_type = "C" THEN
		IF Not IsNumber( ids_ScreenData.GetItemString( ii_record_number, is_field_name ) ) THEN
			//------------------- APPEON BEGIN -------------------
			//<$>added:long.zhang 04.25.2017
			//<$>reason:Turn back to number lookup_code, For Issue: Trying to add affiliation status to application mapping
			//SetNull( ls_link_type )	
			ls_data = ids_ScreenData.GetItemString( ii_record_number, is_field_name )		
			If Not IsNull(ls_data) Then
				ll_field_id =  ids_AppField.GetItemNumber(ai_Field, "field_id")
				//Find Lookup_code of this field
				ll_find = ids_screenField.Find('field_id = ' + String(ll_field_id) +" and lookup_field = 'Y'", 1, ids_screenField.RowCount())
				If ll_find > 0 Then
					ls_lookup_name = ids_screenField.GetItemString(ll_find, 'lookup_code')
					ll_data = of_get_lucode_by_code(ls_link_type, ls_lookup_name, ls_data	)
				End If
			Else
				SetNull( ls_link_type )	
			End If			
			//------------------- APPEON END -------------------			
		ELSE
			ll_data = Long( ids_ScreenData.GetItemString( ii_record_number, is_field_name ) )
		END IF
	ELSE
		ll_data = ids_ScreenData.GetItemNumber( ii_record_number, is_field_name )
	end if
	
	li_retval = ids_ScreenData.GetChild( is_field_name, dwchild )	
	IF li_retval = -1 THEN
		ls_error = "Getchild Error (function of_set_up)  Field ID (" + String( li_app_field_id ) + ") " + "  Could not find dwchild data. ~rRetrain the " + is_screen_name + ", " + is_field_name + " Field.  ~n Check to see that the field is visible in the default view."
		of_error_msg( il_prac, ii_facility_id, ii_app_id, li_app_field_id, li_current_page, ls_error, ii_err_handling)
		Return -1
	END IF

	IF NOT IsNull( ll_data ) THEN
		ls_data = of_get_luvalue(ls_link_type, ls_link_field, ll_data)
		IF ls_data = '***NOT FOUND***' THEN
			ls_error = "Error in of_setup doing find (" + string(ll_found) + "):   Field ID (" + String( li_app_field_id ) + ")" + "  Could not find dwchild data Message #2. ~rTry retraining the " + is_screen_name + ", " + is_field_name + " field.  Find: " + ls_find 					
			of_error_msg( il_prac, ii_facility_id, ii_app_id, li_app_field_id, li_current_page, ls_error, ii_err_handling)
			Return -1
		END IF
		if upper(ls_link_field)  = "CAQH_CODE" then
			if LenA(ls_data) = 1 then 
				ls_data = "00" + ls_data
			elseif LenA(ls_data) = 2 then 
				ls_data = "0" + ls_data
			end if
		end if
	END IF
	ls_data = of_format(ls_data,ls_format)
	
ELSE //field should not be a lookup field
	CHOOSE CASE Upper( ls_field_type )
	CASE "C"	//string
		ls_data = RightTrim(ids_ScreenData.GetItemString( ii_record_number, is_field_name )) //evan 03.04.2011---added RightTrim
		ls_data = of_format(ls_data,ls_format) //Start Code Change ---- 05.31.2006 #497 maha
	CASE "D"	//date
		ldt_data = ids_ScreenData.GetItemDateTime( ii_record_number, is_field_name )						
		CHOOSE CASE Upper(ls_format)
			CASE "DATE(MM/DD/YYYY)"
				ls_data = String( ldt_data, 'mm/dd/yyyy')
			CASE "DATE(MM/DD/YY)"
				ls_data = String( ldt_data, 'mm/dd/yy')
			CASE "DATE(MM-DD-YYYY)"
				ls_data = String( ldt_data, 'mm-dd-yyyy')
			CASE "DATE(MM-DD-YY)"
				ls_data = String( ldt_data, 'mm-dd-yy')
			CASE "DATE(MM/YYYY)"
				ls_data = String( ldt_data, 'mm/yyyy')
			CASE "DATE(MMYYYY)"
				ls_data = String( ldt_data, 'mmyyyy')
			CASE "DATE(MMDDYYYY)"
				ls_data = String( ldt_data, 'mmddyyyy')
				CASE "DATE(MM)"
					ls_data = String( ldt_data, 'mm')
				CASE "DATE(DD)"
					ls_data = String( ldt_data, 'dd')
				CASE "DATE(YYYY)"
					ls_data = String( ldt_data, 'yyyy')
				CASE "DATE(YYYYMM)"
					ls_data = String( ldt_data, 'yyyymm')
				CASE "DATE(YYYYMMDD)"
					ls_data = String( ldt_data, 'yyyymmdd')
				CASE "DATE(YYYY-MM-DD)"
					ls_data = String( ldt_data, 'yyyy-mm-dd')
				CASE "DATE(YYYY/MM/DD)"
					ls_data = String( ldt_data, 'yyyy/mm/dd')
				CASE "DATE(YYYY/MM)"
					ls_data = String( ldt_data, 'yyyy/mm/dd')
			CASE ELSE
				ls_data = String( ldt_data, 'mm/dd/yyyy')
		END CHOOSE
	CASE "N", "I" //number
		IF Upper( ls_format ) = "MONEY" THEN
			ls_data = String(ids_ScreenData.GetItemNumber( ii_record_number, is_field_name ), '$###,###,###')
		Elseif is_field_name = "active_status"  or is_field_name = "pd_address_active_status"   &
			or is_field_name = "pd_hosp_affil_active_status" then //Added pd_address_active_status,pd_hosp_affil_active_status by Appeon long.zhang 09.19.2014 (Bug 4228 created for Case# 00049941: Mapper )

			ls_data = String(ids_ScreenData.GetItemNumber( ii_record_number, is_field_name ))
			if is_screen_name = "Affiliation Status" then
				choose case ls_data
					case "1"
						ls_data = "Active"
					case "0"
						ls_data = "History"
					case "3"
						ls_data = "Inactive"
					case "4"
						ls_data = "Pending"
				end choose
			else
				choose case ls_data
					case "1"
						if ls_format = "Status-Y" then //this is a format to override Active/Inactive
							ls_data = "Yes"
						else
							ls_data = "Active"
						end if
					case "0"
						if ls_format = "Status-Y" then
							ls_data = "No"
						else
							ls_data = "Inactive"
						end if
					case "2"
						ls_data = "Historical"
				end choose
			end if
		ELSE
			ls_data = String(ids_ScreenData.GetItemNumber( ii_record_number, is_field_name ))										
		END IF
	END CHOOSE
END IF

// Set default value if data is null
IF ( IsNull( ls_data ) OR Trim( ls_data ) = "" ) AND ls_object_type <> "C" THEN
	li_use_default = ids_AppField.GetItemnumber(ai_Field, "use_default")
	ls_default_val = ids_AppField.GetItemstring(ai_Field, "default_val")
	if li_use_default = 1 and LenA(ls_default_val ) > 0 then
		ls_data = ls_default_val
	else
		Return -1
	end if
END IF

// Is Text
IF ls_object_type = "T" THEN
	CHOOSE CASE Upper(ls_format)
		CASE "PHONE"
			IF PosA( ls_data, "-" ) = 0 AND PosA( ls_data, "(" ) = 0 THEN
				IF LenA( ls_data) = 10 THEN
					ls_data = "(" + MidA( ls_data, 1, 3 ) + ")" + MidA( ls_data, 4, 3 ) + "-" + MidA( ls_data, 7, 4 )
				ELSE
					ls_data = MidA( ls_data, 1, 3 ) + "-" + MidA( ls_data, 4, 4 )
				END IF
			END IF
		CASE "SS#"
			ls_data = MidA( ls_data, 1, 3 ) + "-" + MidA( ls_data, 4, 2 ) + "-" + MidA( ls_data, 6, 4 )
	END CHOOSE
	li_width = ids_AppField.GetItemNumber(ai_Field, "width")
	if isnull(li_width) then li_width = 1000  //Start Code Change ----02.13.2012 #V12 maha - added trap for null value
	ls_data = MidA( ls_data, ll_start, li_width )

	li_cal_field_id = ids_AppField.GetItemNumber(ai_Field, "connect_field_id")
	IF li_cal_field_id > 0 THEN
		li_array = ids_AppField.GetItemNumber(ai_Field, "connect_field_sort")
		is_data_value[ li_cal_field_id, li_array ] = RightTrim(ls_data)
	END IF
	IF IsNull( ls_data ) THEN
		ls_data = ""
	END IF
END IF

as_Value = ls_Data

Return 1
end function

public function string of_billing_address (n_ds ads_detail, string as_query, integer ai_record_number, integer ai_screen);string ls_ret_query
string ls_fld_nm
integer li_retval
integer li_de_row_cnt
long ll_billing_address_id

// FILTER the address data and find the billing address record
ads_detail.setFilter(as_query)
li_retval = ads_detail.Filter( )	
ads_detail.sort( )
IF li_retval = -1 THEN
//	ls_error = "Field ID (" + String( li_app_field_id ) + ")" + "Error during Filter()"
	//of_error_msg( ll_prac, facility_id, ii_app_id, li_app_field_id, li_current_page, ls_error, li_err_handling)							
END IF
//debugbreak()							
li_de_row_cnt = ads_detail.RowCount()
//skip if looking for a record number greater than the number of filtered rows
IF ai_record_number > ads_detail.RowCount() THEN
	return "CONTINUE"
END IF

//check to find out how the field is named in the dw
IF ads_detail.Describe( "pd_address_billing_address_id.color" ) = '0' THEN
	ls_fld_nm = "pd_address_billing_address_id"
ELSE
	ls_fld_nm = "billing_address_id"						
END IF
//GET BILLING address id from the DS

ll_billing_address_id = ads_detail.GetItemNumber( ai_record_number, ls_fld_nm )
IF ll_billing_address_id > 0 THEN					
	IF ai_screen = 2 THEN
			//test to see what field name to use
		IF ads_detail.Describe( "pd_address_rec_id.color" ) = '0' THEN
			ls_fld_nm = "pd_address_rec_id"
		ELSE
			ls_fld_nm = "rec_id"						
		END IF
		//refilter address data based on billing address id
		ls_ret_query = ls_fld_nm  + " = " + String( ll_billing_address_id ) 
	ELSEIF ai_screen = 31 THEN  //Detail 2 screen
		//test to see what field name to use							
		IF ads_detail.Describe( "pd_address_2_rec_id.color" ) = '0' THEN
			ls_fld_nm = "pd_address_2_rec_id"
		ELSE
			ls_fld_nm = "rec_id"						
		END IF										
		ls_ret_query =  ls_fld_nm + " = " + String( ll_billing_address_id ) 
	END IF
//Start Code Change ----01.20.2010 #V10 maha
elseif ll_billing_address_id = 0 THEN	//set to Same on DE screen 
	return "SAME"	
else //this would be null or -1 (N/A)
	return "CONTINUE"
//End Code Change---01.20.2010
end if


return ls_ret_query
end function

public function integer of_filterscreendata (integer ai_screen_id, integer ai_field, string as_query);//====================================================================
// $<function> of_filterscreendata()
// $<arguments>
//		integer	ai_screen_id
//		integer	ai_field
//		string	as_query
// $<returns> integer
// $<description> Filter screen data
// $<add> (Appeon) evan 11.10.2011
//====================================================================

string ls_mess
string ls_error
string ls_billing_query
integer li_retval
integer li_current_page = 1
integer li_billing_flag
integer li_de_row_cnt
long li_app_field_id

// Get field properties
li_billing_flag = ids_AppField.GetItemNumber(ai_Field, "billing_address_flag")
li_app_field_id = ids_AppField.GetItemNumber(ai_Field, "app_field_id")

// Set filter query
IF LenA( as_query ) > 0 then
	if isnull(as_query) then as_query = ""
	if LenA(is_past_filter) > 0 then as_query = as_query + " and  " + is_past_filter
	
	//ADDRESS screen filter
	if ai_screen_id = 2 or ai_screen_id = 31 then
		//SETFILTER
		li_retval = ids_ScreenData.SetFilter( as_query )
		IF li_retval = -1 THEN
			ls_error = "Field ID (" + String( li_app_field_id ) + ")" + "Error during SetFilter()  " + as_query						
			of_error_msg( il_prac, ii_facility_id, ii_app_id, li_app_field_id, li_current_page, ls_error, ii_err_handling)
		END IF
		//BILLING flag filter added to existing query
		if li_billing_flag = 1 THEN
			ls_billing_query = of_billing_address( ids_ScreenData, as_query, ii_record_number, ai_screen_id)
			if ls_billing_query = "CONTINUE" then
				Return -1
			elseif ls_billing_query = "SAME" then
				//if same do not reset the filter query
			elseif ls_billing_query = "ERROR" then
				ls_error = "Field ID (" + String( li_app_field_id ) + ")" + "Error during Billing Address SetFilter()  " + as_query						
				of_error_msg( il_prac, ii_facility_id, ii_app_id, li_app_field_id, li_current_page, ls_error, ii_err_handling)
			elseif LenA(ls_billing_query) > 1 then
				as_query = ls_billing_query
				li_retval = ids_ScreenData.SetFilter(as_query )
				ii_record_number = 1  //Start Code Change ----02.01.2008 #V8 maha // there should only be one record once filtered
			end if
		END IF
	elseif ai_screen_id = 65 then
		if LenA(as_query) > 0 then
			as_query+= " and active_status = 1"
		else
			as_query = " and active_status = 1"
		end if
		li_retval = ids_ScreenData.SetFilter(as_query )
	else
		li_retval = ids_ScreenData.SetFilter(as_query )
	end if	

ELSEIF ai_screen_id = 43 then //affil status
	as_query = " parent_facility_id = " + string(ii_facility_id) + "  and active_status = 1"  //Start Code Change ----05.25.2011 #V11 maha - changed variable
	li_retval = ids_ScreenData.SetFilter(as_query )
	
ELSEIF ai_screen_id = 32 or ai_screen_id = 44 then //dept or staff cat
	//---------Begin Modified by (Appeon)Stephen 10.27.2017 for Application Mapping Error--------
	//as_query = " facility_id = " + string(ii_facility_id) + "  and active_status = 1"
	as_query = " 1=1 "
	if ids_ScreenData.describe("facility_id.coltype") <> "!" then
		as_query = " facility_id = " + string(ii_facility_id) 
	end if
	if ids_ScreenData.describe("active_status.coltype") <> "!" then
		as_query = as_query + "  and active_status = 1"
	end if	
	//---------End Modfiied ------------------------------------------------------
	li_retval = ids_ScreenData.SetFilter(as_query )

ELSE
	as_query = ""
	IF is_past_filter = "" THEN	
		li_retval = ids_ScreenData.SetFilter( "" )
	ELSE
		li_retval = ids_ScreenData.SetFilter( is_past_filter )
	END IF
END IF //end SET FILTER QUERY

if li_retval < 1 then
	//messagebox("", ls_error)  //Commented by (Appeon)Stephen 03.20.2015 - Allegheny Pop-up message in Application Mapping Case# 52524- Bug#4451
	ls_error = "Field ID (" + String( li_app_field_id ) + ")" + "Error during final SetFilter()  " + as_query						
	of_error_msg( il_prac, ii_facility_id, ii_app_id, li_app_field_id, li_current_page, ls_error, ii_err_handling)
end if
ids_ScreenData.Filter()
li_de_row_cnt = ids_ScreenData.RowCount()
if gi_test_mode = 1 then
	ls_mess = "Screen: " + is_screen_name + "~rField : " + is_field_name + "~rSort: " + is_sort_syntax + "~rFilter: " + as_query + "~rRecord count: " + string(li_de_row_cnt) + "~rRecord #: " + string(ii_record_number) + "~rApp Field Id: " + string(li_app_field_id) 
	messagebox("Map Data:" + string(li_app_field_id) ,ls_mess)
end if
IF ii_record_number > li_de_row_cnt THEN
	Return -1
END IF

// Sort screen data
of_SortScreenData()
			
Return 1
end function

public function integer of_correctfieldname (integer ai_screen_id, integer ai_field);//====================================================================
// $<function> of_correctfieldname()
// $<arguments>
//		integer	ai_screen_id
//		integer	ai_field
// $<returns> integer
// $<description> N/A
// $<add> (Appeon) evan 11.10.2011
//====================================================================

string ls_error
long li_app_field_id
integer li_current_page = 1

IF ai_screen_id = 2 THEn
	is_field_name = of_field_name( 2, is_field_name)
ELSEIF ai_screen_id = 31 THEN
	is_field_name = of_field_name( 31, is_field_name)
ELSEIF ai_screen_id = 10 THEN
	is_field_name = of_field_name( 10, is_field_name)
END IF

li_app_field_id = ids_AppField.GetItemNumber(ai_Field, "app_field_id")
if ids_ScreenData.Describe(is_field_name + ".coltype") = "!" then
	ls_error = "Field ID (" + String( li_app_field_id ) + ")" + " Invalid field name ( " + is_field_name + " ) for data store"
	of_error_msg( il_prac, ii_facility_id, ii_app_id, li_app_field_id, li_current_page, ls_error, ii_err_handling)
	Return -1
end if

if ii_AppType = TIF_FORM then
	iu_AppPainter.st_2.text = is_field_name + " (" + String( li_app_field_id ) + ")"
end if

Return 1
end function

public function string of_field_name (integer ai_screen, string as_field);string ls_field


IF ai_screen = 2 THEN
  	ls_field =  "pd_address_" + as_field
ELSEIF ai_screen = 31 THEN
   ls_field =  "pd_address_2_" + as_field
ELSEIF ai_screen = 10 THEN
  	ls_field =  "pd_hosp_affil_" + as_field
ELSE
	ls_field = as_field
END IF


return ls_field
end function

public function string of_address_query (string as_type);//Start Code Change ---- 02.01.2006 #232 maha
//Query created 013106 maha called from of_setup()

string ls_query
long ll_rec_id
string ls_error


CHOOSE CASE (as_type )
	//primary office
	CASE "647"
		ls_query = "pd_address_link_primary_office = 1"
	//additional office
	CASE "256"
		ls_query = "pd_address_link_additional_office = 1"
	//home addrss
	CASE "648"
		ls_query = "pd_address_link_home_address =  1"
	CASE "24472"
		ls_query = "pd_address_link_billing =  1"					
	CASE "24477"
		ls_query = "pd_address_link_mailing =  1"	
	case "24490"
		ls_query = "pd_address_link_exp_letters =  1"
	CASE ELSE
		ls_query = "ERROR"			
END CHOOSE
	
return ls_query
//End Code Change---02.01.2006
end function

public function integer of_groupdataprocess (integer ai_screen_id, integer ai_field);//====================================================================
// $<function> of_groupdataprocess()
// $<arguments>
//		integer	ai_screen_id
//		integer	ai_field
// $<returns> integer
// $<description> Group data processing
// $<add> (Appeon) evan 11.10.2011
//====================================================================

string ls_error
string ls_addr_query_val
string ls_addr_query_fld
string ls_addr_query_op
string ls_addr_group_query
string ls_group_billing_query
long ll_addr_group_recno
long li_app_field_id
long ll_gpid
integer li_addr_billing
integer li_retval
integer li_de_row_cnt
integer li_current_page = 1

if ib_group = false then Return 1

// Get field properties
ls_addr_query_val = ids_AppField.GetItemString(ai_Field, "query_value_addr")
ls_addr_query_fld = ids_AppField.GetItemString(ai_Field, "query_field_addr")
ls_addr_query_op = ids_AppField.GetItemString(ai_Field, "query_operator_addr")
ll_addr_group_recno = ids_AppField.GetItemnumber(ai_Field, "record_num_addr")
li_app_field_id = ids_AppField.GetItemNumber(ai_Field, "app_field_id")
li_addr_billing =  ids_AppField.GetItemNumber(ai_Field, "billing_link_addr")

// First do the address get and filter
if LenA(ls_addr_query_val) > 0 then
	IF Upper( ls_addr_query_fld ) = "ADDRESS_TYPE" THEN
		ls_addr_group_query = of_address_query(ls_addr_query_val)
		if ls_addr_group_query = "ERROR" then
			ls_addr_group_query = ""
			ls_error = "Field ID (" + String( li_app_field_id ) + ")" + "Unknown address type for filtering for Group data. (" + ls_addr_query_val + ")" 
			of_error_msg( il_prac, ii_facility_id, ii_app_id, li_app_field_id, li_current_page, ls_error, ii_err_handling)
		end if
	else
		ls_addr_query_fld = of_field_name( 2, ls_addr_query_fld)
		ls_addr_group_query = ls_addr_query_fld + ls_addr_query_op + ls_addr_query_val
	end if
	ids_ScreenAddress.setfilter(ls_addr_group_query)
end if

if li_addr_billing = 1 THEN
	ls_group_billing_query = of_billing_address( ids_ScreenAddress, ls_addr_group_query, ll_addr_group_recno, 2)
	if ls_group_billing_query = "CONTINUE" then
		Return -1
	elseif ls_group_billing_query = "ERROR" then
		ls_error = "Field ID (" + String( li_app_field_id ) + ")" + " Error getting Group Billing Address  "
		of_error_msg( il_prac, ii_facility_id, ii_app_id, li_app_field_id, li_current_page, ls_error, ii_err_handling)
	else
		if ls_group_billing_query = "SAME" then
			ls_group_billing_query = ls_addr_group_query
		else // For specific found group
			ll_addr_group_recno = 1
		end if 
		li_retval = ids_ScreenAddress.SetFilter(ls_group_billing_query)
		if li_retval < 0 then  
			ls_error = "Field ID (" + String( li_app_field_id ) + ")" + " Setfilter Error during Group Billing Address SetFilter()  " + ls_group_billing_query						
			of_error_msg( il_prac, ii_facility_id, ii_app_id, li_app_field_id, li_current_page, ls_error, ii_err_handling)
		end if
	
		ids_ScreenAddress.Filter()
		// After the filter there should be one row
		if ids_ScreenAddress.rowcount()  > 0 then
			ll_gpid = ids_ScreenAddress.getitemnumber(ll_addr_group_recno,"pd_address_gp_id")
		else
			ll_gpid = 0
		end if
	end if
else
	ids_ScreenAddress.filter()
	if ll_addr_group_recno <= ids_ScreenAddress.rowcount() then
		ll_gpid = ids_ScreenAddress.getitemnumber(ll_addr_group_recno,"pd_address_gp_id")
	else
		ll_gpid = 0
	end if
end if

// Now get the group data
il_prac = ll_gpid
inv_de_functions.of_create_dynamic_ds( il_prac, 1, ai_screen_id, ids_ScreenData, ii_facility_id, sqlca )
is_sort_syntax = inv_de_functions.is_sort_syntax
li_de_row_cnt = ids_ScreenData.RowCount()
if li_de_row_cnt < 1 then Return -1

Return 1
end function

public function integer of_pastyearsfilter (integer ai_screen_id, integer ai_field);//====================================================================
// $<function> of_pastyearsfilter()
// $<arguments>
//		integer	ai_screen_id
//		integer	ai_field
// $<returns> integer
// $<description> Past years filter
// $<add> (Appeon) evan 11.11.2011
//====================================================================

date ld_pastdate
long li_app_field_id
integer ck1, li_trap
integer li_query_years
integer li_current_page = 1
string ls_year
string ls_error
string LS_YEAR_THROUGH
string LS_END_DATE

is_past_filter = ""
li_query_years = ids_AppField.GetItemNumber(ai_Field, "past_years_query") //move by stephen 08.20.2012  Issues with the Mapper Issues with the Mapper bug 3235
if IsNull(li_query_years) or not (li_query_years > 0) then Return 1
	
// Get field properties
li_app_field_id = ids_AppField.GetItemNumber(ai_Field, "app_field_id")
//li_query_years = ids_AppField.GetItemNumber(ai_Field, "past_years_query")  //delete by stephen 08.20.2012 Issues with the Mapper Issues with the Mapper bug 3235
LS_YEAR_THROUGH = 'year_thru'//ids_ScreenData.of_get_column_name('year_thru')
LS_YEAR_THROUGH = of_field_name(ai_screen_id, LS_YEAR_THROUGH)
LS_END_DATE = 'end_date'//ids_ScreenData.of_get_column_name('END_DATE') 
LS_END_DATE = of_field_name(ai_screen_id, LS_END_DATE)

// Past years filter
if ids_ScreenData.Describe(LS_END_DATE + ".ColType") <> "!" then //check for end_date field
	ld_pastdate = RelativeDate(Today(), (li_query_years * 365)* -1 )
	is_past_filter = "date("+LS_END_DATE+ " ) >= date('" + string(ld_pastdate) + "') or isnull( " +LS_END_DATE+ ")"
	ck1 = 1
elseif ids_ScreenData.Describe("date_thru.ColType") <> "!" then // for CME
	LS_END_DATE = "date_thru"
	ld_pastdate = RelativeDate(Today(), (li_query_years * 365)* -1 )
	is_past_filter = "date("+LS_END_DATE+ " ) >= date('" + string(ld_pastdate) + "') or isnull( " +LS_END_DATE+ ")" 
	ck1 = 1		
elseif ids_ScreenData.Describe("date_to_year.ColType") <> "!" then //professional experience
	ls_year =  String( Year( RelativeDate(Today(), (li_query_years * 365)* -1 )) )
	is_past_filter = "date_to_year >= " + ls_year
	LS_YEAR_THROUGH = "date_to_year"
	ck1 = 1	
elseif ids_ScreenData.Describe(LS_YEAR_THROUGH + ".ColType") <> "!" then //check for year_thru field
	ls_year =  String( Year( RelativeDate(Today(), (li_query_years * 365)* -1 )) )
	is_past_filter = LS_YEAR_THROUGH +" >= " + ls_year
	ck1 = 1
elseif ids_ScreenData.Describe("coverage_to.ColType") <> "!" then //check for coverage_to field -- add by stephen 08.20.2012  Issues with the Mapper bug 3235
	if ai_screen_id = 15 or ai_screen_id = 84 then
		ld_pastdate = RelativeDate(Today(), (li_query_years * 365)* -1 )
		is_past_filter = "date(coverage_to)  >= date('" + string(ld_pastdate) + "') or isnull(coverage_to)" 
		LS_END_DATE = 'coverage_to'
		ck1 = 1
	end if
else //year_thru or start_date not available
	ls_error = "Field ID (" + String( li_app_field_id ) + ")" + "There is no year_thru, date_to_year, or end_date field to filter.  The 'Data from last X years' filter is intended only for data screens with year_thru, date_to_year or end_date fields (Hosp Affil, Professional Exp. etc.).  If one of these fields does not exist or is not visible on the DEFAULT view, then this filter cannot be used." 
	of_error_msg( il_prac, ii_facility_id, ii_app_id, li_app_field_id, li_current_page, ls_error, ii_err_handling)
end if

if ck1 = 1 then 
	li_trap = ids_ScreenData.SetFilter( is_past_filter )
	if li_trap = 1 then
	else
		ls_error = "Field ID (" + String( li_app_field_id ) + ")" + "Error filtering Past Years data. (" + is_past_filter + ")" 
		of_error_msg( il_prac, ii_facility_id, ii_app_id, li_app_field_id, li_current_page, ls_error, ii_err_handling)
	end if
end if

Return 1
end function

public function string of_buildqueryfilters (integer ai_screen_id, integer ai_field);//====================================================================
// $<function> of_buildqueryfilters()
// $<arguments>
//		value	integer	ai_screen_id
//		value	integer	ai_field
// $<returns> string
// $<description> Build query filters
// $<add> (Appeon) evan 11.11.2011
//====================================================================

string ls_query
string ls_error
string ls_query_fld
string ls_query_fld_org
string ls_query_addr_type
string ls_query_value
string ls_query_op
string ls_link_type
string ls_query_fld_type
string ls_addtl_filters
string ls_appeon_str
string ls_loc_query = ""   //maha 04.09.2014
long li_app_field_id
long ll_appeon_found
integer li_current_page = 1
integer li_loc_val //maha 04.09.2014

// Get field properties
ls_query_fld = Trim(ids_AppField.GetItemString(ai_Field, "query_field"))
ls_query_value = Trim(ids_AppField.GetItemString(ai_Field, "query_value"))
ls_query_op = Trim(ids_AppField.GetItemString(ai_Field, "query_operator"))
ls_link_type = ids_AppField.GetItemString(ai_Field, "lookup_link_type")
ls_addtl_filters = Trim(ids_AppField.GetItemString(ai_Field, "addtl_filters"))
li_app_field_id = ids_AppField.GetItemNumber(ai_Field, "app_field_id")
li_loc_val = ids_AppField.GetItemNumber(ai_Field, "loc_id_passed")  //Start Code Change ----04.09.2014 #V14.2 maha

//Start Code Change ----04.09.2014 #V14.2 maha
if ai_screen_id = 2 then //address
	//debugbreak()
	if li_loc_val = 1 then
		ls_loc_query = "pd_address_gp_id = " + string(il_loc_id)
	elseif li_loc_val = -1 then
		ls_loc_query = "pd_address_gp_id <> " + string(il_loc_id)
	end if
	//if lena(ls_loc_query) > 0 then messagebox("location query",ls_loc_query)
end if
//End Code Change ----04.09.2014

//Start Code Change ----06.10.2014 #V14.2 maha - state passed value
if ls_query_value = '-90' then ls_query_value = string(il_state_passed)
//End Code Change ----06.10.2014


// Filter query setup
IF Upper( ls_query_fld ) = "ADDRESS_TYPE" THEN
	ls_query_addr_type = ids_AppField.GetItemString(ai_Field, "query_value")
	ls_query = of_address_query(ls_query_addr_type)

	if ls_query = "ERROR" then
		ls_query = ""
		ls_error = "Field ID (" + String( li_app_field_id ) + ")" + "Unknown address type. (" + ls_query_addr_type + ")" 
		of_error_msg( il_prac, ii_facility_id, ii_app_id, li_app_field_id, li_current_page, ls_error, ii_err_handling)
	end if
	ls_query_value = ""
ELSEIF upper(ls_query_fld) = "PRIMARY_HOSP" THEN
	IF ii_master = 1 THEN
		ls_query = "pd_hosp_facility_link_primary_hosp " + ls_query_op + ls_query_value
	else
		ls_query = "pd_hosp_facility_link_primary_hosp " + ls_query_op + ls_query_value
	end if
ELSE
	ls_query_fld_org = ls_query_fld
	
	//HOSPITAL exception for query field
	if LenA(ls_query_fld) > 0 then
		ls_query_fld = of_field_name(ai_screen_id, ls_query_fld)
	end if
	ls_query = ls_query_fld + ls_query_op + ls_query_value
	if isnull(ls_query) then ls_query = ''  //Start Code Change ----04.15.2014 #V14.2 maha
	
	//trap for lookup fields with non-numeric characters
	IF ls_link_type = "A" OR ls_link_type = "C" or ls_link_type = "Q" THEN
		ls_query_value = Trim( ls_query_value )
		IF NOT IsNumber( ls_query_value ) and  LenA(ls_query_value) > 0 THEN
			ls_error = "Field ID (" + String( li_app_field_id ) + ")" + "Error during SetFilter test for field id " + String( li_app_field_id ) + "Trying to compare a numeric value to a charactor.  HINT: Probably a query value for a lookup table (" +  ls_query + ")"						
			of_error_msg( il_prac, ii_facility_id, ii_app_id, li_app_field_id, li_current_page, ls_error, ii_err_handling)			
		END IF
	end if

	//QUERY exceptions based on query value
	IF  PosA( Upper(ls_query_value), "TODAY")  > 0 THEN
		ls_query_value = "Date('"+ String( Today() ) + "')"
		ls_query = ls_query_fld + ls_query_op + ls_query_value
	elseIF  PosA( Upper(ls_query_value), "NOT NULL")  > 0 THEN
		ls_query_value = ""
		ls_query = " not isnull(" + ls_query_fld + ")"
	elseif PosA( Upper(ls_query_value), "NULL")  > 0 THEN
		ls_query_value = ""
		ls_query = "isnull(" + ls_query_fld + ")"
	else
		ls_appeon_str = "table_id = " + string( ii_table_id ) + &
								" and db_field_name = '" + ls_query_fld_org + "'"
		ll_appeon_found = ids_ScreenField.Find( ls_appeon_str, 1, ids_ScreenField.RowCount() )
		if ll_appeon_found > 0 Then
			ls_query_fld_type = trim(ids_ScreenField.getitemstring(ll_appeon_found, "field_type" ))
		Else
			ls_query_fld_type = gnv_data.of_getitem("sys_fields", "field_type", "field_name = '" + ls_query_fld_org + "' and table_id = " + String(ii_table_id))
		End If
		if ls_query_fld_type = "C" THEN
			ls_query_value = "'" + ls_query_value + "'"
			ls_query = ls_query_fld + ls_query_op + ls_query_value
		end if
	END IF
END IF

// Add additional filters
if LenA(ls_addtl_filters) > 0 then
	ls_addtl_filters = "(" + ls_addtl_filters + ")"
	if LenA(ls_query) > 0 then
		ls_query = ls_query + " and " + ls_addtl_filters
	else
		ls_query = ls_addtl_filters
	end if
end if

//Start Code Change ----04.09.2014 #V14.2 maha - location _query
if ai_screen_id = 2 then //address
	if lenA(ls_query) > 0 and LenA(ls_loc_query) > 0 then
		ls_query = ls_loc_query + " and " + ls_query
	elseif LenA(ls_loc_query) > 0 then
		ls_query = ls_loc_query
	end if
end if
	

Return ls_Query
end function

public function integer of_fieldprocbegin (integer ai_field);//====================================================================
// $<function> of_FieldProcBegin()
// $<arguments>
//		integer	ai_field
// $<returns> integer
// $<description> N/A
// $<add> (Appeon) evan 11.11.2011
//====================================================================

string ls_error
integer li_x, li_y
integer li_current_page = 1
long li_app_field_id

if ii_AppType = TIF_FORM then iu_AppPainter.st_2.text = ""

// Get field name
is_field_name = ids_AppField.GetItemString(ai_Field, "field_name")
if is_field_name = "" then
	li_app_field_id = ids_AppField.GetItemNumber(ai_Field, "app_field_id")
	ls_error = "Field ID (" + String( li_app_field_id ) + ")" + " Invalid column name (" + is_field_name  + ") in datastore"
	of_error_msg(il_prac, ii_facility_id, ii_app_id, li_app_field_id, li_current_page, ls_error, ii_err_handling)
	Return -1
end if

// Check object position
if ii_AppType = TIF_FORM then
	li_x = ids_AppField.GetItemNumber(ai_Field, "x_pos")
	li_y = ids_AppField.GetItemNumber(ai_Field, "y_pos")
	if li_x < 1 or li_y < 1 then Return -1
end if

// Get record number
ii_record_number = ids_AppField.GetItemNumber(ai_Field, "record_number")
if isnull(ii_record_number) or ii_record_number = 0 then ii_record_number = 1
if ii_AppType = TIF_FORM then iu_AppPainter.st_rec.text = String(ii_record_number)

Return 1
end function

public function integer of_screenprocbegin (integer ai_screen);//====================================================================
// $<function> of_ScreenProcBegin()
// $<arguments>
//		integer	ai_screen
// $<returns> integer
// $<description> N/A
// $<add> (Appeon) evan 11.11.2011
//====================================================================

il_prac = il_prac_org
is_screen_name = ids_ScreenList.GetItemString(ai_Screen, "screen_name")

if ii_AppType = TIF_FORM then
	iu_AppPainter.st_1.Text = is_screen_name
	iu_AppPainter.ole_edit.Object.AnnotationFont.Bold = False
end if

Return 1
end function

public function integer of_setup (pfc_cst_u_popwebsite au_webpainter, long ai_app_id, integer ai_from_page, integer ai_to_page, integer ai_facility_id);//====================================================================
// $<function> of_setup()
// $<arguments>
// 	value	pfc_cst_u_popwebsite	au_webpainter
// 	value	long		ai_app_id
// 	value	integer	ai_from_page
// 	value	integer	ai_to_page
// 	value	integer	ai_facility_id
// $<returns> integer
// $<description> Populate application type of Website form
// $<add> (Appeon) evan 11.08.2011
//====================================================================

integer li_rc
long ll_RowCount
string ls_Null[]

ii_AppType = WEB_FORM
iu_WebPainter = au_WebPainter

ii_app_id = ai_app_id
ii_from_page = ai_from_page
ii_to_page = ai_to_page
ii_facility_id = ai_facility_id

// Clear filter
iu_WebPainter.dw_data.SetRedraw(false)
iu_WebPainter.dw_data.SetFilter("")
iu_WebPainter.dw_data.Filter()
ll_RowCount = iu_WebPainter.dw_data.RowCount()
if ll_RowCount > 0 then
	ls_Null[ll_RowCount] = ""
	iu_WebPainter.dw_data.object.site_field_value[1, ll_RowCount] = ls_Null[]
end if

// Get provider data
of_GetLoginInfo()
if ii_to_page > 0 then
	li_rc = of_Setup()
end if

// Come back to current filter
iu_WebPainter.dw_data.SetFilter("page = " + String(iu_WebPainter.il_Page))
iu_WebPainter.dw_data.Filter()
iu_WebPainter.dw_data.SetRedraw(true)

Return li_rc
end function

public function integer of_getmappingdata (integer ai_field, string as_data);//====================================================================
// $<function> of_GetMappingData()
// $<arguments>
//		integer	ai_field
//		string	as_data
// $<returns> integer
// $<description> Get mapping data
// $<add> (Appeon) evan 11.14.2011
//====================================================================

long ll_Row
long li_app_field_id
datawindow ldw_data

ldw_data = iu_WebPainter.dw_data
li_app_field_id = ids_AppField.GetItemNumber(ai_Field, "app_field_id")

ll_Row = ldw_data.Find("app_field_id = " + String(li_app_field_id), 1, ldw_data.RowCount())
if ll_Row > 0 then
	ldw_data.SetItem(ll_Row, "site_field_value", as_Data)
	Return 1
else
	Return -1
end if
end function

public function integer of_getlogininfo ();//====================================================================
// $<function> of_getlogininfo()
// $<arguments>
// $<returns> integer
// $<description> Get login information
// $<add> (Appeon) evan 01.06.2012
//====================================================================

long ll_FindRow
long ll_RowCount
string ls_Filters
string ls_site_login
string ls_site_password
datawindow ldw_data

select site_login, site_password into :ls_site_login, :ls_site_password
from app_hdr
where app_id = :ii_app_id;
ldw_data = iu_WebPainter.dw_data
ll_RowCount = ldw_data.RowCount()

// site_login
ll_FindRow = 0
ls_Filters = "page = 0 and screen_field_label = 'site_login'"
do
	ll_FindRow = ldw_data.Find(ls_Filters, ll_FindRow + 1, ll_RowCount)
	if ll_FindRow > 0 then ldw_data.SetItem(ll_FindRow, "site_field_value", ls_site_login)
loop until ll_FindRow < 1 or ll_FindRow = ll_RowCount

// site_password
ll_FindRow = 0
ls_Filters = "page = 0 and screen_field_label = 'site_password'"
do
	ll_FindRow = ldw_data.Find(ls_Filters, ll_FindRow + 1, ll_RowCount)
	if ll_FindRow > 0 then ldw_data.SetItem(ll_FindRow, "site_field_value", ls_site_password)
loop until ll_FindRow < 1 or ll_FindRow = ll_RowCount

Return 0
end function

protected function integer of_getactiveelementinfo (oleobject aole_object);//====================================================================
// $<function> of_getactiveelementinfo()
// $<arguments>
// 	value	oleobject	aole_object
// $<returns> integer
// $<description> Get active element object information
// $<add> (Appeon) evan 01.10.2012
//====================================================================

integer li_Index
oleobject lole_element
oleobject lole_objects

if Len(String(aole_object.id)) > 0 then
	is_ActiveElement = aole_object.id
	is_AttributeName = "ID"
	is_ElementIndex = "0"
elseif Len(String(aole_object.name)) > 0 then
	is_ActiveElement = aole_object.name
	is_AttributeName = "NAME"
	//
	aole_object.id = "custid_12345"
	lole_objects = iole_Document.GetElementsByName(is_ActiveElement)
	for li_Index = 0 to lole_objects.length - 1
		lole_element = lole_objects.item[li_Index]
		if lole_element.id = "custid_12345" then
			is_ElementIndex = String(li_Index)
			exit
		end if
	next
	aole_object.id = ""
end if

Return 1
end function

public function integer of_getactiveelement (oleobject aole_object, ref string as_element, ref string as_elementtype, ref string as_execommand);//====================================================================
// $<function> of_getactiveelement()
// $<arguments>
// 	value	oleobject	aole_object //document
// 	ref	string		as_element
// 	ref	string		as_elementtype
// 	ref	string		as_execommand
// $<returns> integer
// $<description>
//		1.Get active element object in web page
//		2.Get command of setting value
// $<add> (Appeon) evan 10.20.2011
//====================================================================

string ls_Path
string ls_SetID

is_ActiveElement = ""
is_AttributeName = ""
is_ElementType = ""
as_ExeCommand = ""
iole_Document = aole_object

// Get active element information
try
	ls_Path = of_GetActiveElement(iole_Document.activeElement)
catch (RuntimeError e)
	is_ActiveElement = ""
	//MessageBox("Warnning", "Failed to get active element.~r~n~r~nError Information: " + e.Text, Exclamation!)
end try
if is_ActiveElement = "" then Return -1

// Get command of setting field value
as_Element = is_ActiveElement
as_ElementType = is_ElementType
if ls_Path <> "" then ls_Path += "."
if is_AttributeName = "ID" then
	as_ExeCommand = "ID|" + ls_Path + "document.getElementById('" + is_ActiveElement + "')|0"
else
	as_ExeCommand = "NAME|" + ls_Path + "document.getElementsByName('" + is_ActiveElement + "')|" + is_ElementIndex
end if

Return 1


/***********************************************************************************************************
string ls_command
oleobject lole_document
oleobject lole_window
oleobject lole_element

// Call this function examples:
if of_GetActiveElement(ole_browser.object.document, ls_element, ls_command) = 1 then
	MessageBox("Success", ls_element)
else
	MessageBox("Error", "The clicked object is not TEXT object.")
end if

// Set text value examples:
lole_window = ole_browser.Object.document.parentWindow
ls_command = "frames[1].frames[1].document.getElementById('GridViewReport_ctl02_TextBoxHours').value = '8'"
lole_window.execScript(ls_command, "JScript")
ls_command = "document.getElementById('TextBoxUserName').value = '019'"
lole_window.execScript(ls_command, "JScript")

//////////////////////////////////////////////////////////////////////////
// Get document object examples:
lole_document = ole_browser.Object.document.parentWindow
lole_document = ole_browser.Object.document.frames[0].document

// Get frame(frame is a window object) count in a document examples:
ll_len = ole_browser.document.frames.length
ll_len = ole_browser.Object.document.frames[0].document.frames.length

// Get window object examples:
lole_window = ole_browser.Object.document.parentWindow
lole_window = ole_browser.Object.document.frames[0]
lole_window = ole_browser.Object.document.frames[0].frames[1]

// Get element of current window examples:
lole_window = ole_browser.Object.document.parentWindow
lole_element = lole_window.document.getElementById('TextBoxUserName')
lole_element.value = '019'
ls_command = "document.getElementById('TextBoxUserName').value = '019'"
lole_window.execScript(ls_command, "JScript")
//
lole_window = ole_browser.Object.document.parentWindow
lole_element = lole_window.frames[1].frames[1].document.getElementById('GridViewReport_ctl02_TextBoxHours')
lole_element.value = '8'
ls_command = "frames[1].frames[1].document.getElementById('GridViewReport_ctl02_TextBoxHours').value = '8'"
lole_window.execScript(ls_command, "JScript")
************************************************************************************************************/
end function

public function integer of_get_norowcount ();//Start Code Change ----12.10.2012 #V12 maha - added for no row defaults
//returns the number of mapping records on the screen with the no row yes setting
integer li_return = 0
integer i


for i = 1 to ids_AppField.rowcount()
	if ids_AppField.GetItemNumber(i ,"use_default") = 2 then li_return++
next
	
return li_return
end function

public function boolean of_is_default_field (integer ai_row);//Start Code Change ----10.10.2012 #V12 maha - check field for no row default

if ids_AppField.GetItemNumber(ai_row,"use_default") = 2 then
	return true
else
	return false
end if

end function

public function integer of_setup (pfc_cst_u_create_app2 au_apppainter, long ai_app_id, integer ai_from_page, integer ai_to_page, long ai_facility_id, long al_loc_id, long al_state);//====================================================================
// $<function> of_setup()
// $<arguments>
// 	value	pfc_cst_u_create_app2	au_apppainter
// 	value	long		ai_app_id
// 	value	integer	ai_from_page
// 	value	integer	ai_to_page
// 	value	integer	ai_facility_id
// $<returns> integer
// $<description> Populate application type of TIF form
// $<add> (Appeon) evan 11.08.2011
//====================================================================

ii_AppType = TIF_FORM
iu_AppPainter = au_AppPainter

ii_app_id = ai_app_id
ii_from_page = ai_from_page
ii_to_page = ai_to_page
ii_facility_id = ai_facility_id
il_loc_id = al_loc_id //Start Code Change ----05.30.2014 #V14.2 maha
il_state_passed = al_state  //Start Code Change ----06.10.2014 #V14.2 maha


if ii_to_page > 0 then
	Return of_Setup()
else
	Return 0
end if
end function

public function long of_get_lucode_by_code (string as_link_type, string as_lookup_name, string as_code);//====================================================================
//$<Function>: of_get_lucode_by_code
//$<Arguments>:
// 	value    string    as_link_type
// 	value    string    as_lookup_name
// 	value    string    as_code
//$<Return>:  long
//$<Description>: Get lookup_code from the lookup table by code. Only Support Code_lookup till now.
//$<Author>: (Appeon) long.zhang 04.25.2017 (Trying to add affiliation status to application mapping)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_findrow
Long ll_value
String ls_condition

IF IsNull(as_lookup_name) OR LenA(Trim(as_lookup_name)) < 1  THEN RETURN 0

CHOOSE CASE Upper(as_link_type)
	CASE 'C'
		gnv_data.of_retrieveIfNecessary("code_lookup", FALSE)

		ls_condition = "lookup_name = '"+ as_lookup_name +"'"+ " and code = '" + string(as_code) + "'"		
		ll_findrow = gnv_data.ids_code_lookup.Find(ls_condition , 1, gnv_data.ids_code_lookup.rowcount())
		IF ll_findrow <= 0 THEN 
			RETURN 0
		Else
			ll_value = gnv_data.ids_code_lookup.GetItemNumber(ll_findrow, 'lookup_code')
		End If
	CASE ELSE //Only Support Code_lookup till now.
		RETURN 0				
END CHOOSE

RETURN ll_value
end function

public function integer of_evaluate_sort (n_ds adw_data, string as_from_field, string as_type, string as_lu_field, integer ai_screenid);//Start Code Change ----11.10.2016 #V153 maha - for setting the lookup display value for sorting for dynamic ds 
integer r
integer rc
long ll_val
string ls_value
string ls_describe
string ls_to_field
string ls_dtype //maha 09.05.2017

ls_to_field = "sort4_" + as_from_field



 //Start Code Change ----06.20.2017 #V153 maha - exception for hosp screen
 choose case ai_screenid
	case 10
		as_from_field = "pd_hosp_affil_" + as_from_field
	case 19
		as_from_field = "pd_board_specialty_" + as_from_field
		//messagebox(ls_to_field, as_from_field)
	case 2
		as_from_field = "pd_address_" + as_from_field
		//messagebox(ls_to_field, as_from_field)
end choose
 //End Code Change ----06.20.2017


//messagebox(as_from_field, ls_to_field)
for r = 1 to adw_data.rowcount()
	//---------Begin Added by (Appeon)Stephen 06.20.2017 for Bug id 5703 - Getting sort error when trying to preview a page in Application Mapping. C/S Version 15.309 Build Date 5/11/2017--------		
//Start Code Change ----09.05.2017 #V154 maha - get and test datatype
	ls_dtype = adw_data.describe(as_from_field +".coltype")
	if ls_dtype = '!' then
		as_from_field = is_table_name + "_" + as_from_field
		ls_dtype = adw_data.describe(as_from_field +".coltype")	
		if ls_dtype = '!' then
			continue
		end if
	end if
	//---------End Added ------------------------------------------------------
	ls_dtype = upper(left( ls_dtype,1))
	//messagebox(as_from_field,  ls_dtype)
	choose CASE ls_dtype
		case "C"  //test for custom fields using lookup
			//ll_val = long(adw_data.getitemnumber(r, as_from_field))
			ll_val = long(adw_data.getitemstring(r, as_from_field)) //Start Code Change ----10.06.2017 #V154 maha - corrected getitemtype
		case "!"  //redundant trap
			continue
		case else
			ll_val = adw_data.getitemnumber(r, as_from_field) 
	end choose
//Start Code Change ----09.05.2017

	ll_val = adw_data.getitemnumber(r, as_from_field) 
	//---------Begin Added by (Appeon)Stephen 10.17.2017 for Sort Order on Screen design not working Case#73029 Bug_id#5806--------
	if as_type = 'A' AND as_lu_field <> "entity_name" then
		as_lu_field = "entity_name"
	end if
	//---------End Added ------------------------------------------------------

	ls_value = of_get_luvalue( as_type, as_lu_field, ll_val)
 
	//messagebox(ls_to_field, ls_value)
	adw_data.setitem(r, ls_to_field, ls_value)
	adw_data.setitemstatus(r, ls_to_field, primary!, Notmodified!)
next

return 1
end function

on n_cst_app_population.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_app_population.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//====================================================================
// $<event> destructor()
// $<arguments>
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 11.08.2011
//====================================================================

of_Destroy()
end event

