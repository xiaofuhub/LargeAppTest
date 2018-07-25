$PBExportHeader$n_cst_update_view_fields_alias.sru
forward
global type n_cst_update_view_fields_alias from nonvisualobject
end type
end forward

global type n_cst_update_view_fields_alias from nonvisualobject
end type
global n_cst_update_view_fields_alias n_cst_update_view_fields_alias

type variables
datastore ids_data_view //add by evan 02.28.2011
pfc_cst_nv_data_entry_functions inv_data_entry
end variables

forward prototypes
public subroutine of_get_view_fields_alias (long al_module, long al_data_view_id, string as_screen, string as_v_name, datastore ads_view_fields_alias)
public function string of_globalreplace (string as_source, string as_old, string as_new, boolean ab_ignorecase)
public subroutine of_after_getaliasformscreen (datastore ads_view_fields_alias)
public function long of_update_view_picture ()
public function long of_update_view_fields_alias (long al_module, long al_data_view_id)
public function long of_update_view_field_name ()
public function integer of_update ()
public function integer of_insertfield (string as_v_name, string as_c_name, string as_c_alias, integer ai_visible)
public function integer of_insertfield (string as_v_name, string as_c_name, string as_c_alias, integer ai_visible, integer ai_view_id)
public function long of_update_view_fields_alias (long al_module, long al_data_view_id, boolean ab_force_update)
public function integer of_modify_viewalias (datastore ads_view_data, string as_v_name)
public function integer of_insertfield (string as_v_name, string as_c_name, string as_c_alias, integer ai_visible, string as_f_name)
public function integer of_deletefield (string as_v_name)
public function integer of_insertfield (string as_v_name, string as_c_name, string as_c_alias, integer ai_visible, integer ai_view_id, string as_f_name)
public function integer of_deletefield (string as_v_name, string as_c_name)
public function integer of_update_view_fields_alias_f (string as_v_name, string as_c_name, string as_f_name)
end prototypes

public subroutine of_get_view_fields_alias (long al_module, long al_data_view_id, string as_screen, string as_v_name, datastore ads_view_fields_alias);//====================================================================
// Event: n_cst_update_view_fields_alias.of_get_view_fields_alias()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	long     	al_module            	
// 	value	long     	al_data_view_id      	
// 	value	string   	as_screen            	
// 	value	string   	as_v_name            	
// 	value	datastore	ads_view_fields_alias	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Andy		Date: Nov 29,2007
//--------------------------------------------------------------------
// Modify History:  	Andy		Date: Dec 04,2007
//				          Andy     Date: 03.24.2008
//	Copied from CLX 11 and overrode the original - (Appeon)Alfee 06.18.2013 for V141 isg-clx	
//====================================================================
String ls_Filter,ls_alias
n_cst_datastore lds_screen,lds_view_fields
Long   ll_vCnt,ll_fCnt,ll_i,ll_aCnt,ll_R
String ls_dwsyntax, ls_ERRORS
String ls_fName,ls_lName,ls_Find,ls_Visible, ls_ScreenStyle
Long   ll_Find
Long   ll_Screen

IF NOT IsValid(ads_view_fields_alias) then return															  
IF lower(ads_view_fields_alias.dataobject) <> 'd_view_fields_alias_edit' then return
if IsNumber(as_screen) and (isnull(al_module) or (al_module <> 1 and al_module <> 2)) then return
if isnull(as_v_name) or as_v_name = '' then return
if isnull(al_data_view_id) then return

lds_screen = create n_cst_datastore

ls_Filter = "v_name='" + as_v_name + "' AND data_view_id=" + string(al_data_view_id)
ll_R = ads_view_fields_alias.Find(ls_Filter,0,ads_view_fields_alias.RowCount())
//Initialize ads_view_fields_alias
IF ll_R < 1 then
	lds_view_fields = create n_cst_datastore
	IF gs_dbtype = 'SQL' THEN
		lds_view_fields.DATAObject = 'd_view_fields_sql'
	ELSE
		lds_view_fields.DATAObject = 'd_view_fields_asa'
	END IF
	lds_view_fields.settransobject( SQLCA )
	ll_vCnt = lds_view_fields.retrieve( as_v_name )
	
	FOR ll_i = 1 to ll_vCnt
		ll_R = ads_view_fields_alias.insertRow(0)
		ads_view_fields_alias.setitem(ll_R,"v_name",as_v_name)
		ads_view_fields_alias.setitem(ll_R,"data_view_id",al_data_view_id)
		ads_view_fields_alias.setitem(ll_R,"c_name",lds_view_fields.getitemstring(ll_i,"cname"))
		ads_view_fields_alias.setitem(ll_R,"visible",0)
	NEXT
	
	destroy lds_view_fields
end if

ads_view_fields_alias.setfilter(ls_Filter)
ads_view_fields_alias.filter()
ll_aCnt = ads_view_fields_alias.RowCount()

//Get screen fields list
if Not IsNumber(as_screen) then
	//as_screen is a dataobject name
	lds_screen.dataobject = as_screen
	if lower(as_v_name) = 'v_recruit_prac' then//Added by Appeon long.zhang 11.19.2013 (V14.1 Recruitment Functionality)  Fixed BugL111301 get correct view field alias for intellireport
		of_modify_viewalias(lds_screen,as_v_name)
	end if
else
	//as_screen is a screen id		
	if al_module = 1 then
		//Contract Logix
		//$<modify> 05.20.2008 by Andy 
		//$<Reason> fixed BugK051901(add:if statement)
		ll_Screen = Long(as_screen)
		IF AppeonGetClientType() = "WEB" THEN			
			//modified by gavins 20120320 grid 
			SELECT (case when screen_style = 'G' then grid_sql else dw_sql end  )
			INTO :ls_dwsyntax
			FROM ctx_screen 
			WHERE data_view_id = :al_data_view_id 
			AND screen_id = :ll_Screen;
		ELSE
			//modified by gavins 20120320 grid 
			SELECT screen_style INTO:ls_ScreenStyle 	FROM ctx_screen 
			WHERE data_view_id = :al_data_view_id 
			AND screen_id = :ll_Screen;
			If ls_ScreenStyle = 'G' Then
				ls_dwsyntax          = f_get_screen_gridsql(al_data_view_id,ll_Screen,false)
			Else
				ls_dwsyntax          = f_get_screen_sql(al_data_view_id,ll_Screen,false)  //add false argu - jervis 10.11.2011
			End If
		END IF
		//end 05.20.2008
		lds_screen.Create( ls_dwsyntax, ls_ERRORS)
		
	elseif al_module = 2 then	
		//IntelliCred
		inv_data_entry.ids_screen_fields.SetFilter( "view_id = " + String (al_data_view_id) + " AND screen_id = " + as_screen )
		inv_data_entry.ids_screen_fields.Filter( )	
		ll_fCnt = inv_data_entry.ids_screen_fields.RowCount()		
	end if
end if

//Get fields alias if c_alias is null
ll_R = 0
ls_Filter = "IsNull(c_alias) OR Trim(c_alias)=''"
DO WHILE (1=1)
	ll_R = ads_view_fields_alias.find(ls_Filter,ll_R,ll_aCnt)
	if ll_R < 1 then exit
	ls_fName = ads_view_fields_alias.getitemstring(ll_R,"c_name")
	
	if Not IsNumber(as_screen) OR al_module = 1 then
		ls_Visible = lds_screen.Describe( ls_fName + ".visible" )
		//Set visible if the field not exists in screen or contains expression in visible property
		if ls_Visible = '?' or ls_Visible = '!' or Len(ls_Visible) > 1 or ls_Visible = '' then ls_Visible = '1' 
		if ls_Visible = '1' then
			ls_lName = ls_fName + "_t"
			ls_alias = lds_screen.Describe( ls_lName + ".text" )
			if Not (ls_alias = '?' or ls_alias = '!' or ls_alias = '') then 
				ads_view_fields_alias.setitem(ll_R,"c_alias",left(ls_alias,255))
			end if
			ads_view_fields_alias.setitem(ll_R,"visible",1)
		end if
	ELSE
		ls_Find = "db_field_name='" + ls_fName + "'"
		ll_Find = inv_data_entry.ids_screen_fields.find( ls_Find, 0, ll_fCnt)
		if ll_Find > 0 then
			ls_Visible = inv_data_entry.ids_screen_fields.getitemstring(ll_Find,"visible")
			if lower(ls_Visible) = 'n' then ls_Visible = '0' else ls_Visible = '1'
			ls_alias = inv_data_entry.ids_screen_fields.getitemstring(ll_Find,"field_label")
			if Len(ls_alias) > 0 then
				ads_view_fields_alias.setitem(ll_R,"c_alias",left(ls_alias,255))
			end if
			If ls_Visible = '1' Then //Added By Ken.Guo 07/04/2012. Add if statement. only set it if need set to visible = 1.
				ads_view_fields_alias.setitem(ll_R,"visible",Long(ls_Visible))
			End If
		else
			//Set visible if the field not exists in screen
			ads_view_fields_alias.setitem(ll_R,"visible",1)
		end if
	END IF
	
	ll_R ++
	if ll_R > ll_aCnt then exit
LOOP

ads_view_fields_alias.setfilter("")
ads_view_fields_alias.filter()

destroy lds_screen

end subroutine

public function string of_globalreplace (string as_source, string as_old, string as_new, boolean ab_ignorecase);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GlobalReplace
//
//	Access:  		public
//
//	Arguments:
//	as_Source		The string being searched.
//	as_Old			The old string being replaced.
//	as_New			The new string.
// ab_IgnoreCase	A boolean stating to ignore case sensitivity.
//
//	Returns:  		string
//						as_Source with all occurrences of as_Old replaced with as_New.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Replace all occurrences of one string inside another with
//						a new string.
//                Replace the next letter of the as_old with uppercase.
//
// Author:	Andy		Date: Nov 30,2007
//////////////////////////////////////////////////////////////////////////////

Long	ll_Start
Long	ll_OldLen
Long	ll_NewLen
String ls_Source,ls_Next

//Check parameters
If IsNull(as_source) or IsNull(as_old) or IsNull(as_new) or IsNull(ab_ignorecase) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

//Get the string lenghts
ll_OldLen = LenA(as_Old)
ll_NewLen = LenA(as_New)

//Should function respect case.
If ab_ignorecase Then
	as_old = Lower(as_old)
	ls_source = Lower(as_source)
Else
	ls_source = as_source
End If

//Search for the first occurrence of as_Old
ll_Start = PosA(ls_Source, as_Old)

Do While ll_Start > 0
	ls_Next = UPPER(MidA(as_Source,ll_Start + ll_OldLen,1))
	// replace as_Old with as_New and replace the next letter of the as_old with uppercase
	as_Source = ReplaceA(as_Source, ll_Start, ll_OldLen + 1, as_New + ls_Next)
	
	//Should function respect case.
	If ab_ignorecase Then 
		ls_source = Lower(as_source)
	Else
		ls_source = as_source
	End If
	
	// find the next occurrence of as_Old
	ll_Start = PosA(ls_Source, as_Old, (ll_Start + ll_NewLen))
Loop

Return as_Source

end function

public subroutine of_after_getaliasformscreen (datastore ads_view_fields_alias);//====================================================================
// Event: n_cst_update_view_fields_alias.of_after_getaliasformscreen()
//--------------------------------------------------------------------
// Description:if don't find alias out ,then set a default value
//             example:
//             The field is field_name,then the alias is setted Field Name
//--------------------------------------------------------------------
// Arguments:
// 	value	datastore	ads_view_fields_alias	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Andy		Date: Nov 30,2007
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//				Andy		Date: Dec 04,2007
//====================================================================
Long  ll_Cnt,ll_R
String ls_filter,ls_cName,ls_First

ll_Cnt = ads_view_fields_alias.RowCount()
if ll_Cnt < 1 then return

ll_R = 0
ls_Filter = "IsNull(c_alias) OR Trim(c_alias)=''"
DO WHILE (1=1)
	ll_R = ads_view_fields_alias.find(ls_Filter,ll_R,ll_Cnt)
	if ll_R < 1 then exit
	
	ls_cName = ads_view_fields_alias.getitemstring(ll_R,"c_name")
	ls_First = Upper(LeftA(ls_cName,1))
	if ls_First = "_" then ls_First = ""
	ls_cName = ls_First + MidA(ls_cName,2)
	ls_cName = of_globalreplace( ls_cName, "_", " ", true)
	
	ads_view_fields_alias.setitem(ll_R,"c_alias",LeftA(ls_cName,255))
	
	ll_R ++
	if ll_R > ll_Cnt then exit
LOOP

return

end subroutine

public function long of_update_view_picture ();//====================================================================
// Event: n_cst_update_view_fields_alias.of_update_view_picture()
//--------------------------------------------------------------------
// Description:Initialize view picture
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Andy		Date: Nov 30,2007
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//				Andy		Date: Dec 04,2007
//				Andy		Date: Feb 15,2008
//				Andy		Date: Feb 18,2008
//====================================================================
n_cst_datastore lds_view
Long      ll_Cnt,ll_i
String    ls_FilePath,ls_fileName
n_cst_filesrv lnvo_filesrv
Blob      lblb_data
String    ls_v_name,ls_Error
Boolean   lb_Flag
n_appeon_download lnv_download
String    ls_downurl

lds_view = Create n_cst_datastore
lds_view.DataObject = 'd_view_alias_nopicture'
lds_view.SetTransObject( SQLCA )
ll_Cnt = lds_view.Retrieve( )

IF ll_Cnt < 1 THEN
	Destroy lds_view
	RETURN 1
END IF

lnvo_filesrv = Create n_cst_filesrv

IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
IF IsValid(w_infodisp) THEN w_infodisp.Title = 'Update picture of view, Please stand by'
IF IsValid(w_infodisp) THEN w_infodisp.Center = True
IF IsValid(w_infodisp) THEN w_infodisp.st_complete.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_3.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_information.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'Update picture of view, Please stand by!'
IF IsValid(w_infodisp) THEN w_infodisp.wf_set_min_max(1,ll_Cnt)


FOR ll_i = 1 To ll_Cnt
	Yield()
	IF IsValid(w_infodisp) THEN
		w_infodisp.wf_step_pbar(1)
		w_infodisp.st_1.Text = 'Update ' + String(ll_i) + ' of ' + String(ll_Cnt)+' Please stand by!'
	END IF
	
	ls_v_name   = lds_view.GetItemString(ll_i,"v_name")
	ls_fileName = lds_view.GetItemString(ll_i,"p_name")
	//$<modify> 02.18.2008 by Andy
	IF AppeonGetClientType() = "WEB" THEN
		//$<Modify> 02.26.2008 by Andy
		//ls_downurl = gnv_data.of_getitem( "icred_settings", "downloadurl", false)
		SELECT Top 1 downloadurl Into :ls_downurl From icred_settings;
		//end of modify 02.26.2008
		ls_downurl+= "pictures/"
		ls_FilePath = gs_dir_path + "intellicred\pictures\" + ls_fileName
		//Download picture files
		IF lnv_download.of_downloadfile(ls_downurl, ls_FilePath) <> 0 THEN
			ls_Error = "n_cst_update_view_fields_alias.of_update_view_picture() Information: Failed to download " + ls_FilePath + ", call support."
			IF IsValid(gnv_logservice)THEN
			gnv_logservice.of_setloglevel(2) //warning level
			gnv_logservice.of_log_warning(ls_Error)
			gb_upgrade_failed = True
		END IF
	END IF
ELSE
	ls_FilePath = Gs_Current_Directory + "\pictures\" + ls_fileName
END IF
//--------Begin Added by Nova 07.29.2008------------------------
IF lnvo_filesrv.of_fileread(ls_FilePath , lblb_data) = -1 THEN
	lb_Flag = True
	CONTINUE
END IF
//--------End Added --------------------------------------------
UpdateBlob view_alias
Set v_image = :lblb_data
Where v_name = :ls_v_name;

IF SQLCA.SQLCode < 0 THEN lb_Flag = True
//Added by  Nova 04.06.2010------------------------
Update view_alias
Set mflag = 0
Where v_name = :ls_v_name and mflag=1;

IF SQLCA.SQLCode < 0 THEN lb_Flag = True
NEXT


IF lb_Flag THEN
	//ls_Error = '~r~n' + "==================================================="
	//ls_Error+= "~r~nWarning:n_cst_update_view_fields_alias.of_update_view_picture()~r~nInformation: Upate picture of view failed." 
	ls_Error = "n_cst_update_view_fields_alias.of_update_view_picture() Information: Upate picture of view failed, call support."
	IF IsValid(gnv_logservice)THEN
	gnv_logservice.of_setloglevel(2) //warning level
	gnv_logservice.of_log_warning(ls_Error)
	gb_upgrade_failed = True
END IF
//gb_Flag = true	
END IF

Destroy lnvo_filesrv
Destroy lds_view
RETURN 1

end function

public function long of_update_view_fields_alias (long al_module, long al_data_view_id);//====================================================================
// Event: n_cst_update_alias.of_update_alias()
//--------------------------------------------------------------------
// Description:Initialize table view_fields_alias
//--------------------------------------------------------------------
// Arguments:
// long al_module : When DB Update call then set 0,
//                  when View Painter call then set module,such as
//                  1:IntelliContract/2:IntelliCred/App
// long al_data_view_id:
//                  When DB Update call then set 0,
//                  when View Painter call then set data_view_id
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Andy		Date: Nov 28,2007
//--------------------------------------------------------------------
// Modify History:           Andy		Date: Dec 04,2007
// Override - Copied from CLX 11 by (Appeon)Alfee 06.18.2013 for V141 isg-clx
//====================================================================


Return of_update_view_fields_alias(al_module,al_data_view_id, False )


//Long ll_n,ll_Cnt,ll_module,ll_i,ll_ScreenCnt
//n_cst_datastore lds_view_alias,lds_view_fields_alias
//String ls_Screen,ls_screenID,ls_v_name,ls_ScreenArray[],ls_Nulls[]
//n_cst_string lnvo_string
//n_cst_datastore lds_screen_all
//String ls_Filter,ls_Error
//Long ll_R,ll_ScreenAll,ll_data_view_id,ll_aCnt
//boolean  lb_Flag
//
//if isnull(al_module) or isnull(al_data_view_id) then 
//	return 1
//end if
//lds_view_alias = create n_cst_datastore
//lds_view_alias.dataobject = 'd_view_alias_rpt'
//lds_view_alias.settransobject(SQLCA)
//lds_view_alias.retrieve( al_module )
//
//ll_Cnt = lds_view_alias.RowCount()
//if ll_Cnt < 1 then
//	destroy lds_view_alias
//	return 1
//end if
//
//lds_view_fields_alias = create n_cst_datastore
////d_view_fields_alias
//lds_view_fields_alias.dataobject = 'd_view_fields_alias_edit'
//lds_view_fields_alias.settransobject(SQLCA)
//
//lds_screen_all = create n_cst_datastore
//lds_screen_all.dataobject = 'd_screen_all'
//lds_screen_all.settransobject(SQLCA)
//lds_screen_all.retrieve( )
//
//if Not isvalid( w_infodisp ) then open(w_infodisp)
//if isvalid(w_infodisp) then w_infodisp.title = 'Update fields alias of view, Please stand by'
//if isvalid(w_infodisp) then w_infodisp.Center = TRUE
//if isvalid(w_infodisp) then w_infodisp.st_complete.visible = false
//if isvalid(w_infodisp) then w_infodisp.st_3.visible = false
//if isvalid(w_infodisp) then w_infodisp.st_information.visible = false
//if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Update fields alias of view, Please stand by!'
//if isvalid(w_infodisp) then w_infodisp.wf_set_min_max(1,ll_Cnt)
//
//FOR ll_n = 1 to ll_Cnt
//	//$<Modify> 03.14.2008 by Andy
//	if al_module = 0 then Yield()
//	if isvalid(w_infodisp) then 
//		w_infodisp.wf_step_pbar(1)
//		w_infodisp.st_1.text = 'Update ' + string(ll_n) + ' of ' + string(ll_Cnt)+' Please stand by!'
//	end if
//	
//	ll_module = lds_view_alias.getitemNumber(ll_n,"module")
//	ls_Screen = lds_view_alias.getitemString(ll_n,"screen")
//	ls_v_name = lds_view_alias.getitemString(ll_n,"v_name")
//	ls_ScreenArray = ls_Nulls //reset
//	ls_Screen = ls_Screen + ','
//	lnvo_string.of_parsetoarray( ls_Screen, ',', ls_ScreenArray )
//	ll_ScreenCnt = UpperBound(ls_ScreenArray)
//	
//	ls_Filter = "module=" + String(ll_module)
//	//View Painter call
//	if al_module > 0 then
//		ls_Filter += " And data_view_id=" + String(al_data_view_id)
//	end if	
//	lds_screen_all.setfilter( ls_Filter )
//	lds_screen_all.filter( )	
//	ll_ScreenAll = lds_screen_all.RowCount()
//	
//	FOR ll_i = 1 to ll_ScreenCnt
//		ls_screenID = ls_ScreenArray[ll_i]
//		if Not IsNumber(ls_screenID) then
//			//ls_screenID is a dataobject name
//			ll_aCnt = 0
//			select TOP 1 1 INTO :ll_aCnt FROM view_fields_alias 
//				where data_view_id = 0 AND v_name = :ls_v_name;
//			//No fields alias
//			IF ll_aCnt = 0 THEN	
//				of_get_view_fields_alias(ll_module,0,ls_screenID,ls_v_name,lds_view_fields_alias)
//			END IF
//		else
//			//ls_screenID is a screen id
//			if isnull(ll_module) or (ll_module <> 1 and ll_module <> 2) then continue
//			ll_R = 0
//			ls_Filter = "screen_id=" + ls_screenID
//			
//			DO WHILE (1=1)
//				ll_R = lds_screen_all.Find(ls_Filter,ll_R,ll_ScreenAll)
//				if ll_R < 1 then exit
//				
//				ll_data_view_id = lds_screen_all.GetItemNumber(ll_R,"data_view_id")
//				ll_aCnt = 0
//				select TOP 1 1 INTO :ll_aCnt FROM view_fields_alias 
//					where data_view_id = :ll_data_view_id AND v_name = :ls_v_name;
//				//No fields alias
//				IF ll_aCnt = 0 THEN
//					of_get_view_fields_alias(ll_module,ll_data_view_id,ls_screenID,ls_v_name,lds_view_fields_alias)
//				end if
//				
//				ll_R ++
//				if ll_R > ll_ScreenAll then exit
//			LOOP 
//			
//		end if
//	NEXT
//NEXT
//
////if don't find alias out, then set a default value.
//of_after_getaliasformscreen(lds_view_fields_alias)
//
//IF lds_view_fields_alias.update( ) = -1 THEN
//	//db update call
//	if al_module = 0 then
//		//ls_Error = '~r~n' + "==================================================="
//		//ls_Error+= "~r~nWarning:n_cst_update_view_fields_alias.of_update_view_fields_alias()~r~nInformation: Upate view fields alias failed." 
//		ls_Error+= "n_cst_update_view_fields_alias.of_update_view_fields_alias() Information: Upate view fields alias failed, call support." 
//		IF IsValid(gnv_logservice)THEN 
//			gnv_logservice.of_setloglevel(2) //warning level
//			gnv_logservice.of_log_warning(ls_Error)
//			gb_upgrade_failed = TRUE			
//		END IF
//		//filewrite(gl_logfilehandle,ls_Error)
//		//gb_Flag = true
//	end if
//end if
//
//if al_module > 0 then
//	if isvalid( w_infodisp ) then close(w_infodisp)
//end if
//
//destroy lds_view_alias
//destroy lds_view_fields_alias
//destroy lds_screen_all
//
//return 1
end function

public function long of_update_view_field_name ();//added by Nova-V11.1 SK IntelliReport  09.02.2010
String file_path, ls_Error
n_cst_datastore lds_import_fieldname,lds_update_fieldname
n_appeon_download lnv_download 
long i,ll_data_view_id=1
string ls_vname,ls_cname,ls_field_name
long ll_found_row

lds_import_fieldname = Create n_cst_datastore
lds_import_fieldname.DataObject = 'd_update_view_field_name'
lds_import_fieldname.SetTransObject(SQLCA)

lds_update_fieldname = Create n_cst_datastore
lds_update_fieldname.DataObject = 'd_update_view_field_name'
lds_update_fieldname.SetTransObject(SQLCA)

IF appeongetclienttype() = 'WEB' THEN 
	file_path = gs_dir_path + "intellicred\update_view_fields.txt" 			
	//Download report text files
	IF lnv_download.of_downloadfile("", file_path) <> 0 THEN
		ls_Error = "n_cst_update_view_fields_alias.of_update_view_field_name() Information: Failed to download " + file_path + ", call support."			
		IF IsValid(gnv_logservice)THEN 
			gnv_logservice.of_setloglevel(2) //warning level
			gnv_logservice.of_log_warning(ls_Error)
			gb_upgrade_failed = TRUE			
		END IF		
	END IF
ELSE 
	file_path = Gs_Current_Directory + "\update_view_fields.txt"			//Start Code Change ----02.04.2010 #V10 maha	//Modified by Scofield on 2008-06-11
END IF

IF FileExists(file_path) = True THEN
		lds_import_fieldname.Reset()
		lds_import_fieldname.ImportFile( file_path )
		lds_update_fieldname.retrieve( )
		IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
		IF IsValid(w_infodisp) THEN
			w_infodisp.Title = 'Update view field name'
			w_infodisp.Center = True
			w_infodisp.st_complete.Visible = False
			w_infodisp.st_3.Visible = False
			w_infodisp.st_information.Visible = False
			w_infodisp.st_1.Text = 'Update view field name, Please stand by'
			w_infodisp.wf_set_min_max(1,lds_import_fieldname.rowcount())
		END IF
		for i=1 to lds_import_fieldname.rowcount()
		if isvalid(w_infodisp) then 
			w_infodisp.wf_step_pbar(1)
			w_infodisp.st_1.text = 'Update ' + string(i) + ' of ' + string(lds_import_fieldname.rowcount())+' Please stand by!'
		end if
		   ls_vname=lds_import_fieldname.object.v_name[i]
			ls_cname=lds_import_fieldname.object.c_name[i]
			ls_field_name=lds_import_fieldname.object.field_name[i]
			ll_found_row= lds_update_fieldname.find("c_name='" + ls_cname + "' and v_name='" + ls_vname + "'", 1, lds_update_fieldname.rowcount())
			do while ll_found_row>0 //update diffrent data_view_id
				lds_update_fieldname.object.field_name[ll_found_row]=ls_field_name
				if ll_found_row<lds_update_fieldname.rowcount() then
					ll_found_row= lds_update_fieldname.find("c_name='" + ls_cname + "' and v_name='" + ls_vname + "'", ll_found_row +1, lds_update_fieldname.rowcount())
				else
					ll_found_row=0
				end if
			loop	
	   next
		
 if lds_update_fieldname.update( )= -1 then
		ls_Error+= "n_cst_update_view_fields_alias.of_update_view_field_name() Information: Upate view field_name failed, call support." 
		IF IsValid(gnv_logservice)THEN 
			gnv_logservice.of_setloglevel(2) //warning level
			gnv_logservice.of_log_warning(ls_Error)
			gb_upgrade_failed = TRUE			
		END IF
 end if
ELSE
	ls_Error = "n_cst_update_view_fields_alias.of_update_view_field_name()  Information:File  does not exist " + file_path + ". Unable to Update view field name."
	IF IsValid(gnv_logservice)THEN 
		gnv_logservice.of_setloglevel(2) //warning level
		gnv_logservice.of_log_warning(ls_Error)
		gb_upgrade_failed = TRUE
	END IF	
END IF

Destroy lds_update_fieldname
RETURN 1

end function

public function integer of_update ();//////////////////////////////////////////////////////////////////////
// $<function> of_update
// $<arguments>
// $<returns> integer
// $<description> Insert or update records
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 02.28.2011
//////////////////////////////////////////////////////////////////////

of_InsertField("v_address", "state_code", "State Code" , 1)
of_InsertField("v_address", "state_name", "State Name" , 1)

//added by Michael 12.21.2011 --- from maha
of_InsertField("v_dept", "department_id", "Department Id" , 1)
of_InsertField("v_dept", "section_id", "Section Id" , 1)
of_InsertField("v_dept", "division_id", "Division Id" , 1)

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 11.11.2014
//<$>reason:Delete records from view_fields_alias except 'data_view_id = 0' 
//<$>for V14.2 Testing/ Bug# 4290 / Duplicate Field in iReport

////added by Michael 02.20.21.2012--- from maha active_status, , , , 
//of_InsertField("v_net_dev_actions", "active_status", "Active Status" , 1)
//of_InsertField("v_net_dev_actions", "create_date", "Create Date" , 1)
//of_InsertField("v_net_dev_actions", "create_user", "Create User" , 1)
//of_InsertField("v_net_dev_actions", "mod_date", "Mod Date" , 1)
//of_InsertField("v_net_dev_actions", "mod_user", "Mod User" , 1)
of_InsertField("v_net_dev_actions", "active_status", "Active Status" , 1 , 0)
of_InsertField("v_net_dev_actions", "create_date", "Create Date" , 1 , 0)
of_InsertField("v_net_dev_actions", "create_user", "Create User" , 1 , 0)
of_InsertField("v_net_dev_actions", "mod_date", "Mod Date" , 1 , 0)
of_InsertField("v_net_dev_actions", "mod_user", "Mod User" , 1 , 0)

// Delete records from view_fields_alias except 'data_view_id = 0'
of_DeleteField("v_net_dev_actions")
//------------------- APPEON END -------------------

//added by Michael 03.30.2012 --- from maha
of_InsertField("v_ctx_feee_schedule_codes", "rev_code", "Rev Code" , 1)


//added by Michael 05.24.2012 --- Bug 3096Ticket # 00035216: Filter options are missing for several fields on the app_audit view
of_InsertField("v_app_audit", "item_description", "Item Description" , 1, 0)
//added by Michael 05.30.2012 --- Bug 3096Ticket # 00035216: Filter options are missing for several fields on the app_audit view
of_InsertField("v_app_audit", "notes", "Notes" , 1, 0)
Return 1
end function

public function integer of_insertfield (string as_v_name, string as_c_name, string as_c_alias, integer ai_visible);//////////////////////////////////////////////////////////////////////
// $<function> of_insertfield
// $<arguments>
//	...
// $<returns> integer
// $<description> Insert records
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Alfee 07.30.2014
//////////////////////////////////////////////////////////////////////

Return of_InsertField(as_v_name, as_c_name, as_c_alias , ai_visible, "")
end function

public function integer of_insertfield (string as_v_name, string as_c_name, string as_c_alias, integer ai_visible, integer ai_view_id);//////////////////////////////////////////////////////////////////////
// $<function> of_insertfield
// $<arguments>
//	...
// $<returns> integer
// $<description> Insert records for as_view_id
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Michael 05.30.2012
//////////////////////////////////////////////////////////////////////

//------------------- APPEON BEGIN -------------------
//<$>Modified:long.zhang 12.25.2014

Return of_InsertField(as_v_name, as_c_name, as_c_alias , ai_visible, ai_view_id,"")

//string ls_SQL
//
//
//
//ls_SQL = &
//"if not exists(select 1 from view_fields_alias where v_name = '" + as_v_name + "' and data_view_id = " + String(ai_view_id) + " and c_name = '" + as_c_name + "')" + &
//"   INSERT INTO view_fields_alias(v_name,data_view_id,c_name,c_alias,visible) " + &
//"   VALUES ('" + as_v_name + "', " + String(ai_view_id) + ", '" + as_c_name + "', '" + as_c_alias + "', " + String(ai_visible) + ") "
//	
//EXECUTE IMMEDIATE :ls_SQL;
//if SQLCA.SQLCode <> 0 then
//	if IsValid(gnv_logservice) then
//		gnv_logservice.of_log(ls_SQL, SQLCA.SQLErrText, "n_cst_update_view_fields_alias.of_insertfield")
//	end if
//	gb_upgrade_failed = true
//end if
//
//
//COMMIT;
//
//Return 1

//------------------- APPEON END -------------------
end function

public function long of_update_view_fields_alias (long al_module, long al_data_view_id, boolean ab_force_update);//====================================================================
// Event: n_cst_update_alias.of_update_alias()
//--------------------------------------------------------------------
// Description:Initialize table view_fields_alias
//--------------------------------------------------------------------
// Arguments:
// long al_module : When DB Update call then set 0,
//                  when View Painter call then set module,such as
//                  1:Contract Logix/2:IntelliCred/App
// long al_data_view_id:
//                  When DB Update call then set 0,
//                  when View Painter call then set data_view_id
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Andy		Date: Nov 28,2007
//--------------------------------------------------------------------
// Modify History:
//		Andy			Date: Dec 04,2007
//		Ken			Date: 07/05/2012 Added ab_force_update argument
// Copied from CLX 11 and modified by (Appeon)Alfee 06.18.2013 for V141 isg-clx
//====================================================================

Long ll_n,ll_Cnt,ll_module,ll_i,ll_ScreenCnt
n_cst_datastore lds_view_alias,lds_view_fields_alias
String ls_Screen,ls_screenID,ls_v_name,ls_ScreenArray[],ls_Nulls[]
n_cst_string lnvo_string
n_cst_datastore lds_screen_all
String ls_Filter,ls_Error
Long ll_R,ll_ScreenAll,ll_data_view_id,ll_aCnt
boolean  lb_Flag

//Added By Ken.Guo 01/19/2012. 
Long ll_find,i,j
String ls_c_name,ls_c_alias


if isnull(al_module) or isnull(al_data_view_id) then 
	return 1
end if
lds_view_alias = create n_cst_datastore
lds_view_alias.dataobject = 'd_view_alias_rpt'
lds_view_alias.settransobject(SQLCA)
lds_view_alias.retrieve( al_module )

ll_Cnt = lds_view_alias.RowCount()
if ll_Cnt < 1 then
	destroy lds_view_alias
	return 1
end if

lds_view_fields_alias = create n_cst_datastore
//d_view_fields_alias
lds_view_fields_alias.dataobject = 'd_view_fields_alias_edit'
lds_view_fields_alias.settransobject(SQLCA)

//Added By Ken.Guo 01/19/2012. 
n_ds lds_view_fields_alias_update
lds_view_fields_alias_update= Create n_ds
If al_data_view_id = 0 Then
	lds_view_fields_alias_update.DataObject = 'd_view_fields_alias_edit_all'
Else
	lds_view_fields_alias_update.DataObject = 'd_view_fields_alias_edit'
End If
lds_view_fields_alias_update.SetTransObject(SQLCA)


lds_screen_all = create n_cst_datastore
lds_screen_all.dataobject = 'd_screen_all'
lds_screen_all.settransobject(SQLCA)
lds_screen_all.retrieve( )

if Not isvalid( w_infodisp ) then open(w_infodisp)
if isvalid(w_infodisp) then w_infodisp.title = 'Update fields alias of view, Please stand by'
if isvalid(w_infodisp) then w_infodisp.Center = TRUE
if isvalid(w_infodisp) then w_infodisp.st_complete.visible = false
if isvalid(w_infodisp) then w_infodisp.st_3.visible = false
if isvalid(w_infodisp) then w_infodisp.st_information.visible = false
if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Update fields alias of view, Please stand by!'
if isvalid(w_infodisp) then w_infodisp.wf_set_min_max(1,ll_Cnt)

FOR ll_n = 1 to ll_Cnt
	//$<Modify> 03.14.2008 by Andy
	if al_module = 0 then Yield()
	if isvalid(w_infodisp) then 
		w_infodisp.wf_step_pbar(1)
		w_infodisp.st_1.text = 'Update ' + string(ll_n) + ' of ' + string(ll_Cnt)+' Please stand by!'
	end if
	
	ll_module = lds_view_alias.getitemNumber(ll_n,"module")
	ls_Screen = lds_view_alias.getitemString(ll_n,"screen")
	ls_v_name = lds_view_alias.getitemString(ll_n,"v_name")
	ls_ScreenArray = ls_Nulls //reset
	ls_Screen = ls_Screen + ','
	lnvo_string.of_parsetoarray( ls_Screen, ',', ls_ScreenArray )
	ll_ScreenCnt = UpperBound(ls_ScreenArray)
	
	//If ll_module = 2 Then Continue //Added By Ken.Guo 01/19/2012. 
	
	ls_Filter = "module=" + String(ll_module)
	//View Painter call
	if al_module > 0 then
		ls_Filter += " And data_view_id=" + String(al_data_view_id)
	end if	
	lds_screen_all.setfilter( ls_Filter )
	lds_screen_all.filter( )	
	ll_ScreenAll = lds_screen_all.RowCount()

	lds_view_fields_alias.Reset() //Added By Ken.Guo 01/19/2012. 
	lds_view_fields_alias_update.Retrieve(ls_v_name, al_data_view_id)	
	
	FOR ll_i = 1 to ll_ScreenCnt

		ls_screenID = ls_ScreenArray[ll_i]
		if Not IsNumber(ls_screenID) then
			//ls_screenID is a dataobject name
			ll_aCnt = 0
//			select TOP 1 1 INTO :ll_aCnt FROM view_fields_alias 
//				where data_view_id = 0 AND v_name = :ls_v_name;
			//No fields alias
	//		IF ll_aCnt = 0 THEN	
				of_get_view_fields_alias(ll_module,0,ls_screenID,ls_v_name,lds_view_fields_alias)
	//		END IF
		else
			//ls_screenID is a screen id
			if isnull(ll_module) or (ll_module <> 1 and ll_module <> 2) then continue
			ll_R = 0
			ls_Filter = "screen_id=" + ls_screenID
			
			DO WHILE (1=1)
				ll_R = lds_screen_all.Find(ls_Filter,ll_R,ll_ScreenAll)
				if ll_R < 1 then exit
				
				ll_data_view_id = lds_screen_all.GetItemNumber(ll_R,"data_view_id")
				ll_aCnt = 0
				select TOP 1 1 INTO :ll_aCnt FROM view_fields_alias 
					where data_view_id = :ll_data_view_id AND v_name = :ls_v_name;
				//No fields alias
//				IF ll_aCnt = 0 THEN
					of_get_view_fields_alias(ll_module,ll_data_view_id,ls_screenID,ls_v_name,lds_view_fields_alias)
//				end if
				
				ll_R ++
				if ll_R > ll_ScreenAll then exit
			LOOP 
			
		end if
		
		//Added By Ken.Guo 01/19/2012. 
		of_after_getaliasformscreen(lds_view_fields_alias)
		for i = 1 to lds_view_fields_alias.rowcount()
			ls_c_name = lds_view_fields_alias.GetItemString(i,"c_name")
			ll_data_view_id = lds_view_fields_alias.GetItemNumber(i,'data_view_id')
			ll_Find   = lds_view_fields_alias_update.Find("lower(c_name) ='" + lower(ls_c_name) + "' and data_view_id = " + String(ll_data_view_id) + " and lower(v_name) = '" +Lower(ls_v_name)+ "'" ,1,lds_view_fields_alias_update.rowcount())
			if ll_Find < 1 then
				//if field alias is not exist, then insert it.
				lds_view_fields_alias.Rowscopy(i,i,Primary!,lds_view_fields_alias_update,lds_view_fields_alias_update.RowCount() + 1,Primary!)
			else
				//if field alias is null(''), then replace it.
				ls_c_alias = lds_view_fields_alias_update.GetItemString(ll_Find,"c_alias")
				if IsNull(ls_c_alias) then ls_c_alias = ""
				if Trim(ls_c_alias) = "" then
					lds_view_fields_alias_update.SetItem(ll_Find,"c_alias",lds_view_fields_alias.GetItemString(i,"c_alias"))
				end if
				
				//If ab_force_update = True then replace it always. //Added By Ken.Guo 07/05/2012
				If ab_force_update Then
					lds_view_fields_alias_update.SetItem(ll_Find,"c_alias",lds_view_fields_alias.GetItemString(i,"c_alias"))
				End If
				
				//Added By Ken.Guo 01/19/2012. 
				If lds_view_fields_alias.GetItemNumber(i,"visible")  = 1 Then
					If lds_view_fields_alias_update.GetItemNumber(ll_find,'visible') = 0 or isnull(lds_view_fields_alias_update.GetItemNumber(ll_find,'visible') ) Then
						lds_view_fields_alias_update.SetItem(ll_Find,"visible",1)
					End If
				End If	

			end if
		next


	NEXT
	
	If lds_view_fields_alias_update.Modifiedcount( ) > 0 Then
		IF lds_view_fields_alias_update.update( ) = -1 THEN
			//db update call
			if al_module = 0 then
				ls_Error+= "n_cst_update_view_fields_alias.of_update_view_fields_alias("+ls_v_name+") Information: Upate view fields alias failed, call support." 
				IF IsValid(gnv_logservice)THEN 
					gnv_logservice.of_setloglevel(2) //warning level
					gnv_logservice.of_log_warning(ls_Error)
					gb_upgrade_failed = TRUE			
				END IF
			end if
		end if
	End If	
	
	
	
NEXT

//Commented By Ken.Guo 01/19/2012
////if don't find alias out, then set a default value.
//of_after_getaliasformscreen(lds_view_fields_alias)
//
//IF lds_view_fields_alias.update( ) = -1 THEN
//	//db update call
//	if al_module = 0 then
//		//ls_Error = '~r~n' + "==================================================="
//		//ls_Error+= "~r~nWarning:n_cst_update_view_fields_alias.of_update_view_fields_alias()~r~nInformation: Upate view fields alias failed." 
//		ls_Error+= "n_cst_update_view_fields_alias.of_update_view_fields_alias() Information: Upate view fields alias failed, call support." 
//		IF IsValid(gnv_logservice)THEN 
//			gnv_logservice.of_setloglevel(2) //warning level
//			gnv_logservice.of_log_warning(ls_Error)
//			gb_upgrade_failed = TRUE			
//		END IF
//		//filewrite(gl_logfilehandle,ls_Error)
//		//gb_Flag = true
//	end if
//end if

if al_module > 0 then
	if isvalid( w_infodisp ) then close(w_infodisp)
end if

//Added By Ken.Guo 07/05/2012. if run from utilities 
If ab_force_update Then
	if isvalid( w_infodisp ) then close(w_infodisp)
End If

destroy lds_view_alias
destroy lds_view_fields_alias
destroy lds_screen_all

return 1
end function

public function integer of_modify_viewalias (datastore ads_view_data, string as_v_name);//====================================================================
//$<Function>: of_modify_viewalias
//$<Arguments>:
// 	value    datastore    ads_view_data
// 	value    string       as_v_name
//$<Return>:  integer
//$<Description>:  Fixed BugL111301 get correct view field alias for intellireport
//Called From of_get_view_fields_alias
//$<Author>: (Appeon) long.zhang 11.19.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

datastore lds_field_prop
long ll_rowcount
Integer ll_i
String ls_field_name
String ls_text
String ls_sqlselect
Integer li_visible

lds_field_prop = create datastore

if lower(as_v_name) = 'v_recruit_prac' then

		lds_field_prop.dataobject = 'd_sys_field_prop_recruiting'
		lds_field_prop.settransobject( sqlca)
		ls_sqlselect = lds_field_prop.Describe("DataWindow.Table.Select")
		
		if lenA(ls_sqlselect) > 0 then
			ls_sqlselect += ' and field_order<>0 and field_id<>18035'
		end if

		lds_field_prop.Modify("DataWindow.Table.Select='"+ls_sqlselect+"'")

		ll_rowcount = lds_field_prop.retrieve( )
		
		if ll_rowcount <= 0 then
			destroy lds_field_prop
			return -1
		end if

		For ll_i = 1 to ll_rowcount
			
				ls_text = lds_field_prop.getitemstring( ll_i,'field_name_allias')
				
				ls_field_name = lds_field_prop.getitemstring( ll_i,'field_name')
				
				li_visible = lds_field_prop.getItemNumber(ll_i,"range_from")
				
				if li_visible = 0 then
						ads_view_data.modify( ls_field_name+".visible = '0'")
						ads_view_data.modify( ls_field_name+"_t.visible = '0'")
						continue
				end if
				ads_view_data.modify( ls_field_name+"_t.text='"+ ls_text +"'")
		end for

end if
destroy lds_field_prop
return 1
end function

public function integer of_insertfield (string as_v_name, string as_c_name, string as_c_alias, integer ai_visible, string as_f_name);//////////////////////////////////////////////////////////////////////
// $<function> of_insertfield
// $<arguments>
//	...
// $<returns> integer
// $<description> Insert records
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 02.28.2011
// Added the new argument "as_f_name" by alfee 07.30.2014
//////////////////////////////////////////////////////////////////////

long ll_Row
long ll_RowCount
string ls_SQL
integer li_data_view_id

ll_RowCount = ids_data_view.RowCount()
for ll_Row = 1 to ll_RowCount
	li_data_view_id = ids_data_view.GetItemNumber(ll_Row, "data_view_id")
	//----------------Begin Modified by alfee 07.30.2014 -----------------------------------------
	ls_SQL = &
	"if not exists(select 1 from view_fields_alias where v_name = '" + as_v_name + "' and data_view_id = " + String(li_data_view_id) + " and c_name = '" + as_c_name + "')" + &
	"   INSERT INTO view_fields_alias(v_name,data_view_id,c_name,c_alias,visible, field_name) " + &
	"   VALUES ('" + as_v_name + "', " + String(li_data_view_id) + ", '" + as_c_name + "', '" + as_c_alias + "', " + String(ai_visible) + ",'" + as_f_name + "') "
	/*ls_SQL = &
	"if not exists(select 1 from view_fields_alias where v_name = '" + as_v_name + "' and data_view_id = " + String(li_data_view_id) + " and c_name = '" + as_c_name + "')" + &
	"   INSERT INTO view_fields_alias(v_name,data_view_id,c_name,c_alias,visible) " + &
	"   VALUES ('" + as_v_name + "', " + String(li_data_view_id) + ", '" + as_c_name + "', '" + as_c_alias + "', " + String(ai_visible) + ") "*/
	//----------------End Modified --------------------------------------------------------------------
		
	EXECUTE IMMEDIATE :ls_SQL;
	if SQLCA.SQLCode <> 0 then
		if IsValid(gnv_logservice) then
			gnv_logservice.of_log(ls_SQL, SQLCA.SQLErrText, "n_cst_update_view_fields_alias.of_insertfield")
		end if
		gb_upgrade_failed = true
	end if
	Yield()
next
COMMIT;

Return 1
end function

public function integer of_deletefield (string as_v_name);//////////////////////////////////////////////////////////////////////
// $<function> of_deletefield
// $<arguments>
//	...
// $<returns> integer
// $<description> Delete records from view_fields_alias except 'data_view_id = 0'
// Added by Appeon long.zhang 11.11.2014 
//////////////////////////////////////////////////////////////////////

long ll_Row
long ll_RowCount
string ls_SQL

ls_SQL = &
"if exists(select 1 from view_fields_alias where v_name = '" + as_v_name + "' and data_view_id <> 0 )" + &
"   DELETE FROM view_fields_alias where v_name = '" + as_v_name + "' and data_view_id <> 0 " 
	
EXECUTE IMMEDIATE :ls_SQL;
if SQLCA.SQLCode <> 0 then
	if IsValid(gnv_logservice) then
		gnv_logservice.of_log(ls_SQL, SQLCA.SQLErrText, "n_cst_update_view_fields_alias.of_deletefield")
	end if
	gb_upgrade_failed = true
end if
Yield()

COMMIT;

Return 1
end function

public function integer of_insertfield (string as_v_name, string as_c_name, string as_c_alias, integer ai_visible, integer ai_view_id, string as_f_name);//////////////////////////////////////////////////////////////////////
// $<function> of_insertfield
// $<arguments>
//	...
// $<returns> integer
// $<description> Insert records for as_view_id
//////////////////////////////////////////////////////////////////////
//Added by Appeon long.zhang 12.25.2014
//////////////////////////////////////////////////////////////////////

string ls_SQL

ls_SQL = &
"if not exists(select 1 from view_fields_alias where v_name = '" + as_v_name + "' and data_view_id = " + String(ai_view_id) + " and c_name = '" + as_c_name + "')" + &
"   INSERT INTO view_fields_alias(v_name,data_view_id,c_name,c_alias,visible,field_name) " + &
"   VALUES ('" + as_v_name + "', " + String(ai_view_id) + ", '" + as_c_name + "', '" + as_c_alias + "', " + String(ai_visible)+ ", '" +String(as_f_name) + "') "
	
EXECUTE IMMEDIATE :ls_SQL;
if SQLCA.SQLCode <> 0 then
	if IsValid(gnv_logservice) then
		gnv_logservice.of_log(ls_SQL, SQLCA.SQLErrText, "n_cst_update_view_fields_alias.of_insertfield")
	end if
	gb_upgrade_failed = true
end if


COMMIT;

Return 1
end function

public function integer of_deletefield (string as_v_name, string as_c_name);//////////////////////////////////////////////////////////////////////
// $<function> of_deletefield
// $<arguments>
//	...
// $<returns> integer
// $<description> Delete records from view_fields_alias except 'data_view_id = 0'
// Added by Appeon long.zhang 11.11.2014 
//////////////////////////////////////////////////////////////////////

long ll_Row
long ll_RowCount
string ls_SQL

ls_SQL = &
"if exists(select 1 from view_fields_alias where v_name = '" + as_v_name + "' and  c_name = '" + as_c_name + "' )" + &
"   DELETE FROM view_fields_alias where v_name = '" + as_v_name + "' and  c_name = '" + as_c_name + "'"
	
EXECUTE IMMEDIATE :ls_SQL;
if SQLCA.SQLCode <> 0 then
	if IsValid(gnv_logservice) then
		gnv_logservice.of_log(ls_SQL, SQLCA.SQLErrText, "n_cst_update_view_fields_alias.of_deletefield(2)")
	end if
	gb_upgrade_failed = true
end if
Yield()

COMMIT;

Return 1
end function

public function integer of_update_view_fields_alias_f (string as_v_name, string as_c_name, string as_f_name);//====================================================================
//$<Function>: of_update_view_fields_alias_f
//$<Arguments>:
// 	value    string    as_v_name
// 	value    string    as_c_name
// 	value    string    as_f_name
//$<Return>:  integer
//$<Description>: Update field name for view_fields_alias
//$<Author>: (Appeon) long.zhang 06.01.2016 (Bug id 5186 - Fields missing from Views, Cannot Quick Select in IntelliReport V14.2 and V15)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

string ls_SQL

ls_SQL = &
"if exists(select 1 from view_fields_alias where v_name = '" + as_v_name +  "' and c_name = '" + as_c_name + "' and field_name is null )" + &
"   UPDATE view_fields_alias " + &
"   SET field_name = '" + as_f_name + "' WHERE  view_fields_alias.v_name = '"+as_v_name+"'  and c_name = '"+ as_c_name+"'"  
	
EXECUTE IMMEDIATE :ls_SQL;
if SQLCA.SQLCode <> 0 then
	if IsValid(gnv_logservice) then
		gnv_logservice.of_log(ls_SQL, SQLCA.SQLErrText, "n_cst_update_view_fields_alias.of_update_view_fields_alias_f")
	end if
	gb_upgrade_failed = true
end if


COMMIT;

Return 1
end function

on n_cst_update_view_fields_alias.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_update_view_fields_alias.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-29 By: Andy

inv_data_entry = CREATE pfc_cst_nv_data_entry_functions
inv_data_entry.of_setup_cache()

app_filler.ids_screen_fields_cache.ShareData( inv_data_entry.ids_screen_fields )
//---------------------------- APPEON END ----------------------------

//------------------- APPEON BEGIN -------------------
//$<add> Evan 02.28.2011
//$<reason> For update report view fields
ids_data_view = Create datastore
ids_data_view.DataObject = "d_dddw_select_view"
ids_data_view.SetTransObject(SQLCA)
ids_data_view.Retrieve()
//------------------- APPEON END ---------------------
end event

event destructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-29 By: Andy

if IsValid(inv_data_entry) then 
	inv_data_entry.ids_screen_fields.sharedataoff( )
	destroy inv_data_entry
end if
//---------------------------- APPEON END ----------------------------

Destroy ids_data_view //add by evan 02.28.2011
end event

