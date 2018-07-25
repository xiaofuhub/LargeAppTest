$PBExportHeader$n_cst_update_screen.sru
forward
global type n_cst_update_screen from nonvisualobject
end type
end forward

global type n_cst_update_screen from nonvisualobject
end type
global n_cst_update_screen n_cst_update_screen

type variables
//05/06/2007 by jervis
string is_update_dataobject[]
datetime idt_update_date[]

n_cst_string inv_string

int ii_num = 1

String is_screen_version = '0075'  //(Appeon)Stephen 11.17.2016 - Intellicred/Contract error message Case#67741 Bug_id#5415//64->73 Modified by (Appeon)Alfee 01.21.2014 - V142 ISG-CLX // long.zhang 04.14.2014 changed 0073 to 0074 (v14.2 Provider-Contract direct linking)
boolean ib_init_fee = false	//jervis 07.22.2010
string is_cacls[]
integer		ii_Screen_ID
end variables

forward prototypes
public function integer of_get_objpos (string as_dwsyntax, string as_objtype, string as_objname, ref long al_spos, ref long al_epos)
public function long of_pos (string as_source, string as_target, long al_start)
public function string of_set_objectpro (ref datastore ads_source, ref datastore ads_properties)
public function integer of_get_objectpro (datastore ids_terget, ref datastore ids_properties, string as_objname)
public function string of_get_update_ai (datastore ads_ai, string as_dataobject)
public function string of_post_update (datastore ads_source, long al_screen_id)
public subroutine of_update_object (datastore ads_target, datastore ads_source, datastore ads_properties, string as_forceupdate)
public subroutine of_restore_in ()
public function integer of_force_update_button (ref datastore ads_source, integer ai_screen_index)
public subroutine of_appeon2_changes (boolean ab_force_update)
public function integer of_update_fee_calc (long al_view_id, long al_ctx_id, datastore ads_fee, string as_calcs[])
public subroutine of_per_screen_process ()
public subroutine of_modifydatawindow (ref string as_freeform, ref string as_grid, string as_method)
public function integer of_get_object_attribute (datastore ids_terget, ref datastore ids_properties, string as_objname)
public function integer of_update_fee_calc (long al_view_id)
public function string of_special_update (string as_syntax, long al_screen_id, datastore ads_sql, long al_view_id)
public function integer of_get_object_attribute (datastore ids_terget, ref datastore ids_properties, string as_sobjname, string as_tobjname)
public function integer of_appeon2_changes (long al_view_id, long al_screen_id, ref string as_sql, string as_dataobject, datastore ads_screen)
public function integer of_force_update_button_once (ref datastore ads_source, integer ai_screen_index)
public function string of_get_dw_original_syntax (string as_class, integer ai_data_view_id, integer ai_screen_id)
public function integer of_modify_attribute (datastore ads_ds, string as_attribute)
public function integer of_get_upgrade_dw (string as_freeobject[], string as_gridobject[], boolean ab_forceupdate, ref boolean ab_update[], ref n_ds ads_original, ref string as_freesyntax[], ref string as_gridsyntax[])
public function integer of_splitsyntax (string as_syntax, ref string as_presyntax, ref string as_lastsyntax, ref n_ds ads_mid)
public subroutine of_arrageobject (ref string as_source, string as_target)
public function integer of_align_object (datastore ads_grid)
public function string of_align_object (datastore ads_grid, string as_tips)
public function integer of_align_object (datawindow adw_grid1, datawindow adw_grid2, string as_tips)
public function integer of_update_changeobject (datastore ads_source, datastore ads_target, datastore ads_properties, string as_forceupdate)
public function string of_setobjectattribute_value (string as_content, string as_objects[], string as_values[])
public function integer of_getobjectattribute_value (string as_content, string as_objects[], string as_values[])
public subroutine of_repair_picture ()
end prototypes

public function integer of_get_objpos (string as_dwsyntax, string as_objtype, string as_objname, ref long al_spos, ref long al_epos);string ls_objSyntax
long ll_pos
string ls_prefix

al_sPos = 0
al_ePos = 0

if as_objtype = '!' or as_objtype = "?" then
	return 0
end if

//Replace DW Syntax
ll_Pos = pos(as_dwsyntax,"name=" + lower(as_Objname))
if ll_pos = 0 then return -1
			
ls_prefix = MID(as_dwsyntax,1,ll_Pos - 1)
al_sPos   = of_pos(ls_prefix,"~r~n" + lower(as_objtype) + "(",len(ls_prefix)) + 2 

al_ePos   = pos(as_dwsyntax,")~r~n",ll_Pos) + 1

return 1
end function

public function long of_pos (string as_source, string as_target, long al_start);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Pos	
//
//	Access:  		public
//
//	Arguments:
//	as_Source		The string being searched.
//	as_Target		The being searched for.
//	al_start			The starting position, 0 means start at the end.
//
//	Returns:  		Long	
//						The position of as_Target.
//						If as_Target is not found, function returns a 0.
//						If any argument's value is NULL, function returns NULL.
//
//	Description: 	Search backwards through a string to find the last occurrence 
//						of another string.
// Author     :   Andy 07/03/2007
//////////////////////////////////////////////////////////////////////////////

Long	ll_Cnt, ll_Pos

//Check for Null Parameters.
IF IsNull(as_source) or IsNull(as_target) or IsNull(al_start) Then
	SetNull(ll_Cnt)
	Return ll_Cnt
End If

//Check for an empty string
If Len(as_Source) = 0 Then
	Return 0
End If

// Check for the starting position, 0 means start at the end.
If al_start=0 Then  
	al_start=Len(as_Source)
End If

//Perform find
For ll_Cnt = al_start to 1 Step -80
	ll_Pos = Pos(as_Source, as_Target, ll_Cnt)
	If ll_Pos > 0 and ll_Pos <= al_start Then 
		//String was found
		Return ll_Pos
	End If
Next

//String was not found
Return 0

end function

public function string of_set_objectpro (ref datastore ads_source, ref datastore ads_properties);Integer i, li_count
String ls_objname,ls_proname, ls_provalue, ls_exp
String ls_rtn,ls_err
n_cst_string lnv_string
//<add> 12.14.2007 by: Andy
String ls_objList[], ls_BandList[], ls_Band, ls_sSyntax
Long   ll_j, ll_Cnt = 0, ll_sPos_s, ll_ePos_s
Long   ll_pos, ll_NextBlank
String ls_Type,ls_newObjSyntax
//end of add

li_count = ads_properties.rowcount()
if li_count <=0 then
	return ""
end if

for i = 1 to li_count
	ls_objname = ads_properties.object.obj_name[i]  
	ls_proname = ads_properties.object.obj_pro[i]  
	ls_provalue = ads_properties.object.obj_value[i]  
	//<add> 12.14.2007 by: Andy
	//Record different band list. 
	if lower(ls_proname) = 'band' then
		ls_Band = ads_source.describe(ls_objname + '.band')
		if lower(ls_provalue) <> lower(ls_Band) then
			ll_Cnt ++
			ls_objList[ll_Cnt] = ads_properties.object.obj_name[i]    
			ls_BandList[ll_Cnt] = ads_properties.object.obj_value[i] 
		end if
		continue
	end if
	//end of add
	
	//Start Code By Jervis 03.11.2008
	//Expressions involving Null values may arrive at different values in JavaScript 
	//from their values in PowerScript
	//if not isnull(ls_provalue) then
	//End Code By Jervis 03.11.2008
		if Match(ls_provalue,'^\".*\"$') or Match(ls_provalue,"^\'.*\'$") then	//04/27/2007 By jervis Fixed a defect for APB
			ls_exp = ls_objname + "." + ls_proname +" = " + ls_provalue
		else
			ls_exp =ls_objname + "." + ls_proname +" = '" + ls_provalue + "'"
		end if
		
		ls_rtn = ads_source.modify(ls_exp)
		if ls_rtn <> "" then
			ls_exp =ls_objname + "." + ls_proname +" = " + ls_provalue
			ls_rtn = ads_source.modify(ls_exp)
			//--------------------------- APPEON BEGIN ---------------------------
			//$<  Add > 2007-07-16 By: Scofield
			//$<Reason> After upgrade,the compute column's expression is not right.
			if ls_rtn <> "" then
				ls_exp =ls_objname + "." + ls_proname +' = "' + ls_provalue + '"'
				ls_rtn = ads_source.modify(ls_exp)
			end if
			//---------------------------- APPEON END ----------------------------
		end if
	//end if
next

//<add> 12.14.2007 by: Andy
//Reason:Because the band property is Describe only
if ll_Cnt > 0 then
	ls_sSyntax = ads_source.Describe("DataWindow.Syntax")
	FOR ll_j = 1 TO ll_Cnt
		ls_Type = ads_source.describe(ls_objList[ll_j] + '.Type')		
		of_get_ObjPos(ls_sSyntax,ls_type,ls_objList[ll_j] + " ",ll_sPos_s,ll_ePos_s)
		ls_newObjSyntax = Mid(ls_sSyntax,ll_sPos_s,ll_ePos_s - ll_sPos_s)
		
		ll_pos = pos(ls_newObjSyntax," band=")
		ll_NextBlank = pos(ls_newObjSyntax," ",ll_pos + 6)
		IF ll_Pos > 0 AND ll_NextBlank > 0 THEN
			ls_newObjSyntax = replace(ls_newObjSyntax,ll_Pos ,ll_NextBlank - ll_pos," band="+lower(ls_BandList[ll_j])+" ")
		END IF
		ls_sSyntax = Replace(ls_sSyntax,ll_sPos_s,ll_ePos_s - ll_sPos_s, ls_newObjSyntax)
	NEXT
	ads_source.Create(ls_sSyntax,ls_Err)
end if
//end of add

return ads_source.Describe("DataWindow.Syntax")
end function

public function integer of_get_objectpro (datastore ids_terget, ref datastore ids_properties, string as_objname);Integer i,li_objcount

String ls_colpro[],ls_DwPro[]
String ls_proname, ls_provalue
Integer j, li_colcount,li_DwProCount
Integer li_insert
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-10-24 By: Andy
Integer li_txtcount
String  ls_band,ls_txtpro[],ls_type

//<Modify> 12.14.2007 by: Andy
//Reason:Add "Band","Footer.Height","Summary.Height","Header.Height"
//Add Font.face,Font.strikethrough,font.heigth - jervis 09.06.2011
ls_txtpro = {"Font.face","Font.strikethrough","font.height","Band","Font.Italic","Font.Underline","Font.Weight","text","x","y","width","height","alignment","Color","Background.Mode","Background.Color","visible","border"}//<modify> 05.26.2008 by Andy  del:,"tag"
li_txtcount = UpperBound(ls_txtpro)
ls_type = ids_terget.Describe(as_objname + ".type")
ls_band = ids_terget.Describe(as_objname +".Band")
//---------------------------- APPEON END ----------------------------

//Delete Font.face - jervis 01.13.2011
//Init update properties
//Add ddlb.VScrollBar,edit.VScrollBar,edit.format,format,ddlb.AutoHScroll,SlideUp,Height.AutoSize -- jervis 04.21.2011
//Add Font.face,Font.strikethrough,font.heigth - jervis 09.06.2011
ls_colpro = {"Font.face","Font.strikethrough","font.height","Band","Font.Italic","Font.Underline","Font.Weight","x","y","width","height","alignment","tabsequence",&
"Edit.Required","dddw.Required","ddlb.Required","EditMask.Required","Edit.Case","DDLB.Case","EditMask.Mask","edit.displayonly","edit.AutoHScroll","edit.NilIsNull",&
"dddw.VscrollBar","dddw.AutoHScroll","dddw.useasborder","dddw.NilIsNull","dddw.name","dddw.datacolumn","dddw.displaycolumn","dddw.PercentWidth","tag",&
"Initial","visible","border","Color","Background.Mode","Background.Color","ddlb.VScrollBar","edit.VScrollBar","edit.format","format","ddlb.AutoHScroll","SlideUp","Height.AutoSize",&
"checkbox.3d","checkbox.lefttext","checkbox.off","checkbox.on","checkbox.other","checkbox.scale","checkbox.text"}//,"protect"

//ls_DwPro = {"Detail.Height","Table.Sort"}

//add Detail.Height.AutoSize -- jervis 04.21.2011
ls_DwPro = {"Detail.Height","Table.Sort","Footer.Height","Summary.Height","Header.Height","Color","Detail.Height.AutoSize"}//"DataWindow.Color"}//modified by nova  2008/09/17 //Modify by Evan 07.21.2008, add DataWindow.Color property
//end of modify
li_colcount = UpperBound(ls_colpro)
li_DwProCount = UpperBound(ls_DwPro)

//modify 10/24/2007 by: Andy
//if ids_terget.Describe(as_objname + ".type") = "column" then
if lower(ls_type) = "column" then
	For j = 1 To li_colcount
		ls_proname = ls_colpro[j]
		ls_provalue = ids_terget.Describe(as_objname+"."+ls_proname)
		if isnull(ls_provalue) then ls_provalue = "!"
		Choose Case ls_provalue
			Case "!","?"
				Continue
			Case Else
				//Start Code By Jervis 03.11.2008
				//Fixed Bug,Expressions involving Null values may arrive at different values in JavaScript 
				//from their values in PowerScript
				//if isnull(ls_provalue) then continue
				//if ls_proname = 'Initial' and ls_provalue = 'null' then setnull(ls_provalue)
				//End Code By Jervis 03.11.2008
				li_insert = ids_properties.InsertRow(0)
				ids_properties.Object.obj_name[li_insert] = as_objname
				ids_properties.Object.obj_pro[li_insert] = ls_proname
				ids_properties.Object.obj_value[li_insert] = ls_provalue
		End Choose
	Next
elseif lower(ls_type) = "text" then
	For j = 1 To li_txtcount
		ls_proname = ls_txtpro[j]
		ls_provalue = ids_terget.Describe(as_objname+"."+ls_proname)
		if isnull(ls_provalue) then ls_provalue = "!"
		Choose Case ls_provalue
			Case "!","?"
				Continue
			Case Else
				li_insert = ids_properties.InsertRow(0)
				ids_properties.Object.obj_name[li_insert] = as_objname
				ids_properties.Object.obj_pro[li_insert] = ls_proname
				ids_properties.Object.obj_value[li_insert] = ls_provalue
		End Choose
	Next
end if

if lower(as_objname) = "datawindow" then
	for j = 1 to li_DwProCount
		ls_proname = ls_DwPro[j]
		ls_provalue = ids_terget.Describe("DataWindow." + ls_proname)
		Choose Case ls_provalue
			Case "!","?"
				Continue
			Case Else
				li_insert = ids_properties.InsertRow(0)
				ids_properties.Object.obj_name[li_insert] = as_objname
				ids_properties.Object.obj_pro[li_insert] = ls_proname
				ids_properties.Object.obj_value[li_insert] = ls_provalue
			End Choose	
	next
end if

Return 1
end function

public function string of_get_update_ai (datastore ads_ai, string as_dataobject);//====================================================================
// Event: n_cst_update_screen.of_get_update_ai()
//--------------------------------------------------------------------
// Description:Get once update syntax
//--------------------------------------------------------------------
// Arguments:
// 	value	datastore	ads_ai       	
// 	value	string   	as_dataobject	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Alfee		Date: Feb 26,2008
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//				Andy     Date: May 28,2008
//====================================================================
String ls_action_type_x, ls_action_type_w //for action_type
String ls_action_date_x, ls_action_date_w //for action date
String ls_due_date_x, ls_due_date_y, ls_due_date_w, ls_due_date_h //for due_date
String ls_x, ls_y, ls_w, ls_h //for b_due_date
String ls_visible, ls_ver, ls_sql="", ls_error_create
String ls_text,ls_SeachSpec,ls_Name
string ls_null[]

IF Not IsValid(ads_ai) THEN RETURN ""

CHOOSE CASE as_dataobject
	CASE 'd_cntx_action_items','d_dm_doc_ai_detail'
		
		//Add Action Item Status Track  -- jervis 11.08.2010
		ls_visible = ads_ai.Describe("b_action_status.visible")
		if ls_visible = '?' or ls_visible = '!' then
			ls_x = string(long(ads_ai.Describe("action_status.x")) + long(ads_ai.Describe("action_status.width")))
			ls_y = ads_ai.Describe("action_status.y")
			ls_sql +=" b_action_status.visible = 1 b_action_status.x ='" + ls_x + "' b_action_status.y ='" + ls_y + "'"
		end if
			
		//$<add> 04.23.2008 by Andy
		//$<Reason> Round a APB bug
		IF as_dataobject = 'd_cntx_action_items' THEN 
			ls_text = ads_ai.describe( "letter_from_name_t.text" )
			if pos(ls_text,'if') > 0 then
				ls_sql += " letter_from_name_t.text='Letter/Email From' "
			end if
			ls_text = ads_ai.describe( "letter_to_name_t.text" )
			if pos(ls_text,'if') > 0 then					
				ls_sql += " letter_to_name_t.text='Letter/Email To' "
			end if	
			
		END IF
		//end add 04.23.2008
		
		
		ls_visible = ads_ai.Describe("b_due_date.visible")
		//Do it if the button not exists or not have expression
		IF Pos(ls_visible,'if') > 0 THEN
			RETURN ls_sql//""
		END IF

		//Generate the SQL statement to adjust the UI if the button existed and invisible
		IF as_dataobject = 'd_cntx_action_items' THEN //contract action item
			//Determine if the UI of AI is ver 6.0 or greater than 6.0	
			ls_due_date_x = ads_ai.Describe("due_date.x")
			ls_action_date_x = ads_ai.Describe("action_date.x")
			IF IsNumber(ls_due_date_x) and IsNumber(ls_action_date_x) THEN 
				IF Long(ls_due_date_x) > Long(ls_action_date_x) THEN ls_ver = '6.0' 
			END IF
		
			//----------Begin Modified by Alfee 03.31.2008-------------------------------------------
			//Get other positions for related fields
			ls_action_type_x = ads_ai.Describe("action_type.x")
			ls_action_type_w = ads_ai.Describe("action_type.width")
			ls_action_date_w = ads_ai.Describe("action_date.width")
			ls_due_date_w = ads_ai.Describe("due_date.width")
		
			//Generate the adjustment sql statement
			IF ls_ver = '6.0' THEN
				//Get the width of the action type field shortened
				IF Long(ls_action_type_w) > 115 THEN ls_action_type_w = String(Long(ls_action_type_w) - 115 )
				//Get the new coordinate x of action date and due date fields
				IF Long(ls_action_date_x) > Long(ls_action_type_x) + Long(ls_action_type_w) THEN ls_action_date_x = String(Long(ls_action_date_x) - 115)
				IF Long(ls_due_date_x) > Long(ls_action_date_x) + Long(ls_action_date_w) THEN ls_due_date_x = String(Long(ls_due_date_x) - 115)
				//Get the new coordinate x of b_due_date
				ls_x = String( Long(ls_due_date_x) + Long(ls_due_date_w) + 18 )
				//Generate the modfication sql statment
				ls_sql = "action_type.width='" + ls_action_type_w + "' action_type_t.width='" + ls_action_type_w + "' " + &
							"action_date.x='" +ls_action_date_x + "' action_date_t.x='" + ls_action_date_x + "' "  + &
							"due_date.x='" + ls_due_date_x + "' due_date_t.x='" + ls_due_date_x + "' " + & 
							"b_due_date.x='" + ls_x + "' b_due_date_g.x='" + ls_x + "' b_due_date_r.x='" + ls_x + "' " + &
							"b_due_date.visible='1~tif(isnull(due_date_flag) or due_date_flag = 0,1,0)' b_due_date_g.visible='0~tif(due_date_flag = 1,1,0)' b_due_date_r.visible='0~tif(due_date_flag = 2,1,0)' b_due_date.filename='GRAYflag.bmp' "	
			//IF ls_ver = '6.0' THEN
				//ls_sql = "action_type.width='434' action_type_t.width='434' action_date.x='677' action_date_t.x='677' "  + &
				//			"due_date_t.x='1083' due_date.x='1083' b_due_date.x='1486' b_due_date_g.x='1486' b_due_date_r.x='1486' b_due_date.visible='1~tif(isnull(due_date_flag) or due_date_flag = 0,1,0)' b_due_date_g.visible='0~tif(due_date_flag = 1,1,0)' b_due_date_r.visible='0~tif(due_date_flag = 2,1,0)' b_due_date.filename='GRAYflag.bmp' "
							
			//----------End Modified -----------------------------------------------------------------					
			ELSe
				ls_sql = "action_type.width='466' action_type_t.width='466' " + &
							"due_date_t.x='818' due_date.x='818' b_due_date.x='1225' b_due_date_g.x='1225' b_due_date_r.x='1225' b_due_date.visible='1~tif(isnull(due_date_flag) or due_date_flag = 0,1,0)' b_due_date_g.visible='0~tif(due_date_flag = 1,1,0)' b_due_date_r.visible='0~tif(due_date_flag = 2,1,0)' b_due_date.filename='GRAYflag.bmp' "
			END IF	
		ELSEIF as_dataobject = 'd_dm_doc_ai_detail' THEN //document manager action item
			ls_sql = "ctx_am_action_item_action_type_t.x='187' action_type.x='187' ctx_am_action_item_attempt_times_t.x='187' attempt_times.x='187' due_date.x='658' ctx_am_action_item_due_date_t.x='658' due_date.width='352' ctx_am_action_item_due_date_t.width='352' ctx_am_action_item_first_attempt_t.x='658' ctx_am_action_item_first_attempt_t.width='462' first_attempt.x='658' first_attempt.width='462' b_due_date.x='1019' b_due_date_g.x='1019' b_due_date_r.x='1019' b_due_date.visible='1~tif(isnull(due_date_flag) or due_date_flag = 0,1,0)' b_due_date_g.visible='0~tif(due_date_flag = 1,1,0)' b_due_date_r.visible='0~tif(due_date_flag = 2,1,0)' b_due_date.filename='GRAYflag.bmp' "
		END IF
		
		//Get & locate the Y coordinate of button 'b_due_date'
		IF as_dataobject = 'd_cntx_action_items' or as_dataobject = 'd_dm_doc_ai_detail' THEN
			ls_due_date_y = ads_ai.Describe("due_date.y")
			ls_due_date_h = ads_ai.Describe("due_date.height")
			ls_h = '88' //03.31.2008
			//ls_h = ads_ai.Describe("b_due_date.height")
			IF IsNumber(ls_due_date_y) and IsNumber(ls_due_date_h) and IsNumber(ls_h) THEN
				ls_y = String(Long(ls_due_date_y) - Long(ls_h) + Long(ls_due_date_h) + 12)
			END IF
			IF IsNumber(ls_y) THEN ls_sql += "b_due_date.y='" + ls_y + "' b_due_date_g.y='" + ls_y + "' b_due_date_r.y='" + ls_y + "' "
		END IF
		
		
		
	CASE 'd_contract_search'
		//$<modify> 01.15.2008 by Andy
		ls_text = ads_ai.describe( "b_more.visible" )
		if ls_text <> '1' then
			ls_SeachSpec = " contract_type_t.visible='1' contract_type.visible='1' custom_date1_t.visible='1' custom_date1.visible='1' custom_1_t.visible='1' custom_1.visible='1' custom_2_t.visible='1' custom_2.visible='1' custom_3_t.visible='1' custom_3.visible='1' custom_4_t.visible='1' custom_4.visible='1' custom_n1_t.visible='1' custom_n1.visible='1' custom_n2_t.visible='1' custom_n2.visible='1' custom_n3_t.visible='1' custom_n3.visible='1' custom_n4_t.visible='1' custom_n4.visible='1' custom_n5_t.visible='1' custom_n5.visible='1' custom_n6_t.visible='1' custom_n6.visible='1' term_date_t.visible='1' term_date.visible='1' term_date_2_t.visible='1' term_date_2.visible='1' last_revis_date_t.visible='1' last_revis_date.visible='1' last_revis_date_2_t.visible='1' last_revis_date_2.visible='1' review_date_t.visible='1' review_date.visible='1' review_date_2_t.visible='1' review_date_2.visible='1' DataWindow.Detail.Height='924' "
			ls_sql = ls_SeachSpec
		end if
		//end of modify 01.15.2008 
		
		//$<modify> 11.14.2008 by Jervis
		ls_text = ads_ai.Describe("b_clear.visible")
		if ls_text <> "!" and ls_text <> "?" then	//Fixed BugJ042702-- Jervis 04.27.2009
			ls_text = ads_ai.Describe("b_search.visible")
			long  ll_diff
			if ls_text <> '1' then
				ll_diff = long(ads_ai.describe("b_clear.x")) - long(ads_ai.describe("b_more.x"))
				ls_sql += " b_search.x = '" + ads_ai.describe("b_clear.x") + "' b_clear.x = '" + string(long(ads_ai.describe("b_clear.x")) + ll_diff) + "' b_search.visible ='1'"
				ls_sql += " b_clear.y = 372 b_search.y = 372 b_more.y = 372"	//Added by Scofield on 2008-12-16
			end if
		else	//Fixed BugJ042702-- Jervis 04.27.2009
			ls_sql += " b_search.visible ='1'"
		end if
		//end of modify 11.14.2008 
		
	CASE 'd_contract_det_master'
		//$<add> 05.28.2008 by Andy
		ls_Visible = ads_ai.describe( "total_processing_time_t.visible" )
		//Mark tag if the object not exists.
		if ls_Visible = '?' or ls_Visible = '!' then
			ls_sql = " total_processing_time_t.Tag='1' "
		end if
		
		//$<add> 06.03.2008 by Andy
		ls_Visible = ads_ai.describe( "b_statustrack.visible" )
		//Mark tag if the object not exists.
		if ls_Visible = '?' or ls_Visible = '!' then
			ls_sql += " b_statustrack.Tag='1' "
		end if
		
		//Change dddw.name of company field - jervis 12.13.2010
		ls_name = ads_ai.Describe("app_facility.dddw.name")
		if ls_name <> "dddw_contact_company_new" then
			//ls_sql += " app_facility.dddw.name = dddw_contact_company_new"
			ls_sql += " app_facility.dddw.name = 'dddw_contact_company_new'"  //jervis 01.21.2010 APB Bug
		end if
		
	CASE 'd_contract_det_notes'
		//$<add> 06.13.2008 by Andy
		ls_Visible = ads_ai.describe( "b_insert.visible" )
		//Mark tag if the object not exists.
		if ls_Visible = '?' or ls_Visible = '!' then
			ls_sql = " b_insert.visible='1' "
		end if
	CASE 'd_contract_det_contact_external'	//Added By Alan on 2009-1-20
		ls_x = ads_ai.describe( "phone_ext.x" )
		if ls_x = '?' or ls_x = '!' then
			ls_sql = " phone_ext.visible = '1' phone_ext_t.visible = '1'"
		end if
	CASE 'd_contract_profile_req2','d_contract_profile_req_existing'
		ls_Name = ads_ai.Describe("b_editword_isempty.Name")
		if ls_Name = '?' or ls_Name = '!' then
			ls_sql = ' create button(band=detail text="" filename="Word_IsEmpty.jpg" enabled=yes action="0" border="0" color="0" x="3607" y="8" height="104" width="119" vtextalign="0" htextalign="0"  name=b_editword_isempty visible="1~tif(isNull(elements_id) or image_length > 0,0,1)"  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="67108864" ) '
		end if
		
		ls_Name = ads_ai.Describe("b_editword_notempty.Name")
		if ls_Name = '?' or ls_Name = '!' then
			ls_sql += ' create button(band=detail text="" filename="Word_NotEmpty.jpg" enabled=yes action="0" border="0" color="0" x="3607" y="8" height="104" width="119" vtextalign="0" htextalign="0"  name=b_editword_notempty visible="1~tif(isNull(elements_id) or image_length <= 0,0,1)"  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="67108864" ) '
		end if
	case 'd_contract_fee_sched_nm'  //Fee Schedule (NM)->Fee Schedule (Non Healthcare) - jervis 12.8.2009
		ls_name = ads_ai.Describe("compute_row.name")
		if ls_name = '?' or ls_name = '!' then
			ls_sql = "compute_row.visible = 1"
			if long(ads_ai.Describe("datawindow.footer.height")) < 60 then
				ls_sql += "  datawindow.footer.height = '64'"
			end if
		end if
		
		//Add Fee Sched cacls field - jervis 07.22.2010
		/*
		is_cacls = ls_null
		ls_name = ads_ai.Describe("calc_field_1.name")
		if ls_name = '?' or ls_name = '!' then
			ls_sql += " calc_field_1.visible = 1 "
			is_cacls[UpperBound(is_cacls) + 1] =  "calc_field_1"
			ib_init_fee = true
		end if
		ls_name = ads_ai.Describe("calc_field_2.name")
		if ls_name = '?' or ls_name = '!' then
			ls_sql += " calc_field_2.visible = 1 "
			is_cacls[UpperBound(is_cacls) + 1] =  "calc_field_2"
			ib_init_fee = true
		end if
		ls_name = ads_ai.Describe("calc_field_3.name")
		if ls_name = '?' or ls_name = '!' then
			ls_sql += " calc_field_3.visible = 1 "
			is_cacls[UpperBound(is_cacls) + 1] =  "calc_field_3"
			ib_init_fee = true
		end if
		*/

	CASE ELSE
		//DO NOTHING
		
END CHOOSE

RETURN ls_sql
end function

public function string of_post_update (datastore ads_source, long al_screen_id);//====================================================================
// Event: n_cst_update_screen.of_post_update()
//--------------------------------------------------------------------
// Description:Special update after upgrade if Need. 
//--------------------------------------------------------------------
// Arguments:
// 	value	datastore	ads_source  	
// 	value	long     	al_screen_id	
//--------------------------------------------------------------------
// Returns:  String
//--------------------------------------------------------------------
// Author:	Andy		Date: Mar 19,2008
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
String ls_Modify="",ls_temp,ls_temp2 
Long   ll_i
long ll_y,ll_max,ll_x,ll_Width,ll_Width2
long ll_Cnt
string ls_object[]
long ll_height
integer i
		
CHOOSE CASE al_screen_id 
	CASE 9
		ls_temp = "custom_date"
		FOR ll_i = 1 to 15
			ls_Modify += "b_" + ls_temp + String(ll_i) + ".visible='" + ads_source.describe(ls_temp + String(ll_i) + ".visible") + "' "
		NEXT		
		ads_source.Modify(ls_Modify)
			
	CASE 3
		//$<modify> 05.28.2008 by Andy
		ls_temp  = ads_source.Describe("master_contract_name.visible")
		ls_temp2 = ads_source.Describe("total_processing_time_t.Tag")
		
		if ls_temp <> '1' OR ls_temp2 = '1' then
			inv_string.of_parsetoarray( ads_source.describe("datawindow.objects"), "~t", ls_object)
			ll_Cnt = upperbound(ls_object)
			
			FOR i = 1 TO ll_Cnt
				//skip below fields.
				if ls_temp <> '1' then
					if ls_object[i] = 'b_contract_search' or ls_object[i] = 'master_contract_name' or ls_object[i] = 't_1' or &
						ls_object[i] = 'total_processing_time_t' or ls_object[i] = 'total_processing_time' then 
						continue
					end if
				else
					if ls_object[i] = 'total_processing_time_t' or ls_object[i] = 'total_processing_time' then continue
				end if
				//Figure out max height
				If ads_source.Describe(ls_object[i] + ".visible") = '1' Then
					if ads_source.Describe(ls_object[i] + ".type") = 'line' then
						ll_y = long(ads_source.Describe(ls_object[i] + ".y2"))
						ll_height = 0
					else
						ll_y = long(ads_source.Describe(ls_object[i] + ".y"))
						ll_height = long(ads_source.Describe(ls_object[i] + ".height"))
					end if
					
					If ll_y + ll_height > ll_max Then ll_max = ll_y + ll_height
				End If
			Next
			
			if ls_temp <> '1' then
				ll_y = long(ads_source.Describe("t_1.y"))
				ll_height = long(ads_source.Describe("t_1.height"))
				
				//Move Master Contract ID to the end of dw
				if ll_y < ll_max then
					ls_Modify = "t_1.y='" + String(ll_max + 24) + "' master_contract_name.y='" + String(ll_max + 24 + ll_height + 12) + "' b_contract_search.y='" + String(ll_max + 24 + ll_height + 4) + "'"
					ads_source.Modify(ls_Modify)
					
					ll_y = long(ads_source.Describe("b_contract_search.y"))
					ll_height = long(ads_source.Describe("b_contract_search.height"))
					ls_Modify = "total_processing_time_t.y='" + String(ll_y + ll_height + 36) + "' total_processing_time.y='" + String(ll_y + ll_height + 36) + "'"
					ads_source.Modify(ls_Modify)
					
					ll_y = long(ads_source.Describe("total_processing_time_t.y"))
					ll_height = long(ads_source.Describe("total_processing_time_t.height"))					
					ls_Modify = "DataWindow.Detail.Height='" + String(ll_y + ll_height + 16) + "'"
					ads_source.Modify(ls_Modify)
				end if
				
				ls_Modify = "group_multi_loc_id_t.visible='0' group_multi_loc_id.visible='0'  b_contract_search.visible='0'  t_1.visible='1' b_contract_search.filename='find.bmp'"
				ads_source.Modify(ls_Modify) //master_contract_name.visible='1' b_contract_search.visible='1'  modified by gavins 20120524      due to "b_contract_search" need hide
				
				if ls_temp2 = '1' then
					ls_Modify = "total_processing_time_t.visible='1' total_processing_time.visible='1' total_processing_time_t.Tag=''"
					ads_source.Modify(ls_Modify)
					
					ll_y = long(ads_source.Describe("total_processing_time_t.y"))
					ll_height = long(ads_source.Describe("total_processing_time_t.height"))					
					ls_Modify = "DataWindow.Detail.Height='" + String(ll_y + ll_height + 16) + "'"
					ads_source.Modify(ls_Modify)
				end if
			else
				//if total_processing_time_t.Tag='1',then set visible = 1 and adjust positions for total_processing_time_t and total_processing_time
				ll_y = long(ads_source.Describe("total_processing_time_t.y"))
				if ll_y < ll_max then
					ls_Modify = "total_processing_time_t.y='" + String(ll_max + 36) + "' total_processing_time.y='" + String(ll_max + 36) + "'"
					ads_source.Modify(ls_Modify)
				end if
				
				ll_y = long(ads_source.Describe("total_processing_time_t.y"))
				ll_height = long(ads_source.Describe("total_processing_time_t.height"))					
				ls_Modify = "DataWindow.Detail.Height='" + String(ll_y + ll_height + 16) + "'"
				ads_source.Modify(ls_Modify)
				
				ls_Modify = "total_processing_time_t.visible='1' total_processing_time.visible='1' total_processing_time_t.Tag=''"
				ads_source.Modify(ls_Modify)
			end if
		end if
		
		//$<add> 06.03.2008 by Andy
		ls_temp2 = ads_source.Describe("b_statustrack.Tag")
		if ls_temp2 = '1' then
			ll_y     = Long(ads_source.Describe("status.y"))
			ll_height= Long(ads_source.Describe("status.height"))
			ll_x     = Long(ads_source.Describe("status.x"))
			ll_Width = Long(ads_source.Describe("status.Width"))
			ll_Width2= Long(ads_source.Describe("b_statustrack.Width"))
			ls_Modify= "status.Width='" + String(ll_Width - ll_Width2 - 18 ) + "' b_statustrack.x='" + String(ll_x + ll_Width - ll_Width2) + "' b_statustrack.y='" + String(ll_y - 8) + "' b_statustrack.height='" + String(ll_height + 12) + "' b_statustrack.Tag='' b_statustrack.visible='1'"
			ads_source.Modify(ls_Modify)
		end if
	CASE 12,13
		//ls_Modify =  "b_editword_notempty.visible = ~"1~~tif( ctx_req_tmplt_element_show_word_ico = 0 or isNull(elements_id) or IsNull(image_length) or image_length <= 0,0,1) ~" "
		//ls_Modify += "b_editword_isempty.visible  = ~"1~~tif( ctx_req_tmplt_element_show_word_ico = 0 or isNull(elements_id) or IsNull(image_length) or image_length > 0,0,1) ~" "
		
		ls_Modify =  "b_editword_notempty.visible = ~"1~~tif( ctx_req_tmplt_element_show_word_ico = 0 or image_length <= 0,0,1) ~" "
		ls_Modify += "b_editword_isempty.visible  = ~"1~~tif( ctx_req_tmplt_element_show_word_ico = 0 or image_length > 0,0,1) ~" "		
		
		ads_source.Modify(ls_Modify)
	CASE 32  //(Appeon)Alfee 01.21.2014 - V142 ISG-CLX
		ls_Modify = "doc_type.Initial='null'"
		ads_source.Modify(ls_Modify)		
	CASE ELSE
		//do nothing
		
END CHOOSE

Return ads_source.Describe("DataWindow.Syntax")

end function

public subroutine of_update_object (datastore ads_target, datastore ads_source, datastore ads_properties, string as_forceupdate);/********************************************************************
Function  : of_update_object
			   returns (None)
arguements: datastore ads_target
				datastore ads_source
describe  : update the syntax of dw object
Author    : Jervis 08.03.2007
********************************************************************/

String  ls_sObjects, ls_tObjects
String  ls_sObjectlist[],ls_tObjectlist[]
String  ls_ObjName
long    ll_i,ll_j,ll_sObjcount,ll_tObjcount
String  ls_Type,ls_Rtn
String  ls_Err,ls_Modify
string ls_tSyntax,ls_sSyntax,ls_newObjSyntax
long ll_sPos_s,ll_ePos_s,ll_sPos_t,ll_ePos_t
String ls_NewInvisible
String ls_temp //Add 10/22/2007 by: Andy
//$<add> 01.10.2008 by: Andy
str_objx ls_NewObjList[]
Long     ll_Cnt = 0,ll_Min,ll_x,ll_Max = 0
String   ls_maxobj
//end of add



ls_sObjects  = ads_source.Describe("DataWindow.Objects")
ll_sObjcount = inv_string.of_parsetoarray(ls_sObjects,'~t',ls_sObjectlist)
ls_sSyntax = ads_source.Describe("Datawindow.syntax")

//$<Modify> 2007-10-31 By: Andy
//$<Reason> Convert grid style to tabular
Long    ll_pos
integer li_Processing = 0
ll_pos = Pos(ls_sSyntax,"processing=1")
IF ll_pos > 0 THEN
	ls_sSyntax = Left(ls_sSyntax,ll_pos - 1) + "processing=0" + Mid(ls_sSyntax, ll_pos + 12)
	li_Processing = 1
END IF

ls_tObjects  = ads_target.Describe("DataWindow.Objects")
ll_tObjcount = inv_string.of_parsetoarray(ls_tObjects,'~t',ls_tObjectlist)
ls_tSyntax = ads_target.Describe("Datawindow.syntax")

//Reset Object Properties
ads_properties.Reset()

for ll_i = 1 to ll_tObjcount
	ls_ObjName = ls_tObjectlist[ll_i]
	//Update Object Syntax,no include column object
	ls_Type =  ads_source.Describe(ls_ObjName + ".type") 
	if ls_Type <> '!' and ls_Type <> '?' then
		//modify 10/24/2007 by: Andy
		//if ls_type <> "column" then
		if ls_type <> "column" and ls_type <> "text" then
			//$<Modify> 2007-10-24 By: Andy
			//$<Reason> Fix a defect. add: " "
			of_get_ObjPos(ls_sSyntax,ls_type,ls_ObjName + " ",ll_sPos_s,ll_ePos_s)
			of_get_ObjPos(ls_tSyntax,ls_type,ls_ObjName + " ",ll_sPos_t,ll_ePos_t)

			ls_newObjSyntax = Mid(ls_tSyntax,ll_sPos_t,ll_ePos_t - ll_sPos_t)
			ls_sSyntax = Replace(ls_sSyntax,ll_sPos_s,ll_ePos_s - ll_sPos_s, ls_newObjSyntax)
		else
			of_get_objectpro(ads_target,ads_properties,ls_ObjName)
		end if
	else		//Object Not Exists
		ls_Type = ads_target.Describe(ls_ObjName + ".type")
		//Add object,Process compute,text only
		if ls_Type = 'compute' OR ls_Type = 'text' OR ls_Type = 'groupbox' OR ls_Type = "ellipse" OR ls_Type = "bitmap" OR ls_Type = 'rectangle' OR ls_Type = 'line' then 
			//BEGIN---Modify by Scofield on 2009-12-17
			
			//$<Modify> 2007-10-24 By: Andy
			//$<Reason> Fix a defect. add: " "
			
			/*
			of_get_ObjPos(ls_tSyntax,ls_type,ls_ObjName + " ",ll_sPos_t,ll_ePos_t)
			ls_newObjSyntax = Mid(ls_tSyntax,ll_sPos_t,ll_ePos_t - ll_sPos_t)
			*/
			
			if ls_Type = "ellipse" then
//				DebugBreak()
			end if
			
			ls_NewObjSyntax = gf_GetDWOSyntax(ls_tSyntax,ls_ObjName)
			
			//END---Modify by Scofield on 2009-12-17
			
			if ls_NewObjSyntax <> "" then
				ls_Modify = ls_Modify + " create " + ls_NewObjSyntax
			end if
		end if
	end if
next

//$<add> 2007-10-23 By: Andy
FOR ll_i = 1 to ll_sObjcount
	ls_ObjName = ls_sObjectlist[ll_i]
	ls_temp = ads_source.describe(ls_ObjName +".x")
	//if ls_ObjName not exists in dw, then it's ignore.
	if ls_temp = '!' or ls_temp = '?' then continue
	//If the object is new in dw, then Invisible the object in the user style.
	ls_Type =  ads_target.Describe(ls_ObjName + ".x")//".type"
	//not exists in the user style
	if ls_Type = '!' or ls_Type = '?' then
		//If properties of visible is Expression then continue -- jervis 08.20.2009
		if ads_source.describe(ls_ObjName +".visible") <> "1" then continue 
		
		ls_NewInvisible = ls_NewInvisible + " " + ls_ObjName + ".Visible='0'"
		//$<add> 01.10.2008 By: Andy(fixed BugG010301)
		if li_Processing = 1 then
			ll_Cnt ++
			ll_x = Long(ls_temp)
			//Search min x for new objects.
			if ll_Cnt = 1 then ll_Min = ll_x
			if ll_x < ll_Min then 
				ll_Min = ll_x
			end if
			//Record x into array for new objects. 
			ls_NewObjList[ll_Cnt].objname = ls_ObjName
			ls_NewObjList[ll_Cnt].x       = ll_x
		end if
		//end of add 01.10.2008
	end if
NEXT

//Re-Create DataWindow
if ads_source.Create(ls_sSyntax,ls_Err) <> 1 then
	Clipboard(ls_Err)
end if
	
//Add Not Exists Object
ls_Rtn = ads_source.Modify(ls_Modify)

//Get DataWindow Properties
of_get_objectpro(ads_target,ads_properties,"datawindow")

//$<Modify> 2007-10-23 By: Andy
//Set Object Properties
//return of_set_ObjectPro(ads_source,ads_properties)
of_set_ObjectPro(ads_source,ads_properties)
//$<add> 2007-10-23 By: Andy
//Invisible new objects
if Len(ls_NewInvisible) > 0 then
	ads_source.Modify(ls_NewInvisible)
end if
//force update if it's necessary
if Len(as_forceupdate) > 0 then 
	ads_source.Modify(as_forceupdate)
end if

//$<add> 01.10.2008 By: Andy
//if grid style,then move the new objects to the end.(fixed BugG010301)
if li_Processing = 1 and ll_Cnt > 0 then
	//Search max x for new objects.
	ls_sObjects  = ads_source.Describe("DataWindow.Objects")
	ll_sObjcount = inv_string.of_parsetoarray(ls_sObjects,'~t',ls_sObjectlist)
	FOR ll_i = 1 to ll_sObjcount
		ll_x = Long(ads_source.describe(ls_sObjectlist[ll_i] +".x"))
		if ll_x > ll_Max then
			ll_Max    = ll_x   
			ls_maxobj = ls_sObjectlist[ll_i]
		end if
	Next
	ll_Max += Long(ads_source.describe(ls_maxobj +".Width"))
	
	//Move the new objects to the end.
	//(obj.x=max x for all + original obj.x - min x for new objects)
	ls_Modify = ""
	FOR ll_i = 1 to ll_Cnt
		ll_x = ll_Max + ls_NewObjList[ll_i].x - ll_min
		ls_Modify += " " + ls_NewObjList[ll_i].objname + ".x='" + String(ll_x) + "'"
	Next
	ads_source.Modify(ls_Modify)	
end if
//end of add 01.10.2008

If li_Processing = 1 Then//added by gavins 20120604
	of_align_object( ads_source  )	
End If


//$<add> 2007-10-31 By: Andy
//$<Reason> Convert tabular style to grid if li_Processing = 1
if li_Processing = 1 then
	ls_sSyntax = ads_source.Describe("Datawindow.syntax")
	ll_pos = Pos(ls_sSyntax,"processing=0")
	IF ll_pos > 0 THEN
		ls_sSyntax = Left(ls_sSyntax,ll_pos - 1) + "processing=1" + Mid(ls_sSyntax, ll_pos + 12)
		li_Processing = 1
	END IF
	ads_source.Create(ls_sSyntax,ls_Err)
end if

end subroutine

public subroutine of_restore_in ();
end subroutine

public function integer of_force_update_button (ref datastore ads_source, integer ai_screen_index);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_update_screenof_force_update_button()
// $<arguments>
//		reference	datastore	ads_source     		
//		value    	integer  	ai_screen_index		
// $<returns> integer
// $<description>
// $<description> force modify alarm ico/button's size.
//////////////////////////////////////////////////////////////////////
// $<add> 2009-10-10 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_modify_syntax
string ls_button_name[]
Integer i
String ls_ret

Choose Case ai_screen_index
	Case 5 //'Details->Contract Dates'
		ls_button_name[1] = 'b_effective_date'
		ls_button_name[2] = 'b_review_date'
		ls_button_name[3] = 'b_term_reason'
		ls_button_name[4] = 'b_version_number'
		ls_button_name[5] = 'b_version_date'
		ls_button_name[6] = 'b_expriation_date'
		ls_button_name[7] = 'b_last_revis_date'
		ls_button_name[8] = 'b_term_date'
		ls_button_name[9] = 'b_other_date_1'
		ls_button_name[10] = 'b_other_date_2'
		For i = 1 To UpperBound(ls_button_name[])
			/*********************************/ //added by gavins 20120525
			If ls_button_name[i] = 'b_term_reason' Then
				ads_source.Modify(  " destroy b_term_reason " )
			/*********************************/		
			Else	
				ls_modify_syntax += ' ' + &
					ls_button_name[i] + ".width = '73' " + ls_button_name[i] + ".height = '64' " + &
					ls_button_name[i] + ".y = '" + String(Long(ads_source.Describe( Mid(ls_button_name[i],3) + ".y ")) - 12) + "'"
			End If
		Next
		
	Case 9 //'Details->Custom Data Tab->Custom Data'
		ls_button_name[1] = 'b_custom_date1'
		ls_button_name[2] = 'b_custom_date2'
		ls_button_name[3] = 'b_custom_date3'
		ls_button_name[4] = 'b_custom_date4'
		ls_button_name[5] = 'b_custom_date5'
		ls_button_name[6] = 'b_custom_date6'
		ls_button_name[7] = 'b_custom_date7'
		ls_button_name[8] = 'b_custom_date8'
		ls_button_name[9] = 'b_custom_date9'
		ls_button_name[10] = 'b_custom_date10'
		ls_button_name[11] = 'b_custom_date11'
		ls_button_name[12] = 'b_custom_date12'
		ls_button_name[13] = 'b_custom_date13'
		ls_button_name[14] = 'b_custom_date14'
		ls_button_name[15] = 'b_custom_date15'
		For i = 1 To UpperBound(ls_button_name[])
			ls_modify_syntax += ' ' + &
				ls_button_name[i] + ".width = '73' " + ls_button_name[i] + ".height = '64' " + &
				ls_button_name[i] + ".y = '" + String(Long(ads_source.Describe( Mid(ls_button_name[i],3) + ".y ")) - 12) + "'"
		Next	
		
	Case 33 //'Action Items->Action Item List'
		ls_button_name[1] = 'b_due_date' 
		ls_button_name[2] = 'b_due_date_r' 
		ls_button_name[3] = 'b_due_date_g' 
		For i = 1 To UpperBound(ls_button_name[])
			ls_modify_syntax += ' ' + &
				ls_button_name[i] + ".width = '73' " + ls_button_name[i] + ".height = '64' " + &
				ls_button_name[i] + ".y = '" + String(Long(ads_source.Describe("due_date.y ")) - 12) + "'"
		Next	
		
	Case 47 //'Document Manager->Work Flow Tab->Action Item Detail'
		ls_button_name[1] = 'b_due_date' 
		ls_button_name[2] = 'b_due_date_r' 
		ls_button_name[3] = 'b_due_date_g' 	
		For i = 1 To UpperBound(ls_button_name[])
			ls_modify_syntax += ' ' + &
				ls_button_name[i] + ".width = '73' " + ls_button_name[i] + ".height = '64' " + &
				ls_button_name[i] + ".y = '" + String(Long(ads_source.Describe("due_date.y ")) - 12) + "'"
		Next
	Case 31, 55	 //added by gavins 20121217
		ls_button_name[1] = 'b_custom_date1'
		ls_button_name[2] = 'b_custom_date2'
		ls_button_name[3] = 'b_custom_date3'
		ls_button_name[4] = 'b_custom_date4'
		ls_button_name[5] = 'b_custom_date5'
		For i = 1 To UpperBound(ls_button_name[])
			If IsNumber( ads_source.Describe( ls_button_name[i] + "_r.X" ) ) Then
				ads_source.Modify(  " destroy " +  ls_button_name[i] + "_r" )
			End If
			If IsNumber( ads_source.Describe( ls_button_name[i] + "_g.X" ) ) Then
				ads_source.Modify(  " destroy " +  ls_button_name[i] + "_g"  )
			End If			
			ls_modify_syntax += ' ' + ls_button_name[i] + ".visible='" + ads_source.describe(  Mid(ls_button_name[i],3 ) + ".visible" ) + "' " +  &
				ls_button_name[i] + ".filename = '~~'gRAYflag.bmp~~'~tcase(" + Mid(ls_button_name[i],3 ) + "_flag when 2  then    ~~'redflag.bmp~~'   when 1  then ~~'greenflag.bmp~~'  else ~~'grayflag.bmp~~' )'" 
		Next
	Case 53
		ls_button_name[1] = 'b_custom_date1'
		ls_button_name[2] = 'b_custom_date2'
		ls_button_name[3] = 'b_custom_date3'
		ls_button_name[4] = 'b_custom_date4'
		ls_button_name[5] = 'b_custom_date5'
		ls_button_name[6] = 'b_custom_date6'
		ls_button_name[7] = 'b_custom_date7'
		ls_button_name[8] = 'b_custom_date8'
		ls_button_name[9] = 'b_custom_date9'
		ls_button_name[10] = 'b_custom_date10'
		For i = 1 To UpperBound(ls_button_name[])
			If IsNumber( ads_source.Describe( ls_button_name[i] + "_r.X" ) ) Then
				ads_source.Modify(  " destroy " +  ls_button_name[i] + "_r" )
			End If
			If IsNumber( ads_source.Describe( ls_button_name[i] + "_g.X" ) ) Then
				ads_source.Modify(  " destroy " +  ls_button_name[i] + "_g"  )
			End If			
			ls_modify_syntax += ' ' + ls_button_name[i] + ".visible='" + ads_source.describe(  Mid(ls_button_name[i],3 ) + ".visible" ) + "' " +  &
				ls_button_name[i] + ".filename = '~~'gRAYflag.bmp~~'~tcase(" +  Mid(ls_button_name[i],3 ) + "_flag when 2  then    ~~'redflag.bmp~~'   when 1  then ~~'greenflag.bmp~~'  else ~~'grayflag.bmp~~' )'" 
		Next	
End Choose

If Len(ls_modify_syntax) > 0 Then
	ls_ret = ads_source.Modify(ls_modify_syntax)
End If

Return 1
end function

public subroutine of_appeon2_changes (boolean ab_force_update);//////////////////////////////////////////////////////////////////// //
// $<function>n_cst_contract_sqlof_asa_6_changes()
// $<arguments> Boolean ab_force_update
// $<returns> (none)
// $<description>Contract module modification
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 08.09.2006 by Liang QingShi
//////////////////////////////////////////////////////////////////////
Integer i,li_num,li_rowcount,li_row
String ls_tab_name[],ls_screen_name[],ls_dw_name[],ls_dataobject[]
String ls_sql,ls_error_create
n_cst_datastore lds_sql
n_cst_datastore lds_source,lds_target,lds_properties
Long ll_count , ll_find
Boolean lb_update_falg
Long ll_view_id,ll_screen_id
String ls_dataobject1
DateTime ldt_modify_date
String   ls_ForceUpdates[]
String ls_ForceUpdates1001[] //only for default view
string 	ls_ForceUpdates_screen
String   ls_text
String   ls_Error
str_dwsyntax lstr_syntax[]	//jervis 05.19.2011
/*******************************///added by gainvs 20120305 required grid
String		ls_GridDataObject[], ls_ScreenStyle[], ls_NeedModify[]
Boolean	lb_GridExists
Integer	li_k, li_Cycle, li_ReturnUpgrade
String		ls_GridSQL
n_ds		lds_Original
Boolean			lb_Upgrade[], lb_Error
String				ls_FreeSyntax[], ls_GridSyntax[]
String				ls_TargetSyntax
Boolean			lb_NewUpgrade
/*******************************/
//---------Begin Added by (Appeon)Harry 02.10.2014 for V142 ISG-CLX Bug # 3872--------
String ls_column[]
String ls_ForceUpdates5
Long k
//---------End Added ------------------------------------------------------

lb_update_falg = True
lds_source = Create n_cst_datastore
lds_sql = Create n_cst_datastore
lds_target = Create n_cst_datastore
lds_properties = Create n_cst_datastore

//initilize log service  //added by gavins 20120601
IF Not IsValid(gnv_logservice) THEN gnv_logservice = Create n_logservice

//Added By Ken.Guo 2010-03-09.
String ls_screen_version
Select screen_version into :ls_screen_version from icred_settings;
If Not ab_force_update and Not isnull(ls_screen_version) and ls_screen_version = is_screen_version Then 
	If isvalid(lds_sql) Then Destroy lds_sql
	If isvalid(lds_source) Then Destroy lds_source
	If isvalid(lds_target) Then Destroy lds_target
	If isvalid(lds_properties) Then Destroy lds_properties	
	Return
End If

//Add by jervis -- 05.17.2011
of_per_screen_process()

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.18.2007 By: Jack
//$<reason> Fix a defect
//Delete from  ctx_screen where screen_id = 32 and dataobject <> 'd_dm_browse_filter';
/*
remove to of_per_screen_process function
UPDATE ctx_screen Set screen_name = 'Other Contacts' + substring(screen_name,9,100) Where screen_id In (14,15,16,17) And substring(screen_name,1,8) = 'Contacts';

lds_source.DataObject = 'd_dm_browse_filter'
lds_source.SetTransObject(sqlca)
ls_sql = lds_source.Describe("datawindow.syntax")
UPDATE ctx_screen SET
	dw_sql = :ls_sql,
	modify_date = getdate(),
	screen_name = 'Document Manager->Document Tab->Search Criteria',
	dw_name = 'dw_filter',
	dataobject = 'd_dm_browse_filter'
	Where screen_id = 32 And DataObject = 'd_cntx_images';
COMMIT;
*/
//---------------------------- APPEON END ----------------------------

lds_properties.DataObject = "d_update_user_datawindow_objlist"
lds_sql.DataObject = 'd_contract_dw_sql_update'
lds_sql.SetTransObject(sqlca)
//$<modify> 03.12.2008 by Andy
if lds_sql.Retrieve() = -1 then
	ls_Error= "n_cst_update_screen.of_appeon2_changes() Information: lds_sql.Retrieve() failed, call support." 
	IF IsValid(gnv_logservice)THEN 
		gnv_logservice.of_setloglevel(2) //warning level
		gnv_logservice.of_log_warning(ls_Error)
		gb_upgrade_failed = TRUE			
	END IF
end if
//end of modify 03.12.2008

ls_tab_name[1] = 'tabpage_search'
ls_tab_name[2] = 'tabpage_search'
ls_tab_name[3] = 'tabpage_details'
ls_tab_name[4] = 'tabpage_details'
ls_tab_name[5] = 'tabpage_details'
ls_tab_name[6] = 'tabpage_details'
ls_tab_name[7] = 'tabpage_details'
ls_tab_name[8] = 'tabpage_details'
ls_tab_name[9] = 'tabpage_details'
ls_tab_name[10] = 'tabpage_details'
ls_tab_name[11] = 'tabpage_requirements'
ls_tab_name[12] = 'tabpage_requirements'
ls_tab_name[13] = 'tabpage_requirements'
ls_tab_name[14] = 'tabpage_contacts'
ls_tab_name[15] = 'tabpage_contacts'
ls_tab_name[16] = 'tabpage_contacts'
ls_tab_name[17] = 'tabpage_contacts'
ls_tab_name[18] = 'tabpage_locations'
ls_tab_name[19] = 'tabpage_locations'
ls_tab_name[20] = 'tabpage_locations'
ls_tab_name[21] = 'tabpage_locations'
ls_tab_name[22] = 'tabpage_orgabizations'
ls_tab_name[23] = 'tabpage_orgabizations'
ls_tab_name[24] = 'tabpage_orgabizations'
ls_tab_name[25] = 'tabpage_orgabizations'
ls_tab_name[26] = 'tabpage_fee_schedules'
ls_tab_name[27] = 'tabpage_fee_schedules'
ls_tab_name[28] = 'tabpage_fee_schedules'
ls_tab_name[29] = 'tabpage_fee_schedules'
ls_tab_name[30] = 'tabpage_fee_schedules'
ls_tab_name[31] = 'tabpage_fee_sched2'
ls_tab_name[32] = 'tabpage_images'
ls_tab_name[33] = 'tabpage_action_items'
ls_tab_name[34] = 'tabpage_qrg'
ls_tab_name[35] = 'tabpage_qrg'
ls_tab_name[36] = 'tabpage_qrg'
ls_tab_name[37] = 'tabpage_qrg'
ls_tab_name[38] = 'tabpage_qrg'
ls_tab_name[39] = 'tabpage_qrg'
ls_tab_name[40] = 'tabpage_qrg'
ls_tab_name[41] = 'tabpage_qrg'
ls_tab_name[42] = 'tabpage_action_items'
ls_tab_name[43] = 'tabpage_details'
ls_tab_name[44] = 'tabpage_images'
ls_tab_name[45] = 'tabpage_images'
ls_tab_name[46] = 'tabpage_images'
ls_tab_name[47] = 'tabpage_images'
ls_tab_name[48] = 'tabpage_images'
ls_tab_name[49] = 'tabpage_images'
ls_tab_name[50] = 'tabpage_details' //Added by Ken.Guo on 2009-02-10
ls_tab_name[51] = 'tabpage_images'	//Added by Scofield on 2010-04-20
ls_tab_name[52] = 'tabpage_images'	//Added by Scofield on 2010-04-20
//Add custom multi data tabpage - jervis 05.31.2011
ls_tab_name[53] = 'tabpage_multi'  
ls_tab_name[54] = 'tabpage_multi'  
ls_tab_name[55] = 'tabpage_multi'  

ls_tab_name[56] = 'tabpage_images' //add by gavins20120131
ls_tab_name[57] = 'tabpage_images'
//---------Begin Modified by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
//ls_tab_name[58] = 'tabpage_details'//Added by Appeon long.zhang 04.14.2014 (v14.2 Provider-Contract direct linking)
ls_tab_name[58] = 'tabpage_email'							//Added By Mark Lee 02/04/2013
//Added By Jay Chen 04-03-2014
ls_tab_name[59] = 'tabpage_images'
ls_tab_name[60] = 'tabpage_images'
ls_tab_name[61] = 'tabpage_details'//Added by Appeon long.zhang 04.14.2014 (v14.2 Provider-Contract direct linking)
//---------End Modfiied ------------------------------------------------------

ls_screen_name[1] = 'Search->Search Criteria'
ls_screen_name[2] = 'Search->Contract Browse'
ls_screen_name[3] = 'Details->Contract Detail'
ls_screen_name[4] = 'Details->Products'
ls_screen_name[5] = 'Details->Contract Dates'
ls_screen_name[6] = 'Details->Contracted Company Contact'
ls_screen_name[7] = 'Details->Our Company Contact'
ls_screen_name[8] = 'Details->Notes Tab->Notes'
ls_screen_name[9] = 'Details->Custom Data Tab->Custom Data'
//ls_screen_name[10] = 'Details->Audit Trail Tab->Audit Trail'
ls_screen_name[10] = 'Details->Custom Data 2->Custom Data 2'
ls_screen_name[11] = 'Requirements->Profile Selection'
ls_screen_name[12] = 'Requirements->Profile Detail'
ls_screen_name[13] = 'Requirements->Profile Detail'
ls_screen_name[14] = 'Other Contacts->Contacts List'
ls_screen_name[15] = 'Other Contacts->Contact Details'
ls_screen_name[16] = 'Other Contacts->Contact Information'
ls_screen_name[17] = 'Other Contacts->Contact Notes'
ls_screen_name[18] = 'Locations->Parent Organization'
ls_screen_name[19] = 'Locations->Group/Location'
ls_screen_name[20] = 'Locations->Associated Physicians'
ls_screen_name[21] = 'Locations->Specialties'
ls_screen_name[22] = 'Organizations->Organization List'
ls_screen_name[23] = 'Organizations->Address'
ls_screen_name[24] = 'Organizations->Notes'
ls_screen_name[25] = 'Organizations->Organization Contacts'
ls_screen_name[26] = 'Fee Schedules->Browse Tab->Fee Schedules'
ls_screen_name[27] = 'Fee Schedules->Browse Tab->Fee Schedule Locations'
ls_screen_name[28] = 'Fee Schedules->Browse Tab->Fees'
ls_screen_name[29] = 'Fee Schedules->Browse Tab->Providers'
ls_screen_name[30] = 'Fee Schedules->Notes Tab->User Defined data'
ls_screen_name[31] = 'Fee Schedule (NM)->Fee Schedule (Non Healthcare)'
ls_screen_name[32] = 'Document Manager->Document Tab->Search Criteria'
ls_screen_name[33] = 'Action Items->Action Item List'
ls_screen_name[34] = 'QRG->Select Data Tab->Report Profiles'
ls_screen_name[35] = 'QRG->Select Data Tab->Basic Information to Include'
ls_screen_name[36] = 'QRG->Select Data Tab->Contract Contact Information to Include'
ls_screen_name[37] = 'QRG->Select Data Tab->Precertifications Requirements'
ls_screen_name[38] = 'QRG->Select Data Tab->Authorizations Requirements'
ls_screen_name[39] = 'QRG->Select Data Tab->Fee Schedule Data to Include'
ls_screen_name[40] = 'QRG->Select Data Tab->Organization Types to Include'
ls_screen_name[41] = 'QRG->Select Data Tab->Requirements to Include'
ls_screen_name[42] = 'Action Items->Action Item Browse'
ls_screen_name[43] = 'Details->Linked Contracts Tab->Linked Contracts'
ls_screen_name[44] = 'Document Manager->Document Tab->Document Browse'
ls_screen_name[45] = 'Document Manager->Work Flow Tab->Search Criteria'
ls_screen_name[46] = 'Document Manager->Work Flow Tab->Action Item Browse'
ls_screen_name[47] = 'Document Manager->Work Flow Tab->Action Item Detail'
ls_screen_name[48] = 'Document Manager->Audit Trail Tab->Search Criteria'
ls_screen_name[49] = 'Document Manager->Audit Trail Tab->Document Browse'
ls_screen_name[50] = 'Details->Group Access Tab->Group Access' //Added by Ken.Guo on 2009-02-10
ls_screen_name[51] = 'Document Manager->Document Tab->Added Document Properties'			//Added by Scofield on 2010-04-20
ls_screen_name[52] = 'Document Manager->Document Tab->Created Document Properties'		//Added by Scofield on 2010-04-20
ls_screen_name[53] = 'Custom Multi->Header->Header'
ls_screen_name[54] = 'Custom Multi->Detail->Browse'
ls_screen_name[55] = 'Custom Multi->Detail->Detail'

ls_screen_name[56] ='Document Manager->Document Tab->Document Browse'//add by gavins 20120131
ls_screen_name[57] ='Document Manager->Document Tab->Document History'
//---------Begin Modified by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
//ls_screen_name[58] = 'Details->Linked Providers Tab->Linked Providers'
ls_screen_name[58] ='Email Manager->'																			//Added By Mark Lee 02/04/2013
//Added By Jay Chen 04-03-2014
ls_screen_name[59] ='Document Manager->Document Browse Window->Search Criteria'	
ls_screen_name[60] ='Document Manager->Document Browse Window->Document Browse'	
ls_screen_name[61] = 'Details->Linked Providers Tab->Linked Providers'
//---------End Modfiied ------------------------------------------------------


ls_dw_name[1] = 'dw_search'
ls_dw_name[2] = 'dw_search_det1'
ls_dw_name[3] = 'dw_1'
ls_dw_name[4] = 'dw_products'
ls_dw_name[5] = 'dw_contract_dates'
ls_dw_name[6] = 'dw_ccc'
ls_dw_name[7] = 'dw_occ'
ls_dw_name[8] = 'dw_1'
ls_dw_name[9] = 'dw_1'
ls_dw_name[10] = 'dw_1'
ls_dw_name[11] = 'dw_2'
ls_dw_name[12] = 'dw_req_det'
ls_dw_name[13] = 'dw_req_det'
ls_dw_name[14] = 'dw_search'
ls_dw_name[15] = 'dw_detail'
ls_dw_name[16] = 'dw_phone'
ls_dw_name[17] = 'dw_notes'
ls_dw_name[18] = 'dw_main'
ls_dw_name[19] = 'dw_detail'
ls_dw_name[20] = 'dw_doctors'
ls_dw_name[21] = 'dw_spec'
ls_dw_name[22] = 'dw_search'
ls_dw_name[23] = 'dw_main'
ls_dw_name[24] = 'dw_notes'
ls_dw_name[25] = 'dw_contacts'
ls_dw_name[26] = 'dw_main'
ls_dw_name[27] = 'dw_locations'
ls_dw_name[28] = 'dw_fee_schedule'
ls_dw_name[29] = 'dw_codes'
ls_dw_name[30] = 'dw_1'
ls_dw_name[31] = 'dw_fee_nm'
ls_dw_name[32] = 'dw_filter'
ls_dw_name[33] = 'dw_1'
ls_dw_name[34] = 'dw_profile'
ls_dw_name[35] = 'dw_basic_info'
ls_dw_name[36] = 'dw_contact_info'
ls_dw_name[37] = 'dw_precert'
ls_dw_name[38] = 'dw_auth'
ls_dw_name[39] = 'dw_1'
ls_dw_name[40] = 'dw_2'
ls_dw_name[41] = 'dw_requirements'
ls_dw_name[42] = 'dw_1'
ls_dw_name[43] = 'dw_1'
ls_dw_name[44] = 'dw_browse'
ls_dw_name[45] = 'dw_filter'
ls_dw_name[46] = 'dw_browse'
ls_dw_name[47] = 'dw_detail'
ls_dw_name[48] = 'dw_filter'
ls_dw_name[49] = 'dw_browse'
ls_dw_name[50] = 'dw_1' //Added by Ken.Guo on 2009-02-10
ls_dw_name[51] = 'dw_1'	//Added by Scofield on 2010-04-20
ls_dw_name[52] = 'dw_1'	//Added by Scofield on 2010-04-20
ls_dw_name[53] = 'dw_header'
ls_dw_name[54] = 'dw_browse'
ls_dw_name[55] = 'dw_detail'
ls_dw_name[56] = 'dw_browse' //add by gavins 20120131
ls_dw_name[57] = 'dw_detail'
//---------Begin Modified by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
//ls_dw_name[58] = 'dw_1'//Added by Appeon long.zhang 04.14.2014 (v14.2 Provider-Contract direct linking)
ls_dw_name[58] = ''										//Added By Mark Lee 02/04/2013
//Added By Jay Chen 04-03-2014
ls_dw_name[59] = 'dw_filter'
ls_dw_name[60] = 'dw_browse'
ls_dw_name[61] = 'dw_1'//Added by Appeon long.zhang 04.14.2014 (v14.2 Provider-Contract direct linking)
//---------End Modfiied ------------------------------------------------------

ls_dataobject[1] = 'd_contract_search'
ls_dataobject[2] = 'd_sp_contract_search'
ls_dataobject[3] = 'd_contract_det_master'
ls_dataobject[4] = ''
ls_dataobject[5] = 'd_contract_det_master_2'
ls_dataobject[6] = ''
ls_dataobject[7] = ''
ls_dataobject[8] = 'd_contract_det_notes'
ls_dataobject[9] = 'd_contract_det_custom'
//ls_dataobject[10] = 'd_view_audit2_ctx'
ls_dataobject[10] = 'd_contract_det_custom_2'
ls_dataobject[11] = ''
ls_dataobject[12] = 'd_contract_profile_req2'
ls_dataobject[13] = 'd_contract_profile_req_existing'
ls_dataobject[14] = 'd_contract_det_contact_contact'
ls_dataobject[15] = 'd_contract_det_contact_contact_det'
ls_dataobject[16] = ''
ls_dataobject[17] = 'd_contract_det_contact_contact_notes'
ls_dataobject[18] = ''
ls_dataobject[19] = 'd_contract_group_linked_locations'
ls_dataobject[20] = ''
ls_dataobject[21] = ''
ls_dataobject[22] = ''
ls_dataobject[23] = 'd_org_tabpg'
ls_dataobject[24] = 'd_org_notes'
ls_dataobject[25] = ''
ls_dataobject[26] = ''
ls_dataobject[27] = ''
ls_dataobject[28] = ''
ls_dataobject[29] = ''
ls_dataobject[30] = 'd_ctx_schedule_fee_notes'
ls_dataobject[31] = 'd_contract_fee_sched_nm'
ls_dataobject[32] = 'd_dm_browse_filter'
ls_dataobject[33] = 'd_cntx_action_items'
ls_dataobject[34] = 'd_report_hdr'
ls_dataobject[35] = ''
ls_dataobject[36] = ''
ls_dataobject[37] = ''
ls_dataobject[38] = ''
ls_dataobject[39] = ''
ls_dataobject[40] = ''
ls_dataobject[41] = 'd_contract_profile_req_questions'
ls_dataobject[42] = ''
ls_dataobject[43] = 'd_sp_contract_search'
ls_dataobject[44] = 'd_dm_doc_tree'
ls_dataobject[45] = 'd_dm_ai_filter'
ls_dataobject[46] = ''
ls_dataobject[47] = 'd_dm_doc_ai_detail'
ls_dataobject[48] = 'd_dm_audit_filter'
ls_dataobject[49] = ''
ls_dataobject[50] = ''	//Added by Ken.Guo on 2009-02-10
ls_dataobject[51] = 'd_dm_new_buy_document'			//Added by Scofield on 2010-04-20
ls_dataobject[52] = 'd_dm_new_sell_document'			//Added by Scofield on 2010-04-20
ls_dataobject[53] = 'd_contract_multi_header'	
ls_dataobject[54] = 'd_contract_multi_browse'	
ls_dataobject[55] = 'd_contract_multi_detail'	
ls_dataobject[56] = ''	//add by gavin 20120131
ls_dataobject[57] = ''	
//---------Begin Modified by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
//ls_dataobject[58] = 'd_ctx_provider_direct_link'//Added by Appeon long.zhang 04.14.2014 (v14.2 Provider-Contract direct linking)
ls_dataobject[58] = ''												//Added By Mark Lee 02/04/2013
//Added By Jay Chen 04-03-2014
ls_dataobject[59] = 'd_doc_br_search'	
ls_dataobject[60] = ''
ls_dataobject[61] = 'd_ctx_provider_direct_link'//Added by Appeon long.zhang 04.14.2014 (v14.2 Provider-Contract direct linking)
//---------End Modfiied ------------------------------------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05.28.2008 by Andy
ls_ForceUpdates[UpperBound(ls_dataobject[])] = ""
ls_ForceUpdates[1]  = "category.dddw.name='d_dddw_user_access_category' app_facility.tabsequence=32766 app_facility.x='3803' app_facility.y='68' app_facility.height='60' app_facility.width='594' app_facility.visible='0' app_facility_t.x='3803' app_facility_t.y='12' app_facility_t.height='52' app_facility_t.width='489' app_facility_t.visible='0' facility_name_t.visible='1' facility_name.visible='1' facility_name.dddw.name='dddw_contact_company_search' facility_name.dddw.displaycolumn='facility_name' facility_name.dddw.datacolumn='facility_name' facility_name.dddw.percentwidth=200 b_clear.visible='1' b_more.visible='1' " + &
" ctx_id.dddw.name='d_dddw_ctx_ids' ctx_id.dddw.displaycolumn='ctx_id' ctx_id.dddw.datacolumn='ctx_id' ctx_id.dddw.percentwidth=150  ctx_id.dddw.allowedit=yes ctx_id.dddw.useasborder=yes  ctx_id.dddw.nilisnull=yes ctx_id.dddw.hscrollbar=yes ctx_id.dddw.vscrollbar=yes ctx_id.dddw.autoretrieve=no" //added by gavins 20130426 ctx_id.dddw.nilisnull=yes "
//ls_ForceUpdates[2]  = "p_2.visible=~"1~~tif( style ='-' and  master_cnt  >0,1,0) ~" p_1.visible=~"1~~tif( style ='+' and  master_cnt  >0,1,0) ~" "
//ls_ForceUpdates[2]  = 'p_2.visible="0" p_1.visible="0"  ' //Commented by (Appeon)Harry 05.06.2014 - V142 ISG-CLX
ls_ForceUpdates[6]  = "contact_phone.format='[general]' contact_phone.edit.limit=0 contact_phone.edit.case=any contact_phone.edit.focusrectangle=no contact_phone.edit.autoselect=no " // contact_phone.edit.imemode=0 " //Commented By Ken.Guo 05/29/2013. do not support imemode for Web //(Appeon)Harry 05.06.2014 - V142 ISG-CLX
ls_ForceUpdates[7]  = "contact_type.visible = 0 contact_type_t.visible = 0 association.Visible = 1 association_t.Visible = 1 contact_phone.format='[general]' contact_phone.edit.limit=0 contact_phone.edit.case=any contact_phone.edit.focusrectangle=no contact_phone.edit.autoselect=no "//contact_phone.edit.imemode=0 " //(Appeon)Harry 05.06.2014 - V142 ISG-CLX
ls_ForceUpdates[8]  = "notes.edit.autohscroll=no " 			//Alfee 06.17.2008
//---------Begin Modified by (Appeon)Harry 01.13.2014 for Bug# 3824--------
//ls_ForceUpdates[11] = "rqmnt_name.DDDW.UseAsBorder='no' destroy b_add "	//Added by Scofield on 2009-06-23
ls_ForceUpdates[11] = "rqmnt_name.dddw.datacolumn='rqmnt_name' rqmnt_name.DDDW.UseAsBorder='no' destroy b_add "	//Added by Scofield on 2009-06-23
//---------End Modfiied ------------------------------------------------------
ls_ForceUpdates[12] = "category_name_t.visible = '0' gb_1.background.mode='1' gb_1.background.color='553648127' p_1.visible=~"1~~tif( value_type =  5,1,0)~" "
ls_ForceUpdates[13] = "gb_1.background.mode='1' gb_1.background.color='553648127' t_1.visible='0' DataWindow.Detail.Height='118' DataWindow.Detail.Height.AutoSize='No' clause.visible = '0' b_1.visible = '0' category_name.visible='1' t_2.visible='0' p_1.visible=~"1~~tif( value_type =  5,1,0)~" "
ls_ForceUpdates[15] = "app_facility_street_1.visible='1' app_facility_street_2.visible='1' app_facility_street_3.visible='1' app_facility_city.visible='1' app_facility_state.visible='1' app_facility_zip.visible='1' ctx_contacts_street_1.visible='0' ctx_contacts_street_2.visible='0' ctx_contacts_street_3.visible='0' ctx_contacts_city.visible='0' ctx_contacts_state.visible='0' ctx_contacts_zip.visible='0' ctx_contacts_state_t.visible='0' ctx_contacts_state_t.x='1065'  ctx_contacts_state_t.y='1148' ctx_contacts_zip_t.visible='0' ctx_contacts_zip_t.x='1669' ctx_contacts_zip_t.y='1148' app_facility_state_t.visible='1'  app_facility_zip_t.visible='1' "
ls_ForceUpdates[16] = "phone.format='[general]' phone.edit.limit=0 phone.edit.case=any phone.edit.focusrectangle=no phone.edit.autoselect=no " //phone.edit.imemode=0 " //(Appeon)Harry 05.06.2014 - V142 ISG-CLX
ls_ForceUpdates[25] = "phone.format='[general]' phone.edit.limit=0 phone.edit.case=any phone.edit.focusrectangle=no phone.edit.autoselect=no " //phone.edit.imemode=0 " //(Appeon)Harry 05.06.2014 - V142 ISG-CLX
ls_ForceUpdates[27] = "location.tag='Contract Local Code' location.dddw.name='d_dddw_location' location.dddw.displaycolumn='local1' location.dddw.datacolumn='local' "
//---------Begin Modified by (Appeon)Harry 02.20.2014 for V142 ISG-CLX--------
//ls_ForceUpdates[32] = "b_close.Visible = 1"
ls_ForceUpdates[32] = "b_close.Visible = 1 doc_type.dddw.name='d_dddw_code_lookup' doc_type.dddw.displaycolumn='code' doc_type.dddw.datacolumn='code' doc_type.dddw.percentwidth=200 doc_type.dddw.vscrollbar=yes doc_type.dddw.AllowEdit=yes doc_type.dddw.NilIsNull=yes doc_type.dddw.useasborder=yes doc_type.Initial='' doc_type.Tag='Contract Document Type' "
//---------End Modfiied ------------------------------------------------------
//---------Begin Modified by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
//ls_ForceUpdates[33] = "compute_1.Expression=~"wordcap(if( isnull(document_name), if(len(alm_action_title) >0, alm_action_title, action_description) , left(document_name,len( document_name ) - 4)  + ' - ' +  if(len(alm_action_title) >0, alm_action_title, action_description) ))~" action_type.dddw.name='d_dddw_code_lookup' action_type.dddw.displaycolumn='custom_1' action_type.dddw.datacolumn='lookup_code' action_type.dddw.percentwidth=275 "
//Added By Mark Lee 05/28/2013 return the code.
ls_ForceUpdates[33] = "compute_1.Expression=~"wordcap(if( isnull(document_name), if(len(alm_action_title) >0, alm_action_title, action_description) , left(document_name,len( document_name ) - 4)  + ' - ' +  if(len(alm_action_title) >0, alm_action_title, action_description) ))~" action_type.dddw.name='d_dddw_code_lookup' action_type.dddw.displaycolumn='custom_1' action_type.dddw.datacolumn='lookup_code' action_type.dddw.percentwidth=275 " + &
								" action_type.protect='0~~tif((not isnull(wf_id)) or  active_status < 0 ,1,0)' " + &
								" action_user.protect='0~~tif(active_status < 0 ,1,0)' " + &
								" action_date.protect='0~~tif(active_status < 0 ,1,0)' " + &
								" due_date.protect='0~~tif(active_status < 0 ,1,0)' " + &
								" notes.protect='0~~tif(active_status < 0 ,1,0)' " + &
								" action_status.protect='0~~tif( wf_complete_flag = ~~'Y~~' or active_status < 0,1,0)' " + &
								" wf_assigned_by.protect='0~~tif(active_status < 0 ,1,0)' " + &
								" inserted_at_date_time.protect='0~~tif(active_status < 0 ,1,0)' " 
//---------End Modfiied ------------------------------------------------------
//ls_ForceUpdates[43] = "p_2.visible=~"1~~tif( style ='-' and  master_cnt  >0,1,0) ~" p_1.visible=~"1~~tif( style ='+' and  master_cnt  >0,1,0) ~" " //Commented by (Appeon)Harry 05.06.2014 - V142 ISG-CLX
ls_ForceUpdates[45] = "DataWindow.Detail.Height='248' b_close.Visible = 1"						//Added by Scofield on 2010-03-30
ls_ForceUpdates[46] = "wf_assigned_by.visible='1' wf_assigned_by_t.visible='1' " //Add by Evan on 03.31.2008
ls_ForceUpdates[47] = "b_print.visible=~"1~~tif(active_status < 0 or readonly_flag = 1,0,if(wf_id > 0 and print_flag < 1 and f_get_gb_workflow(),0,if((wf_id <= 0 or Not f_get_gb_workflow()) and (isnull(code_lookup_custom_6) or trim(code_lookup_custom_6) = ~~~"~~~" ),0,1)))~" b_notes.visible=~"1~~tif(active_status < 0,0,1)~" " //Delete " or  readonly_flag = 1 or wf_complete_flag = 'Y'" - jervis 02.21.2011
ls_ForceUpdates[48] = "b_close.Visible = '1' b_me.Visible = '1'"
ls_ForceUpdates[51] = "DataWindow.Table.UpdateWhere='0' " //(Appeon)Harry 09.14.2015 - Bug id 4711
ls_ForceUpdates[52] = "doc_type.tag='Contract Document Type' doc_type.dddw.name='d_dddw_code_lookup_doc_type' doc_type.dddw.displaycolumn='code' doc_type.dddw.datacolumn='code' doc_type.dddw.percentwidth=300 doc_type.dddw.lines=20 doc_type.dddw.vscrollbar=yes DataWindow.Table.UpdateWhere='0' " //Added By Ken.Guo 2011-04-01.  //(Appeon)Harry 08.01.2014 add  DataWindow.Table.UpdateWhere='0' 

//---------Begin Added by (Appeon)Stephen 11.17.2016 for Intellicred/Contract error message Case#67741 Bug_id#5415--------
ls_ForceUpdates[57] = "column=(type=char(50) updatewhereclause=yes name=esign_license_user_id dbname='name_17' ) " +&
 							  'column(band=detail id=42 alignment="0" tabsequence=0 border="0" color="0" x="4946" y="8" height="52" width="1339" html.valueishtml="0"  name=esign_license_user_id visible="1" edit.limit=0 edit.case=any edit.focusrectangle=no edit.autoselect=no  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="16777215" background.transparency="0" background.gradient.color="8421504" background.gradient.transparency="0" background.gradient.angle="0" background.brushmode="0" background.gradient.repetition.mode="0" background.gradient.repetition.count="0" background.gradient.repetition.length="100" background.gradient.focus="0" background.gradient.scale="100" background.gradient.spread="100" tooltip.backcolor="134217752" tooltip.delay.initial="0" tooltip.delay.visible="32000" tooltip.enabled="0" tooltip.hasclosebutton="0" tooltip.icon="0" tooltip.isbubble="0" tooltip.maxwidth="0" tooltip.textcolor="134217751" tooltip.transparency="0" transparency="0" )' +&
							  'text(band=header alignment="0" text="Esign License User Id" border="0" color="0" x="4942" y="4" height="52" width="1344" html.valueishtml="0"  name=esign_license_user_id_t visible="1"  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="16777215" background.transparency="0" background.gradient.color="0" background.gradient.transparency="0" background.gradient.angle="0" background.brushmode="0" background.gradient.repetition.mode="0" background.gradient.repetition.count="0" background.gradient.repetition.length="0" background.gradient.focus="0" background.gradient.scale="0" background.gradient.spread="0" tooltip.backcolor="0" tooltip.delay.initial="0" tooltip.delay.visible="0" tooltip.enabled="0" tooltip.hasclosebutton="0" tooltip.icon="0" tooltip.isbubble="0" tooltip.maxwidth="0" tooltip.textcolor="0" tooltip.transparency="0" transparency="0" )'
//---------------------------- APPEON END ----------------------------

//---------------------------- APPEON END ----------------------------

//Added By Ken.Guo 12/15/2011. only for default view 1001
ls_ForceUpdates1001[UpperBound(ls_dataobject[])] = ""
ls_ForceUpdates1001[2] = 'object_related.visible = "1" '
/*******************************************///added by gavins 20120305 grid
ls_GridDataObject[ UpperBound( ls_dataobject[] )]=""
//
ls_GridDataObject[2]= 'd_sp_contract_search_grid'
ls_GridDataObject[4] = 'd_ctx_products'
ls_GridDataObject[6] = 'd_contract_det_contact_external'
ls_GridDataObject[7] = 'd_contract_det_contact_external'
ls_GridDataObject[11] = 'd_profile_header'
//
ls_GridDataObject[14] = 'd_contract_det_contact_contact_gd'
ls_GridDataObject[16] = 'd_contract_det_contact_contact_phone'
ls_GridDataObject[18] = 'd_contract_multi_group_browse'
ls_GridDataObject[20] = 'd_contract_group_practitioners_existing'
ls_GridDataObject[21] = 'd_cntx_location_spec'
ls_GridDataObject[22] = 'd_org_search2'
ls_GridDataObject[25] = 'd_org_contacts'
ls_GridDataObject[26] = 'd_ctx_free_sched_hdr'
ls_GridDataObject[27] = 'd_ctx_schedule_fee_locations'
ls_GridDataObject[28] = 'd_ctx_schedule_fee_detail'
ls_GridDataObject[29] = 'd_ctx_schedule_fee_pracs'
ls_GridDataObject[35] = 'd_qrg_sys_fields'
ls_GridDataObject[36] = 'd_qrg_sys_fields'
ls_GridDataObject[37] = 'd_profile_codes'
ls_GridDataObject[38] = 'd_profile_codes'
ls_GridDataObject[39] = 'd_qrg_sys_fields'
ls_GridDataObject[40] = 'd_profile_codes'
ls_GridDataObject[42] = 'd_cntx_action_items_browse'
//
ls_GridDataObject[43]= 'd_sp_contract_search_grid'
ls_GridDataObject[46] = 'd_dm_doc_ai_browse'
ls_GridDataObject[49] = 'd_dm_doc_audit_browse'
ls_GridDataObject[50] = 'd_contract_det_group_access'	
//
ls_GridDataObject[54]= 'd_contract_multi_browse_gd'
ls_GridDataObject[56] = 'd_dm_doc_tree'	
ls_GridDataObject[57] = 'd_dm_doc_tree_detail'	
//---------Begin Modified by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
//ls_GridDataObject[58] = 'd_ctx_provider_direct_link'	//Added by Appeon long.zhang 04.14.2014 (v14.2 Provider-Contract direct linking)
//Added By Jay Chen 04-03-2014
ls_GridDataObject[60] = 'd_doc_br_browse'
ls_GridDataObject[61] = 'd_ctx_provider_direct_link'	//Added by Appeon long.zhang 04.14.2014 (v14.2 Provider-Contract direct linking)
//---------End Modfiied ------------------------------------------------------


ls_ScreenStyle[ UpperBound( ls_dataobject[] )]=""
ls_ScreenStyle[2] = 'F'
ls_ScreenStyle[4] = 'G'
ls_ScreenStyle[6] = 'G'
ls_ScreenStyle[7] = 'G'
ls_ScreenStyle[11] = 'G'
ls_ScreenStyle[14] = 'F'
ls_ScreenStyle[16] = 'G'
ls_ScreenStyle[18] = 'G'
ls_ScreenStyle[20] = 'G'
ls_ScreenStyle[21] = 'G'
ls_ScreenStyle[22] = 'G'
ls_ScreenStyle[25] = 'G'
ls_ScreenStyle[26] = 'G'
ls_ScreenStyle[27] = 'G'
ls_ScreenStyle[28] = 'G'
ls_ScreenStyle[29] = 'G'
ls_ScreenStyle[35] = 'G'
ls_ScreenStyle[36] = 'G'
ls_ScreenStyle[37] = 'G'
ls_ScreenStyle[38] = 'G'
ls_ScreenStyle[39] = 'G'
ls_ScreenStyle[40] = 'G'
ls_ScreenStyle[42] = 'G'
ls_ScreenStyle[43] = 'F'
ls_ScreenStyle[46] = 'G'
ls_ScreenStyle[49] = 'G'
ls_ScreenStyle[50] = 'G'
ls_ScreenStyle[54] = 'F'
ls_ScreenStyle[56] = 'G'
ls_ScreenStyle[57] = 'G'
//---------Begin Modified by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
//ls_ScreenStyle[58] = 'G'//Added by Appeon long.zhang 04.14.2014 (v14.2 Provider-Contract direct linking)
//Added By Jay Chen 04-03-2014
ls_ScreenStyle[59] = 'F'
ls_ScreenStyle[60] = 'G'
ls_ScreenStyle[61] = 'G'//Added by Appeon long.zhang 04.14.2014 (v14.2 Provider-Contract direct linking)
//---------End Modfiied ------------------------------------------------------

ls_NeedModify[ UpperBound( ls_dataobject[] )]=""
ls_NeedModify[2] = 'Y'
ls_NeedModify[14] = 'Y'
ls_NeedModify[43] = 'Y'
ls_NeedModify[54] = 'Y'

/*******************************************///added by gavins 20120314 backup screen
//---------Begin Modified by (Appeon)Alfee 06.18.2013 for V141 ISG-CLX--------
//n_cst_update_data  lnv_data
//lnv_data = Create n_cst_update_data
n_cst_update_data_clx  lnv_data
lnv_data = Create n_cst_update_data_clx
//---------End Modfiied ----------------------------------------------------------------

lnv_data.of_backup_allscreen( )
If IsValid( lnv_data ) Then Destroy( lnv_data )

/*******************************************///added by gavins 20120521 optimize upgrade
li_ReturnUpgrade = of_get_upgrade_dw( ls_dataobject, ls_GridDataObject, ab_force_update, lb_Upgrade[], lds_Original , ls_FreeSyntax[], ls_Gridsyntax[] )

/*******************************************/
li_num = UpperBound(ls_tab_name)
ll_count = lds_sql.RowCount()
IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
IF IsValid(w_infodisp) THEN w_infodisp.Title = 'Update screen of view'
IF IsValid(w_infodisp) THEN w_infodisp.Center = True
IF IsValid(w_infodisp) THEN w_infodisp.st_complete.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_3.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_information.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'Update screen of view, Please stand by!'
IF IsValid(w_infodisp) THEN w_infodisp.wf_set_min_max(1,li_num)
FOR i = 1 To li_num
	if i = 48 or i = 49 or i = 44 then continue //modified by gavins 20120319 grid   add 44
	
	Yield()
	IF IsValid(w_infodisp) THEN
		w_infodisp.wf_step_pbar(1)
		w_infodisp.st_1.Text = 'Modification ' + String(i) + ' of ' + String(li_num)+', Please stand by!'
	END IF
	
	/*******************************///added by gavins 20120305 grid
	lb_GridExists = False
	if Not( IsNull( ls_GridDataObject[i]  ) Or Trim( ls_GridDataObject[i]  ) = ''  ) Then lb_GridExists = True 
	/*******************************/
	
	lds_source.dataobject = ls_dataobject[i]
	lds_source.settransobject(sqlca)

	//Modified By Ken.Guo 2011-01-20	
	//ll_find = lds_sql.Find("dataobject = '" + ls_dataobject[i] + "'" + " and screen_name = '" + ls_screen_name[i] + "'", 1 , ll_count)
	ll_find = lds_sql.Find("screen_id = " + String(i), 1 , ll_count)

	IF ll_find > 0 THEN
		IF lb_update_falg THEN //Update All Screen syntax
		/**********************************///added by gavins 20120305 grid
			If lb_GridExists Then
				li_Cycle = 2
			Else
				li_Cycle = 1
			End If
		/**********************************/
				DO
					ll_view_id = lds_sql.GetItemNumber(ll_find,"data_view_id")
					ll_screen_id = lds_sql.GetItemNumber(ll_find,"screen_id")
					ii_Screen_ID = ll_Screen_ID
					//If lb_Upgrade is true then upgrade //added by gavins 20120521
					If Not(  lb_Upgrade[i]  And li_ReturnUpgrade = 1 ) Then
						lstr_syntax[ll_view_id].as_syntax[ll_screen_id] = ""
						lstr_syntax[ll_view_id].as_fieldlist[ll_screen_id] = ""  
						lstr_syntax[ll_view_id].as_gridsyntax[ll_screen_id] = ""
						lstr_syntax[ll_view_id].as_gridfieldlist[ll_screen_id] =""
						IF IsValid(w_infodisp) THEN
							w_infodisp.st_1.Text = 'Modification ' + String(i) + ' of ' + String(li_num) + '(View ID = ' + String(ll_view_id)  +'), Please stand by!'
						END IF
						ll_find = lds_sql.Find("screen_id = " + String(i),  ll_find + 1 , ll_count)
						IF ll_find = ll_count Or ll_Find <=0 THEN EXIT
						Continue
					End If
					
					gnv_debug.of_output( false, 'upgrade screen: '+ String(ll_view_id)+'-'+ String(ll_screen_id))
					 For li_k = 1 To li_Cycle
						Yield()
						//Update Screen syntax
										
						/************************************///added by gavins 20120305 grid
						If ( IsNull( ls_dataobject[i] ) Or Trim( ls_dataobject[i] ) = '' ) and li_k = 1 Then 
							lstr_syntax[ll_view_id].as_syntax[ll_screen_id] = ""
							lstr_syntax[ll_view_id].as_fieldlist[ll_screen_id] = ""  //jervis 10.18.2011
							lstr_syntax[ll_view_id].as_gridsyntax[ll_screen_id] = ""
							lstr_syntax[ll_view_id].as_gridfieldlist[ll_screen_id] =""
							Continue
						End If
						If li_k = 2 Then
							lds_source.dataobject = ls_GridDataObject[i]	
						Else
							lds_source.DataObject = ls_dataobject[i]
						End If
						/************************************/
						lds_source.SetTransObject(sqlca)
									
						//Added By Ken.Guo 2011-02-28.
						IF IsValid(w_infodisp) THEN
							w_infodisp.st_1.Text = 'Modification ' + String(i) + ' of ' + String(li_num) + '(View ID = ' + String(ll_view_id)  +'), Please stand by!'
						END IF				
						/********************///added by gavins 20120305 grid
						If li_k = 1 And ( IsNull( lds_sql.GetItemString( ll_find, 'dw_sql' ) ) Or Trim( lds_sql.GetItemString( ll_find, 'dw_sql' )  ) = '' ) And Len( ls_dataobject[i]  ) > 0  Then 
							ls_sql = lds_source.Describe("datawindow.syntax") //added by gavins 20120305
							lds_sql.SetItem(ll_find,	'dataobject', 	 ls_dataobject[i] 	)
							
						ElseIf li_k = 2 And ( IsNull( lds_sql.GetItemString( ll_find, 'grid_sql' ) ) Or Trim( lds_sql.GetItemString( ll_find, 'grid_sql' )  ) = '' ) Then 
							ls_sql = lds_source.Describe("datawindow.syntax") //added by gavins 20120305
							lds_sql.SetItem(ll_find,'grid_dataobject',ls_GridDataObject[i])
						Else
							IF appeongetclienttype() = 'PB' THEN
								If li_k = 2 Then
									ls_sql = f_get_screen_gridsql(ll_view_id,ll_screen_id,false)  
								Else
									ls_sql = f_get_screen_sql(ll_view_id,ll_screen_id,false)  //add false argu - jervis 10.11.2011
								End If
							ELSE
								If li_k = 2 Then
									ls_sql = lds_sql.GetItemString(ll_find,"grid_sql")
								Else
									ls_sql = lds_sql.GetItemString(ll_find,"dw_sql")
								End If
							END IF
						End If
						If IsNull( lds_sql.GetItemString( ll_find, 'screen_style' ) ) Or Trim( lds_sql.GetItemString( ll_find, 'screen_style' )  ) = ''  Then
							If  ls_ScreenStyle[i] = 'G' Then
								lds_sql.SetItem( ll_find, 'screen_style', 'G' )
							Else
								lds_sql.SetItem( ll_find, 'screen_style', 'F' )
							End If
						End If						
						If Len( ls_NeedModify[i] ) > 0 And ( IsNull( lds_sql.GetItemString( ll_find, 'grid_modify' ) ) Or Trim( lds_sql.GetItemString( ll_find, 'grid_modify' )  ) = ''   ) Then
							lds_sql.SetItem( ll_find, 'grid_modify', ls_NeedModify[i] )
						End If
						/********************/
						ls_TargetSyntax = ls_sql	
						lds_target.Create(ls_sql, ls_error_create)
						lds_target.SetTransObject(sqlca)
						lds_properties.Reset()
						
						//---------Begin Added by (Appeon)Harry 02.11.2014 for Bug # 3872--------
						If i = 5 Then
							ls_column[] =  {'custom_date1', 'custom_date2','custom_date3','custom_date4','custom_date5','custom_date6','custom_date7','custom_date8','custom_date9','custom_date10','custom_date11','custom_date12','custom_date13','custom_date14','custom_date15','custom_date16','custom_date17'}
							ls_ForceUpdates5 = ''
							For k = 1 to UpperBound(ls_column)
								If lds_target.Describe(ls_column[k] + ".visible") <> '1' Then
									If ls_column[k] = 'custom_date12' Then
										ls_ForceUpdates5 += 'tcustom_date12_t.visible="0" '
									Else
										ls_ForceUpdates5 += ls_column[k] + '_t.visible="0" ' 
									End If
								End If
							Next
						End If
						//---------End Added ------------------------------------------------------
						
						If ll_view_id = 1001 and ls_ForceUpdates1001[i] <> '' Then
							ls_ForceUpdates_screen	= ls_ForceUpdates[i] + ' '+ ls_ForceUpdates1001[i] +	of_get_update_ai(lds_target, lds_source.DataObject )//original ls_dataobject[i] modified by gavins 20120320		
						Else
							ls_ForceUpdates_screen	= ls_ForceUpdates[i] + 	of_get_update_ai(lds_target, lds_source.DataObject )		
						End If
						
						//---------Begin Added by (Appeon)Harry 02.11.2014 for Bug # 3872--------
						If i= 5 and Len (ls_ForceUpdates5) > 0 Then
							ls_ForceUpdates_screen = ls_ForceUpdates5 + ls_ForceUpdates_screen
						End If
						//---------End Added ------------------------------------------------------
						
//						of_update_object(lds_target,lds_source,lds_properties,ls_ForceUpdates_screen)
						lb_NewUpgrade =False//modified by gavins 201209225
						If of_update_changeobject( lds_source, lds_target,lds_properties,ls_ForceUpdates_screen)  < 0 Then
							of_update_object(lds_target,lds_source,lds_properties,ls_ForceUpdates_screen)
							lb_NewUpgrade = True
						End If
						
						//Added By Ken.Guo 2009-10-10. force update date alarm button's size.
						This.of_force_update_button(lds_source,i)			
						//Added By mark lee 04/10/12
						This.of_force_update_button_once(lds_source,i)			
						
						//$<add> 03.19.2008 by Andy
						ls_sql = of_post_update(lds_source,ll_screen_id)
						//end of add 03.19.2008
		
						ls_sql = of_special_update(ls_sql,ll_screen_id, lds_sql, ll_view_id ) //modified by gavins 20120328  last special update
						
						If lb_NewUpgrade Then of_arrageobject( ls_sql, ls_TargetSyntax )//added by gavins 20120601  modified by gavins 201209225
						
						//UPdate the clcus fields in custom tab by fee(NM) - jervis 07.22.2010
						if  lds_source.DataObject = "d_contract_fee_sched_nm" and  ib_init_fee then
							lds_source.SetTransObject(sqlca)
							this.of_update_fee_calc( ll_view_id, 0, lds_source, is_cacls)
						end if
						
						//PB Bug, When syntax length more than 32766, Set error - jervis 05.18.2011
						//lds_sql.SetItem(ll_find,"dw_sql",ls_sql)
	//					lstr_syntax[ll_view_id].as_syntax[ll_screen_id] = ls_sql
	//					lstr_syntax[ll_view_id].as_fieldlist[ll_screen_id] = lds_sql.GetItemString(ll_find,"fix_field")  //jervis 10.18.2011
						/************************///added by gavins 20120305 grid
						If li_k = 2 Then
							lstr_syntax[ll_view_id].as_gridsyntax[ll_screen_id] = ls_sql
							lstr_syntax[ll_view_id].as_gridfieldlist[ll_screen_id] = lds_sql.GetItemString(ll_find,"fix_field")
						Else
							lstr_syntax[ll_view_id].as_syntax[ll_screen_id] = ls_sql
							lstr_syntax[ll_view_id].as_fieldlist[ll_screen_id] = lds_sql.GetItemString(ll_find,"fix_field")  //jervis 10.18.2011
							lstr_syntax[ll_view_id].as_gridsyntax[ll_screen_id] = ""
							lstr_syntax[ll_view_id].as_gridfieldlist[ll_screen_id] =""
						End If					
						/************************/		
						//lds_sql.setitem(ll_find,'modify_date',today())	APB Bug,need use datetime convert 08.04.2007
						lds_sql.SetItem(ll_find,'modify_date',DateTime(Today(),Now()))			
						
						ls_sql = ""
					Next//	
					IF ll_find = ll_count THEN EXIT
					/************************///added by gavins 20120305 grid
//					If li_k = 2 Then
//						ll_find = lds_sql.Find("grid_dataobject = '" + ls_GridDataObject[i] + "'" + " and screen_name = '" + ls_screen_name[i] + "'", ll_find + 1 , ll_count)
//					Else
//						ll_find = lds_sql.Find("dataobject = '" + ls_dataobject[i] + "'" + " and screen_name = '" + ls_screen_name[i] + "'", ll_find + 1 , ll_count)
//					End If
					ll_find = lds_sql.Find("screen_id = " + String(i),  ll_find + 1 , ll_count)
					/************************/
				LOOP While (ll_find > 0)	
		ELSE
			//update sql when update = 1 and version > number of current version
		END IF
		
		
	ELSE
		ls_sql = lds_source.Describe("datawindow.syntax")
		li_row = lds_sql.InsertRow(0)
		lds_sql.SetItem(li_row,'data_view_id',1001)
		lds_sql.SetItem(li_row,'screen_id',i)
		lds_sql.SetItem(li_row,'tab_name',ls_tab_name[i])
		lds_sql.SetItem(li_row,'screen_name',ls_screen_name[i])
		lds_sql.SetItem(li_row,'dw_name',ls_dw_name[i])
		
		lds_sql.SetItem(li_row,'create_date',DateTime(Today(),Now()))
		lds_sql.SetItem(li_row,'modify_date',DateTime(Today(),Now()))
		lstr_syntax[1001].as_gridsyntax[i] = ""
		lstr_syntax[1001].as_syntax[i] = ''	
		If  Not ( IsNull( ls_dataobject[i] ) Or Trim( ls_dataobject[i] ) = ''  ) Then
			lds_sql.SetItem(li_row,'dataobject',ls_dataobject[i])
//			lds_sql.SetItem(li_row,'dw_sql',ls_sql)
			//PB Bug, When syntax length more than 32766, Set error - jervis 05.18.2011
			lstr_syntax[1001].as_syntax[i] = ls_sql
			lstr_syntax[1001].as_fieldlist[i] = ''
			lstr_syntax[1001].as_gridfieldlist[i] =""
		End If
		/**********************************///added by gavins 20120305 grid
		If lb_GridExists Then
			lds_source.dataobject = ls_GridDataObject[i]	
			lds_source.SetTransObject( sqlca )
			ls_GridSql =  lds_source.Describe("datawindow.syntax")
			lds_sql.SetItem(li_row,'grid_dataobject',ls_GridDataObject[i])
//			lds_sql.SetItem(li_row,'grid_sql',ls_GridSql)
			//PB Bug, When syntax length more than 32766, Set error - jervis 05.18.2011
			lstr_syntax[1001].as_gridsyntax[i] = ls_GridSql
			lstr_syntax[1001].as_gridfieldlist[i] = ''
			lstr_syntax[1001].as_fieldlist[i] = ''
		End If
		lds_sql.SetItem( li_row, 'screen_style', ls_ScreenStyle[i] )
		lds_sql.SetItem( li_row, 'grid_modify', ls_NeedModify[i] )
		/**********************************/				
	END IF
	
NEXT

//$<modify> 03.12.2008 by Andy
/*
IF lds_sql.Update() <> 1 THEN
	ii_num++
	IF ii_num < 3 THEN
		of_appeon2_changes()
	END IF
END IF
ii_num = 1
*/


if lds_sql.Update() <> 1 then
	ls_Error= "n_cst_update_screen.of_appeon2_changes() Information: lds_sql.Update() failed, call support." 
	IF IsValid(gnv_logservice)THEN 
		gnv_logservice.of_setloglevel(2) //warning level
		gnv_logservice.of_log_warning(ls_Error)
		gb_upgrade_failed = TRUE			
	END IF	
	Rollback;
	lb_Error = true //added by gavins 20120524
else
	COMMIT;
end if
//end of modify 03.12.2008

//$<Add> 03.12.2008 by Andy
//Reason:When syntax length more than 32766,Update will failed in ASA DB in WEB 
blob lblob_syntax,lblob_opsyntax
string ls_opsyntax,ls_lookuplist, ls_Modify
ll_count = lds_sql.Rowcount( )
IF IsValid(w_infodisp) THEN w_infodisp.Title = 'Update syntax of view'
IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'Update syntax of view, Please stand by!'
IF IsValid(w_infodisp) THEN w_infodisp.wf_set_min_max(1,ll_count)
FOR i = 1 to ll_count
	Yield()	
	
	ll_view_id   = lds_sql.GetItemNumber(i,"data_view_id")
	ll_screen_id = lds_sql.GetItemNumber(i,"screen_id")
	ls_Modify = lds_sql.GetItemString(i,"grid_modify") //add by gavins 20120305 grid
	//PB Bug,When syntax length more than 32766, Get error -- jervis 05.18.2011
	//ls_sql       = lds_sql.GetitemString(i,"dw_sql")
	//lblob_syntax = blob(ls_sql)
	IF IsValid(w_infodisp) THEN
		w_infodisp.wf_step_pbar(1)
		w_infodisp.st_1.Text = 'Modification ' + String(i) + ' of ' + String(ll_count)+'(View ID = ' + String(ll_view_id)  +' ,Screen ID = ' + string(ll_screen_id ) + ' ), Please stand by!'
	END IF
	
	/**********************************/
	If Not( IsNull( lstr_syntax[ll_view_id].as_gridsyntax[ll_screen_id]  ) Or Trim( lstr_syntax[ll_view_id].as_gridsyntax[ll_screen_id]  ) = '' ) Then
		lb_GridExists = True
		li_cycle = 2
	Else
		li_Cycle = 1
	End If
	/**********************************/	
	For li_k = 1 To li_Cycle
		If li_k = 1 Then
			//if the freeform is not exists  the grid must exists.
			If 	IsNull( lstr_syntax[ll_view_id].as_syntax[ll_screen_id] ) Or Trim( lstr_syntax[ll_view_id].as_syntax[ll_screen_id] ) = '' Then Continue //added by gavins 20120319 grid 
			lblob_syntax = blob(lstr_syntax[ll_view_id].as_syntax[ll_screen_id] )
			ls_opsyntax = ""
			ls_lookuplist = ""
			ls_Error = ''
			//get opsyntax -jervis 10.18.2011
			gf_get_opsyntax(lstr_syntax[ll_view_id].as_syntax[ll_screen_id] ,lstr_syntax[ll_view_id].as_fieldlist[ll_screen_id],ls_opsyntax,ls_lookuplist)
			ls_SQL = ls_opsyntax
			lblob_opsyntax = blob(ls_opsyntax)
		
			UPDATEBLOB ctx_screen SET dw_sql = :lblob_syntax   WHERE data_view_id = :ll_view_id 	AND screen_id = :ll_screen_id;
			if sqlca.sqlcode < 0 then	
				ls_Error= "n_cst_update_screen.of_appeon2_changes() Information: UPDATEBLOB failed, call support."  + SQLCA.sqlerrtext + "~r~n"
				Rollback;
				lb_Error = true //added by gavins 20120524
			else 
				commit;
			end if

			UPDATEBLOB ctx_screen SET dw_opsql = :lblob_opsyntax WHERE data_view_id = :ll_view_id 	AND screen_id = :ll_screen_id;
			if sqlca.sqlcode < 0 then	
				ls_Error+= "n_cst_update_screen.of_appeon2_changes() Information: UPDATEBLOB failed, call support."  + SQLCA.sqlerrtext + "~r~n"
				Rollback;
				lb_Error = true //added by gavins 20120524
			else 
				commit;
			end if
			UPDATE  ctx_screen SET lookup_list = :ls_lookuplist WHERE data_view_id = :ll_view_id 	AND screen_id = :ll_screen_id;
			if sqlca.sqlcode < 0 then	
				ls_Error+= "n_cst_update_screen.of_appeon2_changes() Information: UPDATE failed, call support."  + SQLCA.sqlerrtext + "~r~n"
				Rollback;
				lb_Error = true //added by gavins 20120524
			else 
				commit;
			end if
			
			if ls_error <> "" then
				IF IsValid(gnv_logservice)THEN 
					gnv_logservice.of_setloglevel(2) //warning level
					gnv_logservice.of_log_warning(ls_Error)
					gb_upgrade_failed = TRUE			
				END IF
			end if
		Else// grid
			lblob_syntax = blob(lstr_syntax[ll_view_id].as_Gridsyntax[ll_screen_id] )
			ls_opsyntax = ""
			ls_lookuplist = ""
			ls_Error = ''
			//get opsyntax -jervis 10.18.2011
			gf_get_opsyntax(lstr_syntax[ll_view_id].as_gridsyntax[ll_screen_id] ,lstr_syntax[ll_view_id].as_gridfieldlist[ll_screen_id],ls_opsyntax,ls_lookuplist)
			
//			If ls_Modify = 'Y' Then//add by gavins 20120305 grid
//				of_ModifyDataWindow( ls_SQL, ls_opsyntax, 'grid' )//freeform to grid 				
//			End If
			
			lblob_opsyntax = blob(ls_opsyntax)
		
			UPDATEBLOB ctx_screen SET grid_sql = :lblob_syntax    WHERE data_view_id = :ll_view_id 	AND screen_id = :ll_screen_id;
			if sqlca.sqlcode < 0 then	
				ls_Error= "n_cst_update_screen.of_appeon2_changes() Information: UPDATEBLOB failed, call support."  + SQLCA.sqlerrtext + "~r~n"
				Rollback;
				lb_Error = true //added by gavins 20120524
			else 
				commit;
			end if

			UPDATEBLOB ctx_screen SET grid_opsql = :lblob_opsyntax WHERE data_view_id = :ll_view_id 	AND screen_id = :ll_screen_id;
			if sqlca.sqlcode < 0 then	
				ls_Error+= "n_cst_update_screen.of_appeon2_changes() Information: UPDATEBLOB failed, call support."  + SQLCA.sqlerrtext + "~r~n"
				Rollback;
				lb_Error = true //added by gavins 20120524
			else 
				commit;
			end if
			UPDATE  ctx_screen SET lookup_list = :ls_lookuplist WHERE data_view_id = :ll_view_id 	AND screen_id = :ll_screen_id;
			if sqlca.sqlcode < 0 then	
				ls_Error+= "n_cst_update_screen.of_appeon2_changes() Information: UPDATE failed, call support."  + SQLCA.sqlerrtext + "~r~n"
				Rollback;
				lb_Error = true //added by gavins 20120524
			else 
				commit;
			end if
			
			if ls_error <> "" then
				IF IsValid(gnv_logservice)THEN 
					gnv_logservice.of_setloglevel(2) //warning level
					gnv_logservice.of_log_warning(ls_Error)
					gb_upgrade_failed = TRUE			
				END IF
			end if
			
		End If
		/**********************************/
	Next
next
//End of add 03.12.2008
//added by gavins 20120521
If lds_Original.ModifiedCount( ) > 0 And Not lb_Error Then 
	If lds_Original.Update( )  <> 1 Then
		Rollback;
		IF IsValid(gnv_logservice)THEN 
			ls_Error = 'Failed to save original syntax!'
			gnv_logservice.of_setloglevel(2) //warning level
			gnv_logservice.of_log_warning(ls_Error)
		END IF
	End If
	For li_k = 1 To lds_Original.Rowcount( )
		If lb_Upgrade[ li_k ] Then
			If Len( ls_gridsyntax[ li_k]  ) > 0 And Len( ls_freesyntax[li_k] ) > 0  Then
				Update ctx_screen_original set dw_sql = :ls_freesyntax[li_k], grid_sql = :ls_gridsyntax[ li_k] where data_view_id = 1001 and screen_id = :li_k;
			ElseIf Len( ls_gridsyntax[ li_k]  ) > 0 Then
				Update ctx_screen_original set grid_sql = :ls_gridsyntax[ li_k] where data_view_id = 1001 and screen_id = :li_k;
			ElseIf Len( ls_freesyntax[li_k] ) > 0  Then
				Update ctx_screen_original set dw_sql = :ls_freesyntax[li_k] where data_view_id = 1001 and screen_id = :li_k;
			End If
		End If		
	Next	
End If
DELETE From ctx_screen Where screen_id = 44;

//$<add> 11.08.2006 By: Davis
//$<reason> Fix a defect.
INSERT INTO ctx_screen(data_view_id,screen_id,tab_name,screen_name,dw_name,dataobject,description,dw_sql,create_date,modify_date, grid_sql, screen_style, grid_dataobject , grid_modify ) //add gird_sql, screen_style
	SELECT d.data_view_id,a.screen_id,a.tab_name,screen_name,dw_name,dataobject,description,dw_sql,create_date,modify_date , grid_sql, screen_style, grid_dataobject, grid_modify
	FROM ctx_screen a,data_view d
	WHERE d.type_c = 'C' AND a.data_view_id = 1001 AND d.data_view_id <> 1001
	AND EXISTS(
	SELECT 1 FROM ctx_screen b
	WHERE data_view_id <> 1001
	AND a.tab_name = b.tab_name
	AND d.data_view_id = b.data_view_id
	)
	AND NOT EXISTS(
	SELECT 1 FROM ctx_screen c
	WHERE c.data_view_id <> 1001
	AND d.data_view_id = c.data_view_id
	AND a.screen_id = c.screen_id
	AND a.tab_name = c.tab_name
	);
//$<Add> 03.12.2008 by Andy
if sqlca.sqlcode <> 0 then
	ls_Error= "n_cst_update_screen.of_appeon2_changes() Information: INSERT INTO ctx_screen failed, call support." 
	IF IsValid(gnv_logservice)THEN 
		gnv_logservice.of_setloglevel(2) //warning level
		gnv_logservice.of_log_warning(ls_Error)
		gb_upgrade_failed = TRUE			
	END IF
	Rollback;
else
	COMMIT;
end if
//end of add 03.12.2008

//Added By Ken.Guo 2010-03-09.
If Not gb_upgrade_failed Then
	Update icred_settings Set screen_version = :is_screen_version ;
End If

If isvalid(lds_sql) Then Destroy lds_sql
If isvalid(lds_source) Then Destroy lds_source
If isvalid(lds_target) Then Destroy lds_target
If isvalid(lds_properties) Then Destroy lds_properties



end subroutine

public function integer of_update_fee_calc (long al_view_id, long al_ctx_id, datastore ads_fee, string as_calcs[]);//Add by Jervis 07.20.2010
long ll_i,ll_count,ll_j
long ll_ctx_id[],ll_row
n_ds lds_ctx
decimal ldec_calc1,ldec_calc2,ldec_calc3
//w_infodisp w_infodisp

SetPointer(HourGlass!)
if al_ctx_id > 0 then
	ll_ctx_id[1] = al_ctx_id
else
	//Find ctx
	lds_ctx = create n_ds
	lds_ctx.dataobject = "d_ctx_by_view"
	lds_ctx.SetTransObject(sqlca)
	if lds_ctx.Retrieve( al_view_id) < 1 then return 0
	ll_ctx_id = lds_ctx.object.ctx_id.primary
end if

ll_count = Upperbound(ll_ctx_id)
If ll_count = 0 Then 
	Return 1
End If

//Open(w_infodisp)  Parent function need open this window, if it need show the info window
IF IsValid(w_infodisp) THEN w_infodisp.Title = 'Updating Screen Data'
IF IsValid(w_infodisp) THEN w_infodisp.Center = True
IF IsValid(w_infodisp) THEN w_infodisp.st_complete.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_3.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_information.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'Updating fee schedule calc fields data, please stand by......'
IF IsValid(w_infodisp) THEN w_infodisp.wf_set_min_max(1,ll_count)

For ll_i = 1 to ll_count
	Yield()
	IF IsValid(w_infodisp) THEN w_infodisp.wf_step(1)
	IF IsValid(w_infodisp) THEN w_infodisp.Title = 'Updating Screen Fee Schedule Calc Fields Data . ' + 'View ID: ' + String(al_view_id) 
	
	ll_row = ads_fee.Retrieve(ll_ctx_id[ll_i])
	ldec_calc1 = 0
	ldec_calc2 = 0
	ldec_calc3 = 0
		
	if ll_row > 0 then
		If UpperBound(as_calcs) = 0 Then
			//Added By Ken.Guo 03/21/2012. 
			ldec_calc1 = ads_fee.GetItemDecimal(1,'calc_field_1')
			ldec_calc2 = ads_fee.GetItemDecimal(1,'calc_field_2')
			ldec_calc3 = ads_fee.GetItemDecimal(1,'calc_field_3')
			
			//Added By Ken.Guo 06/13/2012
			If isvalid(lds_ctx) Then //for more ctx, use ds 
				If ldec_calc1	 = lds_ctx.GetItemDecimal(ll_i,'fee_sched_calc_field_1')  or (isnull(ldec_calc1) and isnull( lds_ctx.GetItemDecimal(ll_i,'fee_sched_calc_field_1')))  Then
					//Ignore if match
				Else
					lds_ctx.SetItem(ll_i, 'fee_sched_calc_field_1', ldec_calc1)
				End If
				If ldec_calc2	 = lds_ctx.GetItemDecimal(ll_i,'fee_sched_calc_field_2')  or (isnull(ldec_calc2) and isnull( lds_ctx.GetItemDecimal(ll_i,'fee_sched_calc_field_2')))  Then
					//Ignore if match
				Else
					lds_ctx.SetItem(ll_i, 'fee_sched_calc_field_2', ldec_calc2)
				End If
				If ldec_calc3	 = lds_ctx.GetItemDecimal(ll_i,'fee_sched_calc_field_3')  or (isnull(ldec_calc3) and isnull( lds_ctx.GetItemDecimal(ll_i,'fee_sched_calc_field_3')))  Then
					//Ignore if match
				Else
					lds_ctx.SetItem(ll_i, 'fee_sched_calc_field_3', ldec_calc3)
				End If
			Else //for single ctx
				Update ctx_basic_info Set fee_sched_calc_field_1 = :ldec_calc1,fee_sched_calc_field_2 = :ldec_calc2,fee_sched_calc_field_3 = :ldec_calc3
				Where ctx_id = :ll_ctx_id[ll_i];						
			End If

		Else
			for ll_j = 1 to upperbound(as_calcs)
				choose case as_calcs[ll_j]
					case 'calc_field_1'
						ldec_calc1 = ads_fee.GetItemDecimal(1,as_calcs[ll_j])
						If isvalid(lds_ctx) Then //for more ctx, use ds 
							If ldec_calc1	 = lds_ctx.GetItemDecimal(ll_i,'fee_sched_calc_field_1')  or (isnull(ldec_calc1) and isnull( lds_ctx.GetItemDecimal(ll_i,'fee_sched_calc_field_1')))  Then
								//Ignore if match
							Else
								lds_ctx.SetItem(ll_i, 'fee_sched_calc_field_1', ldec_calc1)
							End If						
						Else
							Update ctx_basic_info set fee_sched_calc_field_1 = :ldec_calc1
							where ctx_id = :ll_ctx_id[ll_i];
						End If
					case 'calc_field_2'
						ldec_calc2 = ads_fee.GetItemDecimal(1,as_calcs[ll_j])
						If isvalid(lds_ctx) Then //for more ctx, use ds 
							If ldec_calc2	 = lds_ctx.GetItemDecimal(ll_i,'fee_sched_calc_field_2')  or (isnull(ldec_calc2) and isnull( lds_ctx.GetItemDecimal(ll_i,'fee_sched_calc_field_2')))  Then
								//Ignore if match
							Else
								lds_ctx.SetItem(ll_i, 'fee_sched_calc_field_2', ldec_calc2)
							End If							
						Else
							Update ctx_basic_info set fee_sched_calc_field_2 = :ldec_calc2
							where ctx_id = :ll_ctx_id[ll_i];
						End If
					case 'calc_field_3'
						ldec_calc3 = ads_fee.GetItemDecimal(1,as_calcs[ll_j])
						If isvalid(lds_ctx) Then //for more ctx, use ds 
							If ldec_calc3	 = lds_ctx.GetItemDecimal(ll_i,'fee_sched_calc_field_3')  or (isnull(ldec_calc3) and isnull( lds_ctx.GetItemDecimal(ll_i,'fee_sched_calc_field_3')))  Then
								//Ignore if match
							Else
								lds_ctx.SetItem(ll_i, 'fee_sched_calc_field_3', ldec_calc3)
							End If							
						Else
							Update ctx_basic_info set fee_sched_calc_field_3 = :ldec_calc3
							where ctx_id = :ll_ctx_id[ll_i];
						End If
				end choose
			next
		End If
	else
		//Modified By Ken.Guo 06/13/2012
		If isvalid(lds_ctx) Then //for more ctx, use ds 
			If ldec_calc1	 = lds_ctx.GetItemDecimal(ll_i,'fee_sched_calc_field_1')  or  isnull( lds_ctx.GetItemDecimal(ll_i,'fee_sched_calc_field_1'))  Then
				//Ignore if match
			Else
				lds_ctx.SetItem(ll_i, 'fee_sched_calc_field_1', 0)
			End If
			If ldec_calc2	 = lds_ctx.GetItemDecimal(ll_i,'fee_sched_calc_field_2')  or isnull( lds_ctx.GetItemDecimal(ll_i,'fee_sched_calc_field_2'))  Then
				//Ignore if match
			Else
				lds_ctx.SetItem(ll_i, 'fee_sched_calc_field_2', 0)
			End If
			If ldec_calc3	 = lds_ctx.GetItemDecimal(ll_i,'fee_sched_calc_field_3')  or isnull( lds_ctx.GetItemDecimal(ll_i,'fee_sched_calc_field_3'))  Then
				//Ignore if match
			Else
				lds_ctx.SetItem(ll_i, 'fee_sched_calc_field_3', 0)
			End If
		Else
			Update ctx_basic_info set fee_sched_calc_field_1 = 0,fee_sched_calc_field_2 = 0,fee_sched_calc_field_3 = 0
			where ctx_id = :ll_ctx_id[ll_i];
		End If
	end if
next

If lds_ctx.modifiedcount( ) + lds_ctx.deletedcount( ) > 0 Then
	lds_ctx.update()
End If
SetPointer(Arrow!)

//IF IsValid(w_infodisp) Then Close(w_infodisp)
if isvalid(lds_ctx) then destroy lds_ctx
return 1

end function

public subroutine of_per_screen_process ();//Add custom 2 and multi-record tabpage in contract folder - jervis 05.16.2011
datastore lds_source
datastore lds_screen
string ls_sql
string ls_dataobject
string  ls_syntax

lds_source = Create n_cst_datastore

//Delete from  ctx_screen where screen_id = 32 and dataobject <> 'd_dm_browse_filter';
UPDATE ctx_screen Set screen_name = 'Other Contacts' + substring(screen_name,9,100) 
Where screen_id In (14,15,16,17) And substring(screen_name,1,8) = 'Contacts';

lds_source.DataObject = 'd_dm_browse_filter'
//lds_source.SetTransObject(sqlca)
ls_sql = lds_source.Describe("datawindow.syntax")
UPDATE ctx_screen SET dw_sql = :ls_sql,modify_date = getdate(),
	screen_name = 'Document Manager->Document Tab->Search Criteria',
	dw_name = 'dw_filter',
	dataobject = 'd_dm_browse_filter'
Where screen_id = 32 And DataObject = 'd_cntx_images';



//Replace 'View audit' to custom 2 
select dataobject into :ls_dataobject from ctx_screen where screen_id = 10 and data_view_id = 1001;
if ls_dataobject = 'd_view_audit2_ctx' then
	lds_source.DataObject = 'd_contract_det_custom_2'
	ls_syntax = lds_source.Describe("datawindow.syntax")
	
	update ctx_tabpage_properties set text = 'Custom Data 2' where tabpage_name = 'tabpage_det_audit';
	update ctx_tabpage_screen set default_text = 'Custom Data 2' where ts_id in (14,15);
	
	

	update ctx_screen set dw_sql = :ls_syntax,dataobject = 'd_contract_det_custom_2' ,screen_name = 'Details->Custom Data 2->Custom Data 2',modify_date = getdate()
	where screen_id = 10 and dataobject = 'd_view_audit2_ctx';
	
	//update ctx_screen set dw_sql = :ls_syntax,modify_date = getdate()
	//where screen_id = 10  ;
end if

COMMIT;

destroy lds_source

	


end subroutine

public subroutine of_modifydatawindow (ref string as_freeform, ref string as_grid, string as_method);// modify freeform or grid with grid or freeform
DataStore			lds_Free, lds_Grid, lds_Properties
string					ls_error,ls_tObjects, ls_tObjectlist[]
string					ls_Type,ls_ObjName
Long					ll_tObjcount, ll_i


lds_Free = Create DataStore
lds_Grid = Create DataStore

If as_method = 'grid' Then
	lds_Free.Create( as_freeform, 	ls_error )
	If Len( ls_error ) > 0 Then
		gnv_debug.of_output( true, 'Failed to create dw in ( of_modifydatawindow), error=' + ls_error + ',syntax=' + as_freeform )//added by gavins 20120919
		Return
	End If
	lds_Grid.Create( as_grid, ls_error )
	If Len( ls_error ) > 0 Then
		gnv_debug.of_output( true, 'Failed to create dw in ( of_modifydatawindow), error=' + ls_error + ',syntax=' + as_grid )
		Return
	End If
Else
	lds_Free.Create( as_grid, 	ls_error )
	If Len( ls_error ) > 0 Then
		gnv_debug.of_output( true, 'Failed to create dw in ( of_modifydatawindow), error=' + ls_error + ',syntax=' + as_grid )
		Return
	End If
	lds_Grid.Create( as_freeform , ls_error )
	If Len( ls_error ) > 0 Then
		gnv_debug.of_output( true, 'Failed to create dw in ( of_modifydatawindow), error=' + ls_error+ ',syntax=' + as_freeform )
		Return
	End If
End If	

ls_tObjects  = lds_Free.Describe("DataWindow.Objects")
ll_tObjcount = inv_string.of_parsetoarray(ls_tObjects,'~t',ls_tObjectlist)

lds_properties = Create DataStore
lds_properties.DataObject = "d_update_user_datawindow_objlist"


For ll_i = 1 To ll_tObjcount
	ls_ObjName = ls_tObjectlist[ll_i]
	ls_Type =  lds_Free.Describe(ls_ObjName + ".type") 
	If ls_type = "column" Or ls_type = "text" then 
		of_get_object_attribute(lds_Free,lds_properties,ls_ObjName)		
	End If
	
Next


of_set_ObjectPro(lds_Grid,lds_properties)
	
//datawindow background color 
lds_Grid.Modify( "datawindow.color = " + lds_Free.Describe( "datawindow.color" )  )
	
as_grid = lds_Grid.Describe( "datawindow.syntax" )
as_freeform = lds_Free.Describe( "datawindow.syntax" )

If isvalid(lds_Free) Then Destroy lds_Free
If isvalid(lds_Grid) Then Destroy lds_Grid
end subroutine

public function integer of_get_object_attribute (datastore ids_terget, ref datastore ids_properties, string as_objname);Integer i,li_objcount

String ls_colpro[],ls_DwPro[]
String ls_proname, ls_provalue
Integer j, li_colcount,li_DwProCount
Integer li_insert
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-10-24 By: Andy
Integer li_txtcount
String  ls_band,ls_txtpro[],ls_type

//<Modify> 12.14.2007 by: Andy
//Reason:Add "Band","Footer.Height","Summary.Height","Header.Height"
//Add Font.face,Font.strikethrough,font.heigth - jervis 09.06.2011                    "x","y","width","height",
ls_txtpro = {"Font.face","Font.strikethrough","font.heigth","Font.Italic","Font.Underline","Font.Weight","text","alignment","Color","Background.Mode","Background.Color","visible","border" }//<modify> 05.26.2008 by Andy  del:,"tag"
li_txtcount = UpperBound(ls_txtpro)
ls_type = ids_terget.Describe(as_objname + ".type")
//ls_band = ids_terget.Describe(as_objname +".Band")
//---------------------------- APPEON END ----------------------------

//Delete Font.face - jervis 01.13.2011
//Init update properties
//Add ddlb.VScrollBar,edit.VScrollBar,edit.format,format,ddlb.AutoHScroll,SlideUp,Height.AutoSize -- jervis 04.21.2011
//Add Font.face,Font.strikethrough,font.heigth - jervis 09.06.2011                            "x","y","width","height",
ls_colpro = {"Font.face","Font.strikethrough","font.heigth","Font.Italic","Font.Underline","Font.Weight","alignment","tabsequence",&
"Edit.Required","dddw.Required","ddlb.Required","EditMask.Required","Edit.Case","DDLB.Case","EditMask.Mask","edit.displayonly","edit.AutoHScroll","edit.NilIsNull",&
"dddw.VscrollBar","dddw.AutoHScroll","dddw.useasborder","dddw.NilIsNull","dddw.name","dddw.datacolumn","dddw.displaycolumn","dddw.PercentWidth","tag",&
"Initial","visible","border","Color","Background.Mode","Background.Color","ddlb.VScrollBar","edit.VScrollBar","edit.format","format","ddlb.AutoHScroll","SlideUp","Height.AutoSize",&
"checkbox.3d","checkbox.lefttext","checkbox.off","checkbox.on","checkbox.other","checkbox.scale","checkbox.text" }//,"protect"

//ls_DwPro = {"Detail.Height","Table.Sort"}

//add Detail.Height.AutoSize -- jervis 04.21.2011
ls_DwPro = {"Detail.Height","Table.Sort","Footer.Height","Summary.Height","Header.Height","Color","Detail.Height.AutoSize"}//"DataWindow.Color"}//modified by nova  2008/09/17 //Modify by Evan 07.21.2008, add DataWindow.Color property
//end of modify
li_colcount = UpperBound(ls_colpro)
li_DwProCount = UpperBound(ls_DwPro)

//modify 10/24/2007 by: Andy
//if ids_terget.Describe(as_objname + ".type") = "column" then
if lower(ls_type) = "column" then
	For j = 1 To li_colcount
		ls_proname = ls_colpro[j]
		ls_provalue = ids_terget.Describe(as_objname+"."+ls_proname)
		if isnull(ls_provalue) then ls_provalue = "!"
		Choose Case ls_provalue
			Case "!","?"
				Continue
			Case Else
				//Start Code By Jervis 03.11.2008
				//Fixed Bug,Expressions involving Null values may arrive at different values in JavaScript 
				//from their values in PowerScript
				//if isnull(ls_provalue) then continue
				//if ls_proname = 'Initial' and ls_provalue = 'null' then setnull(ls_provalue)
				//End Code By Jervis 03.11.2008
				li_insert = ids_properties.InsertRow(0)
				ids_properties.Object.obj_name[li_insert] = as_objname
				ids_properties.Object.obj_pro[li_insert] = ls_proname
				ids_properties.Object.obj_value[li_insert] = ls_provalue
		End Choose
	Next
elseif lower(ls_type) = "text" then
	For j = 1 To li_txtcount
		ls_proname = ls_txtpro[j]
		ls_provalue = ids_terget.Describe(as_objname+"."+ls_proname)
		if isnull(ls_provalue) then ls_provalue = "!"
		Choose Case ls_provalue
			Case "!","?"
				Continue
			Case Else
				li_insert = ids_properties.InsertRow(0)
				ids_properties.Object.obj_name[li_insert] = as_objname
				ids_properties.Object.obj_pro[li_insert] = ls_proname
				ids_properties.Object.obj_value[li_insert] = ls_provalue
		End Choose
	Next
end if

if lower(as_objname) = "datawindow" then
	for j = 1 to li_DwProCount
		ls_proname = ls_DwPro[j]
		ls_provalue = ids_terget.Describe("DataWindow." + ls_proname)
		Choose Case ls_provalue
			Case "!","?"
				Continue
			Case Else
				li_insert = ids_properties.InsertRow(0)
				ids_properties.Object.obj_name[li_insert] = as_objname
				ids_properties.Object.obj_pro[li_insert] = ls_proname
				ids_properties.Object.obj_value[li_insert] = ls_provalue
		End Choose
	next
end if

Return 1
end function

public function integer of_update_fee_calc (long al_view_id);//////////////////////////////////////////////////////////////////////////////////////
// Function: of_update_fee_calc
// Arguments:
// 	al_view_id.  0 = all view.
//-----------------------------------------------------------------------------------
// Return:  integer
//-----------------------------------------------------------------------------------
// Author:	 Ken.Guo 03/21/2012.
//-----------------------------------------------------------------------------------
// Description: Update Fee Schedule's Calc value to Custom Screen
//-----------------------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////////////////////

Long i,ll_view_id
String ls_DWSyntax,ls_Err,ls_Calcs[]
n_ds lds_fee_screen //31
n_ds lds_view_list

lds_fee_screen = Create n_ds
If al_View_ID = 0 Then
	//For All View 
	lds_view_list = Create n_ds
	lds_view_list.DataObject = 'd_data_view_list'
	lds_view_list.SetTransObject(SQLCA)
	lds_view_list.Retrieve()
	SetPointer(HourGlass!)
	If lds_view_list.RowCount() > 0 Then
		If Not Isvalid(w_infodisp) Then
			Open(w_infodisp)
		End If
	End If
	For i = 1 To lds_view_list.RowCount()
		ll_view_id = lds_view_list.GetItemNumber(i,'data_view_id')
		If ll_View_ID < 1001 Then 
			Continue
		End If
		ls_DWSyntax = f_get_screen_syntax(ll_view_id,31,False)
		If Len(ls_DWSyntax) = 0 or Isnull(ls_DWSyntax) Then 
			Continue
		End If
		lds_fee_screen.Create( ls_DWSyntax, ls_err)
		lds_fee_screen.SetTransObject(SQLCA)
		If Len(ls_err) > 0 Then 
			gnv_debug.Of_Output('n_cst_update_screen.of_update_fee_calc('+String(ll_view_id)+') : Failed to create datastore. ' + ls_err)
			Continue
		End If
		This.of_Update_Fee_Calc( ll_view_id, 0, lds_fee_screen, ls_Calcs)		
	Next
	If Isvalid(w_infodisp) Then Close(w_infodisp)
Else
	//For Single View
	ls_DWSyntax = f_get_screen_syntax(al_view_id,31,False)
	If Len(ls_DWSyntax) = 0 or Isnull(ls_DWSyntax) Then 
		Return -1 
	End If
	lds_fee_screen.Create( ls_DWSyntax, ls_err) 
	lds_fee_screen.SetTransObject(SQLCA)
	If Len(ls_err) > 0 Then 
		gnv_debug.Of_Output('n_cst_update_screen.of_update_fee_calc('+String(al_view_id)+') : Failed to create datastore. ' + ls_err)
		Return -2
	End If
	If Not Isvalid(w_infodisp) Then
		Open(w_infodisp)
	End If	
	This.of_Update_Fee_Calc( al_view_id, 0, lds_fee_screen, ls_Calcs)
	If Isvalid(w_infodisp) Then Close(w_infodisp)
End If

If Isvalid(lds_view_list) Then Destroy lds_view_list
If Isvalid(lds_fee_screen) Then Destroy lds_fee_screen

Return  1
end function

public function string of_special_update (string as_syntax, long al_screen_id, datastore ads_sql, long al_view_id);//====================================================================
// Event: n_cst_update_screen.of_special_update()
//--------------------------------------------------------------------
// Description:
// Adjust the syntax that it was saved in DB before upgrade the syntax.
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_syntax   	
// 	value	long  	al_screen_id	
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Andy		Date: Oct 29,2007
//--------------------------------------------------------------------
// Modify History:
//Modified by gavins 20120328
//====================================================================

datastore lds_target , lds_Property, lds_Source
String    ls_Err,ls_tObjects,ls_tObjectlist[],ls_band,ls_ObjName,ls_Modify = ''
Long      ll_i,ll_tObjcount
String    ls_SynTax
Long    ll_pos, ll_FRow
integer li_Processing = 0
String		ls_Column1[], ls_Column2[]
String		ls_Scol1[], ls_Scol2[]
String		ls_ScreenStyle, ls_sql, ls_dataObject
String		ls_DataColumn, ls_DisplayColumn, ls_EditStyle

ls_SynTax = as_syntax

If al_screen_id = 1 Then
	lds_Source = Create DataStore
	lds_target = Create DataStore
	lds_target.Create( ls_Syntax, ls_err )

	lds_Property = Create DataStore
	lds_Property.DataObject = "d_update_user_datawindow_objlist"
	
	ls_Column1 = {  'CCCI_custom_n1', 'CCCI_custom_1' , 'CCCI_custom_n1_t', 'CCCI_custom_1_t', 'ccci_association','ccci_association_t' }
	ls_Column2 = {  'OCCI_custom_n1', 'OCCI_custom_1', 'OCCI_custom_n1_t', 'OCCI_custom_1_t', 'occi_association', 'occi_association_t' }
	ls_Scol1[] = { 'Custom_n1',  'Custom_1' , 'Custom_n1_t', 'Custom_1_t', 'association', 'association_t' }
		
	If lds_target.Describe( 'CCCI_custom_n1.tag') = '1#' Then
		ll_FRow = ads_sql.Find( "screen_id = 6 and data_view_id =" + string( al_view_id ) ,1, ads_sql.RowCount( ) )
		If ll_FRow > 0 Then
			ls_ScreenStyle = ads_sql.GetItemString( ll_FRow, 'screen_style' )
			IF appeongetclienttype() = 'PB' THEN
				If ls_ScreenStyle = 'G' Then
					ls_sql = f_get_screen_gridsql(al_view_id,6,false)  
				Else
					ls_sql = f_get_screen_sql(al_view_id,6,false)  
				End If
			ELSE
				If ls_ScreenStyle = 'G' Then
					ls_sql = ads_sql.GetItemString(ll_FRow,"grid_sql")
				Else
					ls_sql = ads_sql.GetItemString(ll_FRow,"dw_sql")
				End If
			END IF
			lds_Source.Create( ls_sql , ls_err )
			For ll_i = 1 To UpperBound( ls_Column1 )
				of_Get_object_Attribute( lds_Source, lds_Property, ls_Scol1[ll_i], ls_Column1[ll_i] )
			Next
			of_Set_ObjectPro( lds_target, lds_Property )
		End If
		
		ll_FRow = ads_sql.Find( "screen_id = 7 and data_view_id =" + string( al_view_id ) ,1, ads_sql.RowCount( ) )
		If ll_FRow > 0 Then
			ls_ScreenStyle = ads_sql.GetItemString( ll_FRow, 'screen_style' )
			IF appeongetclienttype() = 'PB' THEN
				If ls_ScreenStyle = 'G' Then
					ls_sql = f_get_screen_gridsql(al_view_id,7,false)  
				Else
					ls_sql = f_get_screen_sql(al_view_id,7,false)  
				End If
			ELSE
				If ls_ScreenStyle = 'G' Then
					ls_sql = ads_sql.GetItemString(ll_FRow,"grid_sql")
				Else
					ls_sql = ads_sql.GetItemString(ll_FRow,"dw_sql")
				End If
			END IF
			lds_Source.Create( ls_sql , ls_err )
			For ll_i = 1 To UpperBound( ls_Column1 )
				of_Get_object_Attribute( lds_Source, lds_Property, ls_Scol1[ll_i], ls_Column2[ll_i] )
			Next
			of_Set_ObjectPro( lds_target, lds_Property )
		End If
		If lds_target.Describe( 'CCCI_custom_n1.tag') = '1#' Then lds_target.Modify( "CCCI_custom_n1.tag=''")
		ls_SynTax= lds_target.Describe( "datawindow.syntax" )
	End If//
	
	If lds_target.Describe( 'feesched_custom_n1.tag') = '1#' Then //added by gavins 20120607
		ls_Column1 = {  'category', 'service_item' , 'description', 'fee', 'item_status','start_date','end_date','custom_int1', &
			'custom_int2', 'custom_fee1', 'custom_fee2', 'custom_fee3', 'custom_text1', 'custom_text2', 'custom_text3',&
			'billing_cycle', 'notes', 'custom_text4', 'custom_text5', 'custom_text6', 'custom_text7', 'custom_text8' , &
			'custom_n1', 'custom_n2', 'custom_n3', 'custom_n4','custom_n5','custom_date1', 'custom_date2', 'custom_date3',&
			'custom_date4', 'custom_date5' }
		ls_Scol1[] = ls_Column1
		ll_FRow = ads_sql.Find( "screen_id = 31 and data_view_id =" + string( al_view_id ) ,1, ads_sql.RowCount( ) )
		If ll_FRow > 0 Then
			ls_ScreenStyle = ads_sql.GetItemString( ll_FRow, 'screen_style' )
			IF appeongetclienttype() = 'PB' THEN
				If ls_ScreenStyle = 'G' Then
					ls_sql = f_get_screen_gridsql(al_view_id,31,false)  
				Else
					ls_sql = f_get_screen_sql(al_view_id,31,false)  
				End If
			ELSE
				If ls_ScreenStyle = 'G' Then
					ls_sql = ads_sql.GetItemString(ll_FRow,"grid_sql")
				Else
					ls_sql = ads_sql.GetItemString(ll_FRow,"dw_sql")
				End If
			END IF
			lds_Source.Create( ls_sql , ls_err )
			For ll_i = 1 To UpperBound( ls_Column1 )
				of_Get_object_Attribute( lds_Source, lds_Property, ls_Scol1[ll_i], 'feesched_' +ls_Column1[ll_i] )
				of_Get_object_Attribute( lds_Source, lds_Property, ls_Scol1[ll_i]+"_t", 'feesched_' +ls_Column1[ll_i] +"_t")
			Next
			of_Set_ObjectPro( lds_target, lds_Property )
		End If
		If lds_target.Describe( 'feesched_custom_n1.tag') = '1#' Then lds_target.Modify( "feesched_custom_n1.tag=''")
		ls_SynTax= lds_target.Describe( "datawindow.syntax" )		
	End If	
End If
If al_screen_id = 3 Or al_Screen_id = 1 Or al_Screen_id =2  Then
	lds_Source = Create DataStore
	lds_target = Create DataStore
	lds_target.Create( ls_Syntax, ls_err )
	
	ll_FRow = ads_sql.Find( "screen_id = " + string( al_screen_id ) + " and data_view_id =" + string( al_view_id ) ,1, ads_sql.RowCount( ) )
	If ll_FRow > 0 Then
		ls_ScreenStyle = ads_sql.GetItemString( ll_FRow, 'screen_style' )
		
		If ls_ScreenStyle = 'G' Then
			ls_dataObject = ads_sql.GetItemString(ll_FRow,"grid_dataobject")
		Else
			ls_dataObject = ads_sql.GetItemString(ll_FRow,"dataobject")
		END IF
		lds_Source.dataobject = ls_dataObject
		
		If lds_Source.Describe( "custom_status1.dddw.Name") <> lds_target.Describe(  "custom_status1.dddw.Name") Then
			lds_target.Modify(  "custom_status1.dddw.Name='" + lds_Source.Describe( "custom_status1.dddw.Name") + "'")
		End If
				
		If lds_Source.Describe( "custom_status1.tag") <> lds_target.Describe(  "custom_status1.tag") Then
			lds_target.Modify(  "custom_status1.tag='" + lds_Source.Describe( "custom_status1.tag") + "'")
		End If
	
		If lds_target.Describe( "custom_status1.dddw.DisplayColumn") ="" Then
			lds_target.Modify(  "custom_status1.dddw.DisplayColumn='" + lds_Source.Describe( "custom_status1.dddw.DisplayColumn") + "'")
		End If
			
		If lds_Source.Describe( "custom_status1.dddw.DataColumn") <> lds_target.Describe(  "custom_status1.dddw.DataColumn") Then
			lds_target.Modify(  "custom_status1.dddw.DataColumn='" + lds_Source.Describe( "custom_status1.dddw.DataColumn") + "'")
		End If
		If lds_Source.Describe( "custom_status2.dddw.Name") <> lds_target.Describe(  "custom_status2.dddw.Name") Then
			lds_target.Modify(  "custom_status2.dddw.Name='" + lds_Source.Describe( "custom_status2.dddw.Name") + "'")
		End If
				
		If lds_Source.Describe( "custom_status2.tag") <> lds_target.Describe(  "custom_status2.tag") Then
			lds_target.Modify(  "custom_status2.tag='" + lds_Source.Describe( "custom_status2.tag") + "'")
		End If
	
		If lds_target.Describe( "custom_status2.dddw.DisplayColumn") = "" Then
			lds_target.Modify(  "custom_status2.dddw.DisplayColumn='" + lds_Source.Describe( "custom_status2.dddw.DisplayColumn") + "'")
		End If
			
		If lds_Source.Describe( "custom_status2.dddw.DataColumn") <> lds_target.Describe(  "custom_status2.dddw.DataColumn") Then
			lds_target.Modify(  "custom_status2.dddw.DataColumn='" + lds_Source.Describe( "custom_status2.dddw.DataColumn") + "'")
		End If
		//added by gavins 20120613
		If al_screen_id = 3 Or al_Screen_id = 1   Then
			lds_target.modify( "custom_status2.dddw.useasborder = 'yes'   custom_status1.dddw.useasborder = 'yes' custom_status2.dddw.NilIsNull = 'yes' custom_status1.dddw.NilIsNull = 'yes'" )
		End If
		ls_SynTax= lds_target.Describe( "datawindow.syntax" )
	End If
	
End If//

If al_screen_id = 56 Then //added by gavins 20130205
	lds_Source = Create DataStore
	lds_target = Create DataStore
	lds_target.Create( ls_Syntax, ls_err )

	lds_Property = Create DataStore
	lds_Property.DataObject = "d_update_user_datawindow_objlist"
		
	ls_Scol1[] = { 'Custom_n1',  'Custom_n2' , 'Custom_n3', 'Custom_n4', 'Custom_n5', 'Custom_n6' , 'Custom_n7', 'Custom_n8', 'Custom_n9', 'Custom_n10', &
					'custom_1','custom_2', 'custom_3', 'custom_4', 'custom_5', 'custom_6', 'custom_7', 'custom_8', 'custom_9', 'custom_10', &
					'custom_date1', 'custom_date2', 'custom_date3', 'custom_date4', 'custom_date5', 'custom_date6' }
		
	If lds_target.Describe( 'Custom_n1.tag') = '1#'  Then
		ll_FRow = ads_sql.Find( "screen_id = 51 and data_view_id =" + string( al_view_id ) ,1, ads_sql.RowCount( ) )
		If ll_FRow > 0 Then
			ls_ScreenStyle = ads_sql.GetItemString( ll_FRow, 'screen_style' )
			IF appeongetclienttype() = 'PB' THEN
				If ls_ScreenStyle = 'G' Then
					ls_sql = f_get_screen_gridsql(al_view_id,51,false)  
				Else
					ls_sql = f_get_screen_sql(al_view_id,51,false)  
				End If
			ELSE
				If ls_ScreenStyle = 'G' Then
					ls_sql = ads_sql.GetItemString(ll_FRow,"grid_sql")
				Else
					ls_sql = ads_sql.GetItemString(ll_FRow,"dw_sql")
				End If
			END IF
			lds_Source.Create( ls_sql , ls_err )
			For ll_i = 1 To UpperBound( ls_Scol1 )
				If abs( Long( lds_Source.describe( ls_Scol1[ll_i] + ".visible" ) ) ) = 1 Then of_Get_object_Attribute( lds_Source, lds_Property, ls_Scol1[ll_i], ls_Scol1[ll_i] )
			Next
			of_Set_ObjectPro( lds_target, lds_Property )
		End If
		
		ll_FRow = ads_sql.Find( "screen_id =52 and data_view_id =" + string( al_view_id ) ,1, ads_sql.RowCount( ) )
		If ll_FRow > 0 Then
			ls_ScreenStyle = ads_sql.GetItemString( ll_FRow, 'screen_style' )
			IF appeongetclienttype() = 'PB' THEN
				If ls_ScreenStyle = 'G' Then
					ls_sql = f_get_screen_gridsql(al_view_id,52,false)  
				Else
					ls_sql = f_get_screen_sql(al_view_id,52,false)  
				End If
			ELSE
				If ls_ScreenStyle = 'G' Then
					ls_sql = ads_sql.GetItemString(ll_FRow,"grid_sql")
				Else
					ls_sql = ads_sql.GetItemString(ll_FRow,"dw_sql")
				End If
			END IF
			lds_Source.Create( ls_sql , ls_err )
			For ll_i = 1 To UpperBound( ls_Scol1 )
				If abs( Long( lds_Source.describe( ls_Scol1[ll_i] + ".visible" ) ) ) = 1 Then of_Get_object_Attribute( lds_Source, lds_Property, ls_Scol1[ll_i], ls_Scol1[ll_i] )
			Next
			of_Set_ObjectPro( lds_target, lds_Property )
		End If
		If lds_target.Describe( 'Custom_n1.tag') = '1#' Then lds_target.Modify( "Custom_n1.tag=''")
		ls_SynTax= lds_target.Describe( "datawindow.syntax" )
	End If//
End If




If isvalid(lds_target) Then Destroy lds_target
If isvalid(lds_Property) Then Destroy lds_Property
If isvalid(lds_Source) Then Destroy lds_Source


return ls_SynTax






//modified by gavins 20120314  grid   beacuse  the contract browser had not had the graph

//only support screen_id = 2
//if al_screen_id = 2 then
//	ll_pos = Pos(ls_SynTax,"processing=1")
//	IF ll_pos > 0 THEN
//		ls_SynTax = Left(ls_SynTax,ll_pos - 1) + "processing=0" + Mid(ls_SynTax, ll_pos + 12)
//		li_Processing = 1
//	END IF
//
//	lds_target = create datastore
//	lds_target.Create(ls_SynTax, ls_Err)
//	lds_target.SetTransObject(SQLCA)	
//	
//	ls_ObjName = lds_target.describe( "p_1.name")
//	if ls_ObjName = '?' or ls_ObjName = '!' then 		
//		ls_tObjects  = lds_target.Describe("DataWindow.Objects")
//		ll_tObjcount = inv_string.of_parsetoarray(ls_tObjects,'~t',ls_tObjectlist)
//		
//		for ll_i = 1 to ll_tObjcount
//			ls_ObjName = ls_tObjectlist[ll_i]
//			ls_band = lds_target.Describe(ls_ObjName +".Band")
//			if lower(ls_band) = "detail" or lower(ls_band) = "header" then 
//				ls_Modify = ls_Modify + " " + ls_ObjName + ".x=" + string(Long(lds_target.Describe(ls_ObjName +".X")) + 92)
//			end if
//		next
//		
//		ls_Err = lds_target.modify( ls_Modify)		
//	end if
//	ls_SynTax = lds_target.Describe("DataWindow.Syntax")
//	destroy lds_target
//	
//end if



end function

public function integer of_get_object_attribute (datastore ids_terget, ref datastore ids_properties, string as_sobjname, string as_tobjname);Integer i,li_objcount

String ls_colpro[],ls_DwPro[]
String ls_proname, ls_provalue
Integer j, li_colcount,li_DwProCount
Integer li_insert
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-10-24 By: Andy
Integer li_txtcount
String  ls_band,ls_txtpro[],ls_type

//<Modify> 12.14.2007 by: Andy
//Reason:Add "Band","Footer.Height","Summary.Height","Header.Height"
//Add Font.face,Font.strikethrough,font.heigth - jervis 09.06.2011                    "x","y","width","height","visible",
ls_txtpro = {"Font.face","Font.strikethrough","font.heigth","Font.Italic","Font.Underline","Font.Weight","text","alignment","Color","Background.Mode","Background.Color","border"}//<modify> 05.26.2008 by Andy  del:,"tag"
li_txtcount = UpperBound(ls_txtpro)
ls_type = ids_terget.Describe(as_sobjname + ".type")
//ls_band = ids_terget.Describe(as_objname +".Band")
//---------------------------- APPEON END ----------------------------

//Delete Font.face - jervis 01.13.2011
//Init update properties
//Add ddlb.VScrollBar,edit.VScrollBar,edit.format,format,ddlb.AutoHScroll,SlideUp,Height.AutoSize -- jervis 04.21.2011
//Add Font.face,Font.strikethrough,font.heigth - jervis 09.06.2011                            "x","y","width","height","visible",
ls_colpro = {"Font.face","Font.strikethrough","font.heigth","Font.Italic","Font.Underline","Font.Weight","alignment",&
"Edit.Required","dddw.Required","ddlb.Required","EditMask.Required","Edit.Case","DDLB.Case","EditMask.Mask","edit.displayonly","edit.AutoHScroll","edit.NilIsNull",&
"dddw.VscrollBar","dddw.AutoHScroll","dddw.useasborder","dddw.NilIsNull","dddw.name","dddw.datacolumn","dddw.displaycolumn","dddw.PercentWidth","tag",&
"border","Color","Background.Mode","Background.Color","ddlb.VScrollBar","edit.VScrollBar","edit.format","format","ddlb.AutoHScroll","SlideUp","Height.AutoSize",&
"checkbox.3d","checkbox.lefttext","checkbox.off","checkbox.on","checkbox.other","checkbox.scale","checkbox.text"}//,"protect""tabsequence""Initial",

//ls_DwPro = {"Detail.Height","Table.Sort"}

//add Detail.Height.AutoSize -- jervis 04.21.2011
//ls_DwPro = {"Detail.Height","Table.Sort","Footer.Height","Summary.Height","Header.Height","Color","Detail.Height.AutoSize"}//"DataWindow.Color"}//modified by nova  2008/09/17 //Modify by Evan 07.21.2008, add DataWindow.Color property
//end of modify
li_colcount = UpperBound(ls_colpro)
li_DwProCount = UpperBound(ls_DwPro)

//modify 10/24/2007 by: Andy
//if ids_terget.Describe(as_objname + ".type") = "column" then
if lower(ls_type) = "column" then
	For j = 1 To li_colcount
		ls_proname = ls_colpro[j]
		ls_provalue = ids_terget.Describe(as_sobjname+"."+ls_proname)
		if isnull(ls_provalue) then ls_provalue = "!"
		Choose Case ls_provalue
			Case "!","?"
				Continue
			Case Else
				//Start Code By Jervis 03.11.2008
				//Fixed Bug,Expressions involving Null values may arrive at different values in JavaScript 
				//from their values in PowerScript
				//if isnull(ls_provalue) then continue
				//if ls_proname = 'Initial' and ls_provalue = 'null' then setnull(ls_provalue)
				//End Code By Jervis 03.11.2008
				li_insert = ids_properties.InsertRow(0)
				ids_properties.Object.obj_name[li_insert] = as_tobjname
				ids_properties.Object.obj_pro[li_insert] = ls_proname
				ids_properties.Object.obj_value[li_insert] = ls_provalue
		End Choose
	Next
elseif lower(ls_type) = "text" then
	For j = 1 To li_txtcount
		ls_proname = ls_txtpro[j]
		ls_provalue = ids_terget.Describe(as_sobjname+"."+ls_proname)
		if isnull(ls_provalue) then ls_provalue = "!"
		Choose Case ls_provalue
			Case "!","?"
				Continue
			Case Else
				li_insert = ids_properties.InsertRow(0)
				ids_properties.Object.obj_name[li_insert] = as_tobjname
				ids_properties.Object.obj_pro[li_insert] = ls_proname
				ids_properties.Object.obj_value[li_insert] = ls_provalue
		End Choose
	Next
end if


Return 1
end function

public function integer of_appeon2_changes (long al_view_id, long al_screen_id, ref string as_sql, string as_dataobject, datastore ads_screen);//////////////////////////////////////////////////////////////////// //
// $<function>n_cst_contract_sqlof_asa_6_changes()
// $<arguments> Boolean ab_force_update
// $<returns> (none)
// $<description>Contract module modification
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 08.09.2006 by Liang QingShi
//////////////////////////////////////////////////////////////////////
Integer i,li_num,li_rowcount,li_row
String ls_tab_name[],ls_screen_name[],ls_dw_name[],ls_dataobject[]
String ls_sql,ls_error_create
n_cst_datastore lds_sql
n_cst_datastore lds_source,lds_target,lds_properties
Long ll_count , ll_find
Boolean lb_update_falg
Long ll_view_id,ll_screen_id
String ls_dataobject1
DateTime ldt_modify_date
String   ls_ForceUpdates[]
String ls_ForceUpdates1001[] //only for default view
string 	ls_ForceUpdates_screen
String   ls_text
String   ls_Error
str_dwsyntax lstr_syntax[]	//jervis 05.19.2011
/*******************************///added by gainvs 20120305 required grid
String		ls_GridDataObject[], ls_ScreenStyle[], ls_NeedModify[]
Boolean	lb_GridExists
Integer	li_k, li_Cycle
String		ls_GridSQL, ls_TargetSyntax
Boolean	lb_NewUpgrade
/*******************************/

lb_update_falg = True
lds_source = Create n_cst_datastore
lds_sql = Create n_cst_datastore
lds_target = Create n_cst_datastore
lds_properties = Create n_cst_datastore

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05.28.2008 by Andy
ls_ForceUpdates[al_Screen_ID] = ''
ls_ForceUpdates[1]  = "category.dddw.name='d_dddw_user_access_category' app_facility.tabsequence=32766 app_facility.x='3803' app_facility.y='68' app_facility.height='60' app_facility.width='594' app_facility.visible='0' app_facility_t.x='3803' app_facility_t.y='12' app_facility_t.height='52' app_facility_t.width='489' app_facility_t.visible='0' facility_name_t.visible='1' facility_name.visible='1' facility_name.dddw.name='dddw_contact_company_search' facility_name.dddw.displaycolumn='facility_name' facility_name.dddw.datacolumn='facility_name' facility_name.dddw.percentwidth=200 b_clear.visible='1' b_more.visible='1' "   + &
" ctx_id.dddw.name='d_dddw_ctx_ids' ctx_id.dddw.displaycolumn='ctx_id' ctx_id.dddw.datacolumn='ctx_id' ctx_id.dddw.percentwidth=150  ctx_id.dddw.allowedit=yes ctx_id.dddw.useasborder=yes  ctx_id.dddw.nilisnull=yes ctx_id.dddw.hscrollbar=yes ctx_id.dddw.vscrollbar=yes ctx_id.dddw.autoretrieve=no" //added by gavins 20130426
//ls_ForceUpdates[2]  = "p_2.visible=~"1~~tif( style ='-' and  master_cnt  >0,1,0) ~" p_1.visible=~"1~~tif( style ='+' and  master_cnt  >0,1,0) ~" "
ls_ForceUpdates[2]  = 'p_2.visible="0" p_1.visible="0"  '
ls_ForceUpdates[6]  = "contact_phone.format='[general]' contact_phone.edit.limit=0 contact_phone.edit.case=any contact_phone.edit.focusrectangle=no contact_phone.edit.autoselect=no contact_phone.edit.imemode=0 "
ls_ForceUpdates[7]  = "contact_type.visible = 0 contact_type_t.visible = 0 association.Visible = 1 association_t.Visible = 1 contact_phone.format='[general]' contact_phone.edit.limit=0 contact_phone.edit.case=any contact_phone.edit.focusrectangle=no contact_phone.edit.autoselect=no contact_phone.edit.imemode=0 "
ls_ForceUpdates[8]  = "notes.edit.autohscroll=no " 			//Alfee 06.17.2008
//---------Begin Modified by (Appeon)Harry 01.13.2014 for Bug# 3824--------
//ls_ForceUpdates[11] = "rqmnt_name.DDDW.UseAsBorder='no' destroy b_add "	//Added by Scofield on 2009-06-23
ls_ForceUpdates[11] = "rqmnt_name.dddw.datacolumn='rqmnt_name' rqmnt_name.DDDW.UseAsBorder='no' destroy b_add "	//Added by Scofield on 2009-06-23
//---------End Modfiied ------------------------------------------------------
ls_ForceUpdates[12] = "category_name_t.visible = '0' gb_1.background.mode='1' gb_1.background.color='553648127' p_1.visible=~"1~~tif( value_type =  5,1,0)~" "
ls_ForceUpdates[13] = "gb_1.background.mode='1' gb_1.background.color='553648127' t_1.visible='0' DataWindow.Detail.Height='118' DataWindow.Detail.Height.AutoSize='No' clause.visible = '0' b_1.visible = '0' category_name.visible='1' t_2.visible='0' p_1.visible=~"1~~tif( value_type =  5,1,0)~" "
ls_ForceUpdates[15] = "app_facility_street_1.visible='1' app_facility_street_2.visible='1' app_facility_street_3.visible='1' app_facility_city.visible='1' app_facility_state.visible='1' app_facility_zip.visible='1' ctx_contacts_street_1.visible='0' ctx_contacts_street_2.visible='0' ctx_contacts_street_3.visible='0' ctx_contacts_city.visible='0' ctx_contacts_state.visible='0' ctx_contacts_zip.visible='0' ctx_contacts_state_t.visible='0' ctx_contacts_state_t.x='1065'  ctx_contacts_state_t.y='1148' ctx_contacts_zip_t.visible='0' ctx_contacts_zip_t.x='1669' ctx_contacts_zip_t.y='1148' app_facility_state_t.visible='1'  app_facility_zip_t.visible='1' "
ls_ForceUpdates[16] = "phone.format='[general]' phone.edit.limit=0 phone.edit.case=any phone.edit.focusrectangle=no phone.edit.autoselect=no phone.edit.imemode=0 "
ls_ForceUpdates[25] = "phone.format='[general]' phone.edit.limit=0 phone.edit.case=any phone.edit.focusrectangle=no phone.edit.autoselect=no phone.edit.imemode=0 "
ls_ForceUpdates[27] = "location.tag='Contract Local Code' location.dddw.name='d_dddw_location' location.dddw.displaycolumn='local1' location.dddw.datacolumn='local' "
//---------Begin Modified by (Appeon)Harry 02.20.2014 for V142 ISG-CLX--------
//ls_ForceUpdates[32] = "b_close.Visible = 1"
//ls_ForceUpdates[32] = "b_close.Visible = 1 doc_type.dddw.useasborder=yes doc_type.tag='Contract Document Type' doc_type.dddw.name='d_dddw_code_lookup_doc_type' doc_type.dddw.displaycolumn='code' doc_type.dddw.datacolumn='code' doc_type.dddw.percentwidth=200 doc_type.dddw.lines=20 doc_type.dddw.vscrollbar=yes doc_type.dddw.allowedit=yes"  //(Appeon)Alfee 01.21.2014 - V142 ISG-CLX
ls_ForceUpdates[32] = "b_close.Visible = 1 doc_type.dddw.name='d_dddw_code_lookup' doc_type.dddw.displaycolumn='code' doc_type.dddw.datacolumn='code' doc_type.dddw.percentwidth=200 doc_type.dddw.vscrollbar=yes doc_type.dddw.AllowEdit=yes doc_type.dddw.NilIsNull=yes doc_type.dddw.useasborder=yes doc_type.Initial='' doc_type.Tag='Contract Document Type' "
//---------End Modfiied ------------------------------------------------------
ls_ForceUpdates[33] = "compute_1.Expression=~"wordcap(if( isnull(document_name), if(len(alm_action_title) >0, alm_action_title, action_description) , left(document_name,len( document_name ) - 4)  + ' - ' +  if(len(alm_action_title) >0, alm_action_title, action_description) ))~" action_type.dddw.name='d_dddw_code_lookup' action_type.dddw.displaycolumn='custom_1' action_type.dddw.datacolumn='lookup_code' action_type.dddw.percentwidth=275 "
ls_ForceUpdates[43] = "p_2.visible=~"1~~tif( style ='-' and  master_cnt  >0,1,0) ~" p_1.visible=~"1~~tif( style ='+' and  master_cnt  >0,1,0) ~" "
ls_ForceUpdates[45] = "DataWindow.Detail.Height='248' b_close.Visible = 1"						//Added by Scofield on 2010-03-30
ls_ForceUpdates[46] = "wf_assigned_by.visible='1' wf_assigned_by_t.visible='1' " //Add by Evan on 03.31.2008
ls_ForceUpdates[47] = "b_print.visible=~"1~~tif(active_status < 0 or readonly_flag = 1,0,if(wf_id > 0 and print_flag < 1 and f_get_gb_workflow(),0,if((wf_id <= 0 or Not f_get_gb_workflow()) and (isnull(code_lookup_custom_6) or trim(code_lookup_custom_6) = ~~~"~~~" ),0,1)))~" b_notes.visible=~"1~~tif(active_status < 0,0,1)~" " //Delete " or  readonly_flag = 1 or wf_complete_flag = 'Y'" - jervis 02.21.2011
ls_ForceUpdates[48] = "b_close.Visible = '1' b_me.Visible = '1'"
ls_ForceUpdates[51] = "DataWindow.Table.UpdateWhere='0' " //(Appeon)Harry 09.14.2015 - Bug id 4711
ls_ForceUpdates[52] = "doc_type.tag='Contract Document Type' doc_type.dddw.name='d_dddw_code_lookup_doc_type' doc_type.dddw.displaycolumn='code' doc_type.dddw.datacolumn='code' doc_type.dddw.percentwidth=300 doc_type.dddw.lines=20 doc_type.dddw.vscrollbar=yes DataWindow.Table.UpdateWhere='0' " //Added By Ken.Guo 2011-04-01.  //(Appeon)Harry 08.01.2014 add  DataWindow.Table.UpdateWhere='0' 

//---------------------------- APPEON END ----------------------------

//Added By Ken.Guo 12/15/2011. only for default view 1001
ls_ForceUpdates1001[al_Screen_ID ] = '' 
ls_ForceUpdates1001[2] = 'object_related.visible = "1" '

lds_properties.DataObject = "d_update_user_datawindow_objlist"

//end of modify 03.12.2008

ls_SQL = as_sql
	
lds_source.dataobject = as_dataobject
lds_source.settransobject(sqlca)

ads_screen.SetFilter( "" )
ads_screen.Filter( )

ls_TargetSyntax = ls_sql
lds_target.Create(ls_sql, ls_error_create)
If Len( ls_error_create ) > 0 Then
	MessageBox( 'Tips', ls_error_create )
	gnv_debug.of_output( true, 'Restore screen history is failure, syntax=' + ls_sql + ', error=' + ls_error_create  )
	Return -1
End If
lds_target.SetTransObject(sqlca)
lds_properties.Reset()


If al_view_id = 1001 and ls_ForceUpdates1001[al_Screen_ID ] <> '' Then
	ls_ForceUpdates_screen	= ls_ForceUpdates[al_Screen_ID] + ' '+ ls_ForceUpdates1001[al_Screen_ID] +	of_get_update_ai(lds_target, as_dataobject )		
Else
	ls_ForceUpdates_screen	= ls_ForceUpdates[al_Screen_ID] + 	of_get_update_ai(lds_target, as_dataobject )		
End If

lb_NewUpgrade =False//modified by gavins 201209225
ii_Screen_ID = al_Screen_ID//added by gavins 20130423
If of_update_changeobject( lds_source, lds_target,lds_properties,ls_ForceUpdates_screen)  < 0 Then
	of_update_object(lds_target,lds_source,lds_properties,ls_ForceUpdates_screen)
	lb_NewUpgrade = True
End If

//Added By Ken.Guo 2009-10-10. force update date alarm button's size.
This.of_force_update_button(lds_source,al_Screen_ID )			
//Added By mark lee 04/10/12
This.of_force_update_button_once(lds_source,al_Screen_ID )		

//$<add> 03.19.2008 by Andy
ls_sql = of_post_update(lds_source,al_Screen_ID)
//end of add 03.19.2008


ls_sql = of_special_update(ls_sql,al_screen_id,  ads_screen, al_view_id  )

//UPdate the clcus fields in custom tab by fee(NM) - jervis 07.22.2010
if as_dataobject = "d_contract_fee_sched_nm" and  ib_init_fee then
	lds_source.SetTransObject(sqlca)
	this.of_update_fee_calc( al_view_id, 0, lds_source, is_cacls)
end if

If lb_NewUpgrade Then of_arrageobject( ls_sql, ls_TargetSyntax )//added by gavins 20120601  modified by gavins 201209225

as_sql = ls_sql

Destroy lds_sql
Destroy lds_source
Destroy lds_target
Destroy lds_properties

Return 1

end function

public function integer of_force_update_button_once (ref datastore ads_source, integer ai_screen_index);//====================================================================
// Function: of_force_update_button_once
//--------------------------------------------------------------------
// Description: force update datawindow in the 1 and 3 srceen for the [...] button in the first time 
//--------------------------------------------------------------------
// Arguments:
//                ads_source
//                ai_screen_index
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	mark lee		Date: 04/10/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:  Copied from CLX 12 and modified by (Appeon)Alfee 01.21.2014 - V142 ISG-CLX
// 		
//====================================================================
String 		ls_main_version,	ls_patch_version,	ls_screen_version,	ls_Modify, ls_err, ls_Column_Name, ls_objects
Long			ll_x, ll_y, ll_width
String 		ls_modify_tmp

Integer li_main_version
Select set_18,set_patch_ver,screen_version Into :li_main_version, :ls_patch_version, :ls_screen_version From icred_settings;
If li_main_version > 141 or ( li_main_version = 141 and ls_patch_version >= '002') Then
	//Return  0  //Commented by (Appeon)Alfee 01.21.2014 - V142 ISG-CLX
Else

	Choose Case ai_screen_index
		Case 1
			//d_contract_search
				ls_Column_Name	=	"facility_name"
		Case 3 
			//d_contract_det_master 
				ls_Column_Name	=	"app_facility"
	End Choose 
	
	If NOT isnull(ls_Column_Name) And trim(ls_Column_Name) <> '' Then 
		//Modified By Mark Lee 05/02/12 
	//	ll_x	= Long(ads_source.describe( ls_Column_Name+".x")) + Long(ads_source.describe( ls_Column_Name+".width")) + 10
		ll_x	= Long(ads_source.describe( ls_Column_Name+".x")) + Long(ads_source.describe( ls_Column_Name+".width")) + 10 - 69
		ll_y	= Long(ads_source.describe( ls_Column_Name+".y")) - 8
	
		ls_objects	=	ads_source.Describe("Datawindow.objects")
		If Pos(ls_objects,"b_"+ls_Column_Name+"_dotdd_company")  > 0 Then
			ls_Modify = " b_"+ls_Column_Name+"_dotdd_company.visible='1' b_"+ls_Column_Name+"_dotdd_company.x='"+string(ll_x)+"' b_"+ls_Column_Name+"_dotdd_company.y='"+string(ll_y)+"'"
		Else
			ls_Modify = " create button(band=detail text='...' enabled=yes action='0' border='0' color='0' x='"+string(ll_x)+"' y='"+string(ll_y)+"' height='76' width='69' " +&
							" vtextalign='0' htextalign='0'  name=b_"+ls_Column_Name+"_dotdd_company visible='1'  font.face='Segoe UI' font.height='-8' font.weight='400'  " + &
							" font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='67108864' background.transparency='0' background.gradient.color='8421504'" + &
							" background.gradient.transparency='0' background.gradient.angle='0' background.brushmode='0' background.gradient.repetition.mode='0' background.gradient.repetition.count='0' " + & 
							" background.gradient.repetition.length='100' background.gradient.focus='0' background.gradient.scale='100' background.gradient.spread='100' tooltip.backcolor='134217752' " + & 
							" tooltip.delay.initial='0' tooltip.delay.visible='32000' tooltip.enabled='0' tooltip.hasclosebutton='0' tooltip.icon='0' tooltip.isbubble='0' tooltip.maxwidth='0' " + &
							" tooltip.textcolor='134217751' tooltip.transparency='0' transparency='0' ) "		
		End If 					
		ls_err =  ads_source.modify( ls_Modify)
		//Modified By Mark Lee 05/02/12
		ls_modify_tmp = ls_Column_Name + ".width="+String( Long(ads_source.describe( ls_Column_Name+".width")) -69 ) 				
		ls_err =  ads_source.modify( ls_modify_tmp)
	
	End IF
End If
//End - Added By Mark Lee 11/05/2012

//Added By Mark Lee 11/05/2012
//If (ls_main_version < '120') or ( ls_main_version = '120' and ls_patch_version <= '017'  and ls_screen_version <= '0065' ) Then
If (ls_main_version < gs_current_version) or ( ls_main_version = gs_current_version and ls_patch_version <= '002'  and ls_screen_version <= '0074' ) Then  //(Appeon)Alfee 01.21.2014 - V142 ISG-CLX	
	//d_contract_search
	If ai_screen_index =  1 Then 
		//---------Begin Modified by (Appeon)Harry 09.01.2014 for BugH062402 in V14.2 Issues of Integration.doc--------
		/*
		ll_x = Long(ads_source.describe( "b_more.x"))
 		ll_y = Long(ads_source.describe( "b_more.y"))
		 ll_width = Long(ads_source.describe( "b_more.width"))
		ls_Modify += " b_quick_filter1.y ="+string(ll_y) +" b_quick_filter1.x ="+string(ll_x + ll_width + 41 ) + " b_quick_filter1.visible = '1'  b_quick_filter1.height = 80 b_quick_filter1.width = 430"
		ls_Modify += " b_quick_filter2.y ="+string(ll_y) +" b_quick_filter2.x ="+string(ll_x + ll_width + 41 + 430 + 114 ) + " b_quick_filter2.visible = '1'  b_quick_filter2.height = 80 b_quick_filter2.width = 430"
		ls_Modify += " b_quick_filter3.y ="+string(ll_y) +" b_quick_filter3.x ="+string(ll_x + ll_width + 41 + 430 + 114 + 430 + 114 ) + " b_quick_filter3.visible = '1'  b_quick_filter3.height = 80 b_quick_filter3.width = 430"
		*/
		ll_x = Long(ads_source.describe( "b_clear.x"))
 		ll_y = Long(ads_source.describe( "b_clear.y"))
		ll_width = Long(ads_source.describe( "b_clear.width"))
		ls_Modify += " b_quick_filter3.y ="+string(ll_y) +" b_quick_filter3.x ="+string(ll_x - 430 - 41 - 114) + " b_quick_filter3.visible = '1'  b_quick_filter3.height = 80 b_quick_filter3.width = 430"
		ls_Modify += " b_quick_filter2.y ="+string(ll_y) +" b_quick_filter2.x ="+string(ll_x - 430 - 41 - 114 - 430 - 114) + " b_quick_filter2.visible = '1'  b_quick_filter2.height = 80 b_quick_filter2.width = 430"
		ls_Modify += " b_quick_filter1.y ="+string(ll_y) +" b_quick_filter1.x ="+string(ll_x - 430 - 41 - 114 - 430 - 114 - 430 - 114) + " b_quick_filter1.visible = '1'  b_quick_filter1.height = 80 b_quick_filter1.width = 430"
		//---------End Modfiied ------------------------------------------------------
		
		ls_err =  ads_source.modify( ls_Modify)
		
		//Destroy button b_save_filter
		ls_err = ads_source.describe("b_save_filter.type")
		If not isnull(ls_err)  and  ls_err = 'button'  Then 
			ls_err =  ads_source.modify( " Destroy  b_save_filter ")
		End If
	End If
End If

return 1
end function

public function string of_get_dw_original_syntax (string as_class, integer ai_data_view_id, integer ai_screen_id);//====================================================================
// Function: of_get_dw_original_syntax
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	as_class
// 	ai_data_view_id
// 	ai_screen_id
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	gavin		Date: 2012-05-21
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


//Get ctx_screen_original    syntax  

Long ll_data_length
Integer li_counter
Integer li_loops
String ls_sql
String ls_all_sql
Long ll_start

// Get file data from database
If as_Class = 'free' Then
	SELECT Datalength(dw_sql)
	INTO :ll_data_length
	FROM ctx_screen_original
	WHERE data_view_id = :ai_data_view_id
	AND screen_id = :ai_screen_id;
else
	SELECT Datalength(grid_sql)
	INTO :ll_data_length
	FROM ctx_screen_original
	WHERE data_view_id = :ai_data_view_id
	AND screen_id = :ai_screen_id;
end if

IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
	Messagebox("Get sql error","Failed to get datawindow syntax from DB, Please report this to support.")
	RETURN ''
END IF

IF ll_data_length > 8000 THEN 
  	 IF Mod(ll_data_length,8000) = 0 THEN 
        li_loops = ll_data_length/8000 
    ELSE 
  	     li_loops = (ll_data_length/8000) + 1 
    END IF 
ELSE 
  	 li_loops = 1 
END IF 

FOR li_counter = 1 to li_loops
	ll_start = (li_counter - 1) * 8000 + 1
	if as_class = 'free' then
		SELECT substring(dw_sql,:ll_start,8000)
		INTO :ls_sql
		FROM ctx_screen_original 
		WHERE data_view_id = :ai_data_view_id 
		AND screen_id = :ai_screen_id;
	else
		SELECT substring(grid_sql,:ll_start,8000)
		INTO :ls_sql
		FROM ctx_screen_original 
		WHERE data_view_id = :ai_data_view_id 
		AND screen_id = :ai_screen_id;
	end if

	ls_all_sql += ls_sql
NEXT 

If not len(ls_all_sql) > 0 Then
	Messagebox("Get sql error 1","Failed to get datawindow syntax from DB, Please report this to support.")
End If
Return ls_all_sql
end function

public function integer of_modify_attribute (datastore ads_ds, string as_attribute);//====================================================================
// Function: of_modify_attribute
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	ads_ds
// 	as_attribute
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	gavin		Date: 2012-05-22
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long					ll_i, ll_sObjcount
String					ls_Objects[], ls_Object, ls_Modify, ls_Type, ls_err, ls_role
n_cst_String			ln_string


ls_Object  = ads_ds.Describe("DataWindow.Objects")
ll_sObjcount = ln_string.of_parsetoarray(ls_Object,'~t',ls_Objects)

ls_Modify = ""
as_attribute = ".accessiblerole=0"

For ll_i = 1 To ll_sObjcount
	ls_Type =  ads_ds.Describe( ls_Objects[ ll_i ] + ".type" )
	
	If  Lower( ls_Type ) = 'line' or  Lower( ls_Type ) = 'ellipse' or  Lower( ls_Type ) = 'rectangle' or  Lower( ls_Type ) = 'roundrectangle' or ls_Type = '!'  or ls_Type = '?' Then Continue
	ls_role = ads_ds.Describe( ls_Objects[ ll_i ] + ".accessiblerole" )
	If ls_Role = '!' or ls_Role = '?' or Trim( ls_role ) = '' then Continue
	ls_Modify += " " + ls_Objects[ ll_i ] + as_attribute
	
	If  Mod( ll_i, 10 ) = 0  Then
		ls_err = ads_ds.Modify( ls_Modify )
		ls_Modify = ""
	End If
	
Next

If len( ls_Modify ) > 0 Then  ads_ds.Modify( ls_Modify )







Return   1
end function

public function integer of_get_upgrade_dw (string as_freeobject[], string as_gridobject[], boolean ab_forceupdate, ref boolean ab_update[], ref n_ds ads_original, ref string as_freesyntax[], ref string as_gridsyntax[]);//====================================================================
// Function: of_get_upgrade_dw
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	as_freeobject[]
// 	as_gridobject[]
// 	ab_forceupdate
// 	ab_update[]
// 	ads_original
// as_gridsyntax
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	gavin		Date: 2012-05-21
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:20120529
//
//====================================================================

//compare   dataobject and table original syntax
n_ds					lds_Syntax
Integer				li_i, li_ViewID, li_ScreenID
Integer				li_Find, li_Row,li_num
String					ls_DBFreeSyntax, ls_DBGridSyntax
String					ls_FreeSyntax, ls_GridSyntax
String					ls_PB

ads_Original = Create n_ds
ads_Original.DataObject = 'd_update_screen_original'
ads_Original.SetTransObject( SQLCA )
If ads_Original.Retrieve( ) = -1 Then Return -1

lds_Syntax = Create n_ds

li_ViewID = 1001
ab_Update[ UpperBound (as_freeobject) ] =  FALSE
as_freesyntax[ UpperBound (as_freeobject) ] = ""
as_gridsyntax[ UpperBound (as_freeobject) ] = ""
ls_PB =  Upper( appeongetclienttype() ) //get client type


/**********************************************/
li_num = UpperBound(as_freeobject)
IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
IF IsValid(w_infodisp) THEN w_infodisp.Title = 'Check screen of view'
IF IsValid(w_infodisp) THEN w_infodisp.Center = True
IF IsValid(w_infodisp) THEN w_infodisp.st_complete.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_3.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_information.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'Check screen of view, Please stand by!'
IF IsValid(w_infodisp) THEN w_infodisp.wf_set_min_max(1,li_num)
/**********************************************/

For li_i =1  To li_num
	IF IsValid(w_infodisp) THEN
		w_infodisp.wf_step_pbar(1)
		w_infodisp.st_1.Text = 'Modification ' + String( li_i ) + ' of ' + String(li_num)+', Please stand by!'
	END IF
	ls_FreeSyntax = ""
	ls_GridSyntax = ""
	ls_DBFreeSyntax = ""
	ls_DBGridSyntax = ""
	If Len(  as_freeobject[ li_i ]  ) > 0 Then 
		lds_Syntax.DataObject = as_freeobject[ li_i ] 
		If ls_PB <> 'PB' Then This.of_Modify_attribute( lds_syntax, "" ) 
		ls_FreeSyntax = lds_Syntax.Describe( "datawindow.syntax" )
		If IsNull( ls_FreeSyntax ) Or ls_FreeSyntax = "" Or ls_FreeSyntax = "?" Or ls_FreeSyntax = "!" Then
			MessageBox( 'Tips', 'Failed to get datawindow syntax! at screen id ' + String( li_i ) )
			Continue
		End If
	End If
	If len( as_GridObject[ li_i ] ) > 0 Then
		lds_Syntax.DataObject = as_GridObject[ li_i ] 
		If ls_PB <> 'PB' Then This.of_Modify_attribute( lds_syntax, "" ) 
		ls_GridSyntax = lds_Syntax.Describe( "datawindow.syntax" )
		If IsNull( ls_GridSyntax ) Or ls_GridSyntax = "" Or ls_GridSyntax = "?" Or ls_GridSyntax = "!" Then
			MessageBox( 'Tips', 'Failed to get datawindow syntax! at screen id ' + String( li_i ) )
			Continue
		End If
	End If
	
	li_Find = ads_Original.Find( "data_view_id = " + string(li_ViewID) + " and screen_id =" + string(li_i)  , 1, ads_Original.RowCount( ) )
	If li_Find = 0 Then
		li_Row = ads_Original.InsertRow( 0 ) 
		ads_Original.SetItem( li_Row, 'data_view_id', li_viewID )
		ads_Original.SetItem( li_Row, 'screen_id', li_i )
//		ads_Original.SetItem( li_Row, 'dw_sql', ls_FreeSyntax )		
//		ads_Original.SetItem( li_Row, 'grid_sql', ls_GridSyntax )
		as_gridsyntax[li_i] = ls_gridSyntax
		as_freesyntax[li_i] = ls_FreeSyntax
		ads_Original.SetItem( li_Row, 'modifydate', datetime( today(), now() ) )
		ab_update[li_i] = True
	ElseIf li_Find > 0 Then
		If ab_ForceUpdate Then 
//			ads_Original.SetItem( li_Find, 'dw_sql', ls_FreeSyntax )
//			ads_Original.SetItem( li_Find, 'grid_sql', ls_GridSyntax )
			as_gridsyntax[li_i] = ls_gridSyntax
			as_freesyntax[li_i] = ls_FreeSyntax
			ads_Original.SetItem( li_Find, 'pre_modifydate', ads_Original.GetItemDateTime( li_Find,'modifydate' ) )
			ads_Original.SetItem( li_Find, 'modifydate', datetime( today(), now() ) )
			ab_Update[ li_i ] = True
			Continue
		End If
		IF ls_PB = 'PB' THEN
			If Len(  as_freeobject[ li_i ]  ) > 0 Then  ls_DBFreeSyntax = of_Get_DW_Original_Syntax( "free", li_ViewID, li_i )
			If Len(  as_GridObject[ li_i ]  ) > 0 Then  ls_DBGridSyntax = of_Get_DW_Original_Syntax( "grid", li_ViewID, li_i )		
		Else
			If Len(  as_freeobject[ li_i ]  ) > 0 Then  ls_DBFreeSyntax = ads_Original.GetItemString( li_Find, 'dw_sql' )
			If Len(  as_GridObject[ li_i ]  ) > 0 Then  ls_DBGridSyntax = ads_Original.GetItemString( li_Find, 'grid_sql' )
		End If	
		If ( IsNull( ls_DBFreeSyntax ) Or ls_DBFreeSyntax = "" Or ls_DBFreeSyntax = "?" Or ls_DBFreeSyntax = "!" ) And  Len(  as_freeobject[ li_i ]  ) > 0 Then
//			ads_Original.SetItem( li_Find, 'dw_sql', ls_FreeSyntax )	
			as_freesyntax[li_i] = ls_FreeSyntax
			ads_Original.SetItem( li_Find, 'modifydate', datetime( today(), now() ) )
			ab_update[li_i] = True
			Continue
		End If
		If ( IsNull( ls_DBGridSyntax ) Or ls_DBGridSyntax = "" Or ls_DBGridSyntax = "?" Or ls_DBGridSyntax = "!" ) And  Len(  as_GridObject[ li_i ]  ) > 0 Then
//			ads_Original.SetItem( li_Find, 'grid_sql', ls_GridSyntax )		
			as_gridsyntax[li_i] = ls_gridSyntax
			ads_Original.SetItem( li_Find, 'modifydate', datetime( today(), now() ) )
			ab_update[li_i] = True
			Continue
		End If
		If   Len(  as_freeobject[ li_i ]  ) > 0 And ls_DBFreeSyntax <> ls_FreeSyntax Then
//			ads_Original.SetItem( li_Find, 'dw_sql', ls_FreeSyntax )
			as_freesyntax[li_i] = ls_FreeSyntax
			ads_Original.SetItem( li_Find, 'pre_modifydate', ads_Original.GetItemDateTime( li_Find,'modifydate' ) )
			ads_Original.SetItem( li_Find, 'modifydate', datetime( today(), now() ) )
			ab_update[li_i] = True
		End If
		If  Len(  as_GridObject[ li_i ]  ) > 0 And  ls_DBGridSyntax <> ls_GridSyntax  Then
//			ads_Original.SetItem( li_Find, 'grid_sql', ls_GridSyntax )
			as_gridsyntax[li_i] = ls_gridSyntax
			ads_Original.SetItem( li_Find, 'pre_modifydate', ads_Original.GetItemDateTime( li_Find,'modifydate' ) )
			ads_Original.SetItem( li_Find, 'modifydate', datetime( today(), now() ) )
			ab_update[li_i] = True
		End If
	End If
	
	
Next





Return 1
end function

public function integer of_splitsyntax (string as_syntax, ref string as_presyntax, ref string as_lastsyntax, ref n_ds ads_mid);//
string					ls_s_syntax, ls_t_syntax
String					ls_s_pre, ls_s_last, ls_s_mid
Long					ll_Pos, ll_Pos2, ll_LastPos, ll_LastPos2
Long					ll_MinPos
String					ls_Standobjects, ls_StandLists[]
String					ls_temp, ls_Name
Integer				li_i, li_k, li_PosName
String					ls_Band[]


//no support ole,ink etc.
ls_Standobjects =  "line(,text(,column(,ellipse(,bitmap(,groupbox(,rectangle(,button(,compute(,roundrectangle(,graph("
ls_Band  = {'band=detail', 'band=header', 'band=trailer','band=summary','band=footer' }
ll_MinPos = 99999999
For li_k = 1 To UpperBound( ls_Band )
	ll_Pos = Pos( as_syntax, ls_Band[li_k] )
	If ll_Pos > 0 And ll_MinPos  > ll_Pos Then
		ll_MinPos = ll_Pos
	End If
Next
ll_Pos = ll_MinPos

ll_MinPos = 0
For li_k = 1 To UpperBound( ls_Band )
	ll_Pos2 = LastPos( as_syntax, ls_Band[li_k]  )
	If ll_Pos2 > 0 And ll_MinPos  < ll_Pos2 Then
		ll_MinPos = ll_Pos2
	End If
Next
ll_Pos2 = ll_MinPos


ll_LastPos = LastPos( as_syntax, '~r~n' , ll_Pos )
If Pos ( ls_Standobjects,  Mid( as_syntax, ll_LastPos + 2, Pos( as_syntax, '(' , ll_LastPos+ 2 ) -  ll_LastPos - 1 ) ) = 0 Then
	For   li_i = 1 To 100
		ll_LastPos = LastPos( as_syntax, '~r~n' , ll_LastPos )
		If ll_LastPos = 0 Then Exit
		If Pos ( ls_Standobjects,  Mid( as_syntax, ll_LastPos + 2, Pos( as_syntax, '(' , ll_LastPos+ 2 ) -  ll_LastPos - 1 ) ) > 0 Then
			ls_s_pre = left( as_syntax, ll_lastPos - 2 )
			exit
		Else
			ll_LastPos = ll_LastPos - 1			
		End If
	Next
Else
	ls_s_pre = left( as_syntax, ll_lastPos - 1 )
End If
If ll_LastPos <=0 Then 
	IF IsValid(gnv_logservice)THEN 
		gnv_logservice.of_setloglevel(2) //warning level
		gnv_logservice.of_log_warning( 'Failed to find beginning object  !' +  Mid( as_syntax, ll_Pos - 100, 200 ) )
	END iF
	return -1
end if
ll_LastPos2 = Pos( as_syntax, '~r~n' , ll_Pos2 )
If Pos ( 'htmltable(',  Mid( as_syntax, ll_LastPos2 + 2, Pos( as_syntax, '(' , ll_LastPos2+ 2 ) -  ll_LastPos2 - 1 ) ) = 0 and & 
	Pos ( 'sparse(',  Mid( as_syntax, ll_LastPos2 + 2, Pos( as_syntax, '(' , ll_LastPos2+ 2 ) -  ll_LastPos2 - 1 ) ) = 0  Then
	For   li_i = 1 To 100
		ll_LastPos2 = Pos( as_syntax, '~r~n' , ll_LastPos2 )
		If ll_LastPos2 = 0 Then Exit
		If Pos ( 'htmltable(',  Mid( as_syntax, ll_LastPos2 + 2, Pos( as_syntax, '(' , ll_LastPos2+ 2 ) -  ll_LastPos2 - 1 ) ) > 0 or &
		Pos ( 'sparse(',  Mid( as_syntax, ll_LastPos2 + 2, Pos( as_syntax, '(' , ll_LastPos2+ 2 ) -  ll_LastPos2 - 1 ) ) > 0 Then
			ls_s_last = Mid( as_syntax, ll_lastPos2 + 2 )
			exit
		Else
			ll_LastPos2 ++
		End If
	Next
Else
	ls_s_last = Mid( as_syntax, ll_lastPos2 + 2 )
End If
If ll_LastPos2 <=0 Then   
	IF IsValid(gnv_logservice)THEN 
		gnv_logservice.of_setloglevel(2) //warning level
		gnv_logservice.of_log_warning( 'Failed to find end of object  !' +  Mid( as_syntax, ll_Pos2 - 100, 200 ) )
	END iF
	return  -1
end if

ls_s_mid = Mid( as_syntax, ll_lastPos + 2 , ll_lastPos2 - ll_lastPos - 1 )
ll_Pos = 1
For  li_k = 1 To  1000
	ll_Pos = Pos( ls_s_mid, '~r~n', ll_Pos )
	If ll_Pos = 0 Then  exit
	If Pos (ls_Standobjects ,  Mid( ls_s_mid, ll_Pos + 2, Pos( ls_s_mid, '(' , ll_Pos+ 2 ) -  ll_Pos  - 1 ) ) = 0 Then
		ll_Pos ++
		continue
	else
		ls_temp = Mid( ls_s_mid, 1, ll_Pos - 1 )
		If left( ls_temp, 1 ) = '~r' Then ls_Temp = mid( ls_temp, 2 )
		If left( ls_temp, 1 ) = '~n' Then ls_Temp = mid( ls_temp, 2 )
		If right( ls_temp, 1 ) = '~n' Then ls_Temp = Left( ls_temp, Len( ls_temp) - 1 )
		If right( ls_temp, 1 ) = '~r' Then ls_Temp = Left( ls_temp, Len( ls_temp) - 1 )
		ads_mid.insertrow( 0 )
		ads_mid.setItem( ads_mid.RowCount( ), 'code',  ads_mid.RowCount( ) )
		ads_mid.setItem( ads_mid.RowCount( ), 'content', ls_temp )
		li_PosName =  pos( ls_temp, 'name=' )
		If li_PosName > 0 Then
			ls_Name = Mid( ls_Temp, li_PosName + 5, Pos( ls_Temp, ' ', li_PosName ) - li_PosName - 5  )
			ads_mid.setItem( ads_mid.RowCount( ), 'name', ls_Name )
		End If
	end If
	ls_s_mid = Mid( ls_s_mid, ll_pos + 2 )
	ll_pos = 1
Next


If Len( ls_s_mid ) > 2 Then  
	ads_mid.insertrow( 0 )
	ads_mid.setItem( ads_mid.RowCount( ), 'code',  ads_mid.RowCount( ) )
	If left( ls_s_mid, 1 ) = '~r' Then ls_s_mid = mid( ls_s_mid, 2 )
	If left( ls_s_mid, 1 ) = '~n' Then ls_s_mid = mid( ls_s_mid, 2 )
	If right( ls_s_mid, 1 ) = '~n' Then ls_s_mid = Left( ls_s_mid, Len( ls_s_mid) - 1 )
	If right( ls_s_mid, 1 ) = '~r' Then ls_s_mid = Left( ls_s_mid, Len( ls_s_mid) - 1 )
   ads_mid.setItem( ads_mid.RowCount( ), 'content', ls_s_mid )
End If

li_PosName =  pos( ls_s_mid, 'name=' )
If li_PosName > 0 Then
	ls_Name = Mid( ls_s_mid, li_PosName + 5, Pos( ls_s_mid, ' ', li_PosName ) - li_PosName - 5  )
	ads_mid.setItem( ads_mid.RowCount( ), 'name', ls_Name )
End If

as_presyntax = ls_s_pre
as_lastsyntax = ls_s_last





Return 0

end function

public subroutine of_arrageobject (ref string as_source, string as_target);////====================================================================
// Function: of_arrageobject
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	as_source
// 	as_target
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	gavin		Date: 2012-06-01
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
n_ds					lds_source, lds_target, lds_Create
string					ls_s_syntax, ls_t_syntax
String					ls_s_pre, ls_s_last, ls_s_mid
String					ls_t_pre, ls_t_last, ls_t_mid
Long					ll_Pos, ll_Pos2, ll_LastPos, ll_LastPos2
String					ls_Standobjects, ls_StandLists[]
String					ls_temp, ls_Err
Integer				li_i, li_k, li_Find


//no support ole,ink etc.
ls_Standobjects =  "line(,text(,column(,ellipse(,bitmap(,groupbox(,rectangle(,button(,compute(,roundrectangle(,graph("
lds_source = create n_ds
lds_target = create n_ds
lds_Create = Create n_ds
lds_source.dataobject = 'd_screen_upgrade_arrange_ext'
lds_target.dataobject = 'd_screen_upgrade_arrange_ext'

If of_splitsyntax( as_source, ls_s_pre, ls_s_last , lds_source ) < 0 Then
	If isvalid(lds_source) Then Destroy lds_source	
	If isvalid(lds_target) Then Destroy lds_target	
	If isvalid(lds_Create) Then Destroy lds_Create		
	Return
End If

If of_splitsyntax( as_target, ls_t_pre, ls_t_last , lds_target ) < 0 Then 
	If isvalid(lds_source) Then Destroy lds_source	
	If isvalid(lds_target) Then Destroy lds_target	
	If isvalid(lds_Create) Then Destroy lds_Create	
	Return
End If


For li_k = 1 To lds_target.RowCount( )
	ls_Temp = lds_target.GetItemString( li_k, 'name' )
	If  IsNull( ls_temp ) Or Trim( ls_temp ) = '' Then Continue
	li_Find = lds_Source.Find( "name = '" + ls_temp + "'",1, lds_Source.RowCount( ))
	If li_Find > 0 Then
		lds_Source.SetItem(   li_Find, 'code', lds_target.GetItemNumber( li_k, 'code' ) )
	End If
Next

lds_Source.SetSort( "code" )
lds_Source.Sort( )
ls_temp = "" 
For li_k = 1 To lds_Source.RowCount( )
	ls_temp += lds_Source.GetItemString( li_k, 'content' ) + "~r~n"
	
Next
ls_s_syntax = ls_S_pre +'~r~n' + ls_Temp + ls_S_Last

lds_Create.SetTransObject( sqlca )
lds_Create.Create( ls_s_syntax, ls_Err )
If Len(   ls_Err ) > 0 Then
	IF IsValid(gnv_logservice)THEN 
		gnv_logservice.of_setloglevel(2) //warning level
		gnv_logservice.of_log_warning( 'Failed to create syntax!'  + ls_Err )
	END iF
	If isvalid(lds_source) Then Destroy lds_source	
	If isvalid(lds_target) Then Destroy lds_target	
	If isvalid(lds_Create) Then Destroy lds_Create		
	RETURN	
End If
as_source = ls_s_syntax

If isvalid(lds_source) Then Destroy lds_source	
If isvalid(lds_target) Then Destroy lds_target	
If isvalid(lds_Create) Then Destroy lds_Create	
end subroutine

public function integer of_align_object (datastore ads_grid);//
String			ls_Column[], ls_Type
String			ls_Visible, ls_Name, ls_Visible2 
String			ls_Modify, ls_sObjects
Integer		li_i
Long			ll_X, ll_Width

ls_Modify = ""

ls_sObjects  = ads_grid.Describe("DataWindow.Objects")
inv_string.of_parsetoarray(ls_sObjects,'~t',ls_Column[])

For li_i = 1 To Upperbound( ls_Column[] )
	ls_Type = ads_grid.Describe( ls_Column[li_i] + ".type" )
	If Not( ls_Type = 'column' Or ls_Type = 'compute' ) Then Continue
	ls_visible = ads_grid.Describe( ls_Column[li_i] + ".visible" )
	ls_Name = ads_grid.Describe( ls_Column[li_i]  + ".name" )
	ls_Visible2 = ads_grid.Describe( ls_Column[li_i]   + "_t.visible" )
	
	If ls_Visible = '0' Then
		If Not( ls_Visible2 = '!' or ls_Visible2 = '?' ) Then 		ls_Modify += " " + ls_Name + "_t.visible='" + ls_Visible + "'" 
	ElseIf ls_Visible = '1' Then
		If Not( ls_Visible2 = '!' or ls_Visible2 = '?' ) Then 	
			ll_X = Long( ads_grid.Describe( ls_Column[li_i]  + ".x" ) )
			ll_Width = Long( ads_grid.Describe( ls_Column[li_i]  + ".width" ) )
			ls_Modify += " " + ls_Name + "_t.visible='" + ls_Visible + "' " + ls_Name + "_t.x=" + string(ll_X )+ " " + ls_Name + "_t.width=" + string( ll_Width ) 
		End If
	Else
		If Not( ls_Visible2 = '!' or ls_Visible2 = '?' ) Then 	
			ll_X = Long( ads_grid.Describe(  ls_Column[li_i]  + ".x" ) )
			ll_Width = Long( ads_grid.Describe( ls_Column[li_i]  + ".width" ) )
			ls_Modify += " " + ls_Name + "_t.x=" + string(ll_X )+ " " + ls_Name + "_t.width=" + string( ll_Width ) 
		End If
	End If
		
Next


If Len( ls_Modify ) > 0 Then
	ads_grid.Modify( ls_Modify ) 
End If











Return 0
end function

public function string of_align_object (datastore ads_grid, string as_tips);//
String			ls_Column[], ls_Type
String			ls_Visible, ls_Name, ls_Visible2 
String			ls_Modify, ls_sObjects
Integer		li_i
Long			ll_X, ll_Width
Long			ll_X2, ll_Width2
Boolean		lb_Tips

ls_Modify = ""

ls_sObjects  = ads_grid.Describe("DataWindow.Objects")
inv_string.of_parsetoarray(ls_sObjects,'~t',ls_Column[])

For li_i = 1 To Upperbound( ls_Column[] )
	ls_Type = ads_grid.Describe( ls_Column[li_i] + ".type" )
	If Not( ls_Type = 'column' Or ls_Type = 'compute' ) Then Continue
	ls_visible = ads_grid.Describe( ls_Column[li_i] + ".visible" )
	ls_Name = ads_grid.Describe( ls_Column[li_i]  + ".name" )
	ls_Visible2 = ads_grid.Describe( ls_Column[li_i]   + "_t.visible" )
	
	If ls_Visible = '0' Then
		If Not( ls_Visible2 = '!' or ls_Visible2 = '?' ) Then 	
			If ls_Visible2 <> ls_Visible Then lb_Tips = True
			ls_Modify += " " + ls_Name + "_t.visible='" + ls_Visible + "'" 
		End If
	ElseIf ls_Visible = '1' Then
		If Not( ls_Visible2 = '!' or ls_Visible2 = '?' ) Then 	
			
			ll_X = Long( ads_grid.Describe( ls_Column[li_i]  + ".x" ) )
			ll_Width = Long( ads_grid.Describe( ls_Column[li_i]  + ".width" ) )
			
			ll_X2 =  Long( ads_grid.Describe( ls_Column[li_i]  + "_t.x" ) )
			ll_Width2 = Long( ads_grid.Describe( ls_Column[li_i]  + "_t.width" ) )
			
			If ls_Visible2 <> ls_Visible  Or ll_X <> ll_X2 Or ll_Width <> ll_Width2 Then lb_Tips = True
			
			ls_Modify += " " + ls_Name + "_t.visible='" + ls_Visible + "' " + ls_Name + "_t.x=" + string(ll_X )+ " " + ls_Name + "_t.width=" + string( ll_Width ) 
		End If
	Else
		If Not( ls_Visible2 = '!' or ls_Visible2 = '?' ) Then 	
			ll_X = Long( ads_grid.Describe(  ls_Column[li_i]  + ".x" ) )
			ll_Width = Long( ads_grid.Describe( ls_Column[li_i]  + ".width" ) )
			
			ll_X2 =  Long( ads_grid.Describe( ls_Column[li_i]  + "_t.x" ) )
			ll_Width2 = Long( ads_grid.Describe( ls_Column[li_i]  + "_t.width" ) )
			
			If  ll_X <> ll_X2 Or ll_Width <> ll_Width2 Then lb_Tips = True
			
			ls_Modify += " " + ls_Name + "_t.x=" + string(ll_X )+ " " + ls_Name + "_t.width=" + string( ll_Width ) 
		End If
	End If
		
Next


If Len( ls_Modify ) > 0 And lb_Tips Then
	If Len( as_Tips ) > 0 Then MessageBox( 'Tips', as_Tips )
	ads_grid.Modify( ls_Modify ) 
End If





Return ads_grid.Describe( "datawindow.syntax" )
end function

public function integer of_align_object (datawindow adw_grid1, datawindow adw_grid2, string as_tips);//
String			ls_Column[], ls_Type
String			ls_Visible, ls_Name, ls_Visible2 
String			ls_Modify, ls_sObjects
Integer		li_i
Long			ll_X, ll_Width
Long			ll_X2, ll_Width2
Boolean		lb_Tips

ls_Modify = ""

ls_sObjects  = adw_grid2.Describe("DataWindow.Objects")
inv_string.of_parsetoarray(ls_sObjects,'~t',ls_Column[])

For li_i = 1 To Upperbound( ls_Column[] )
	ls_Type = adw_grid2.Describe( ls_Column[li_i] + ".type" )
	If Not( ls_Type = 'column' Or ls_Type = 'compute' ) Then Continue
	ls_visible = adw_grid2.Describe( ls_Column[li_i] + ".visible" )
	ls_Name = adw_grid2.Describe( ls_Column[li_i]  + ".name" )
	ls_Visible2 = adw_grid1.Describe( ls_Column[li_i]   + "_t.visible" )
	
	If ls_Visible = '0' Then
		If Not( ls_Visible2 = '!' or ls_Visible2 = '?' ) Then 	
			If ls_Visible2 <> ls_Visible Then lb_Tips = True
			ls_Modify += " " + ls_Name + "_t.visible='" + ls_Visible + "'" 
		End If
	ElseIf ls_Visible = '1' Then
		If Not( ls_Visible2 = '!' or ls_Visible2 = '?' ) Then 	
			
			ll_X = Long( adw_grid2.Describe( ls_Column[li_i]  + ".x" ) )
			ll_Width = Long( adw_grid2.Describe( ls_Column[li_i]  + ".width" ) )
			
			ll_X2 =  Long( adw_grid1.Describe( ls_Column[li_i]  + "_t.x" ) )
			ll_Width2 = Long( adw_grid1.Describe( ls_Column[li_i]  + "_t.width" ) )
			
			If ls_Visible2 <> ls_Visible  Or ll_X <> ll_X2 Or ll_Width <> ll_Width2 Then lb_Tips = True
			
			ls_Modify += " " + ls_Name + "_t.visible='" + ls_Visible + "' " + ls_Name + "_t.x=" + string(ll_X )+ " " + ls_Name + "_t.width=" + string( ll_Width ) 
		End If
	Else
		If Not( ls_Visible2 = '!' or ls_Visible2 = '?' ) Then 	
			ll_X = Long( adw_grid2.Describe(  ls_Column[li_i]  + ".x" ) )
			ll_Width = Long( adw_grid2.Describe( ls_Column[li_i]  + ".width" ) )
			
			ll_X2 =  Long( adw_grid1.Describe( ls_Column[li_i]  + "_t.x" ) )
			ll_Width2 = Long( adw_grid1.Describe( ls_Column[li_i]  + "_t.width" ) )
			
			If  ll_X <> ll_X2 Or ll_Width <> ll_Width2 Then lb_Tips = True
			
			ls_Modify += " " + ls_Name + "_t.x=" + string(ll_X )+ " " + ls_Name + "_t.width=" + string( ll_Width ) 
		End If
	End If
		
Next


If Len( ls_Modify ) > 0 And lb_Tips Then
	If Len( as_Tips ) > 0 Then MessageBox( 'Tips', as_Tips )
	adw_grid1.Modify( ls_Modify ) 
End If





Return 0
end function

public function integer of_update_changeobject (datastore ads_source, datastore ads_target, datastore ads_properties, string as_forceupdate);n_ds					lds_source, lds_target, lds_Create
string					ls_s_syntax, ls_t_syntax
String					ls_s_pre, ls_s_last, ls_s_mid
String					ls_t_pre, ls_t_last, ls_t_mid
Long					ll_Pos, ll_Pos2, ll_LastPos, ll_LastPos2
String					ls_Standobjects, ls_StandLists[]
String					ls_temp, ls_Err
Integer				li_i, li_k, li_Find
string					ls_Source, ls_Target, ls_Content, ls_Attributes[], ls_Values[]
string					ls_tag, ls_Target_Content, ls_sObjectlist[], ls_Type, ls_Modify = ''
Long					ll_Row, ll_Count, ll_ID, ll_sObjcount, ll_TID
String					ls_Ttag


//no support ole,ink etc.
ls_Standobjects =  "line(,text(,column(,ellipse(,bitmap(,groupbox(,rectangle(,button(,compute(,roundrectangle(,graph("
lds_source = create n_ds
lds_target = create n_ds
lds_Create = Create n_ds
lds_source.dataobject = 'd_screen_upgrade_arrange_ext'
lds_target.dataobject = 'd_screen_upgrade_arrange_ext'

//exchange  datawindow attribute
//Get DataWindow Properties
of_get_objectpro(ads_target,ads_properties,"datawindow")

of_set_ObjectPro(ads_source,ads_properties)

//force update if it's necessary
if Len(as_forceupdate) > 0 then 
	ads_target.Modify(as_forceupdate)
end if

ls_Source = ads_source.Describe( "datawindow.syntax" )
ls_Target = ads_target.Describe( "datawindow.syntax" )


If of_splitsyntax( ls_Source, ls_s_pre, ls_s_last , lds_source ) < 0 Then Return  -1

If of_splitsyntax( ls_Target, ls_t_pre, ls_t_last , lds_target ) < 0 Then Return -1

ls_Attributes = { 'id'  }
ls_Values[Upperbound( ls_Attributes)] = ''
//add object from source to target
For li_k =1 To lds_source.Rowcount( )
	ls_Temp = lds_source.GetItemString( li_k, 'name' )
	ls_content = lds_source.GetItemString( li_k, 'content' )
	If  IsNull( ls_temp ) Or Trim( ls_temp ) = '' Then Continue
	li_Find = lds_target.Find( "name = '" + ls_temp + "'",1, lds_target.RowCount( ))
	If li_Find = 0 Then
		ll_Row = lds_target.Insertrow( 0 )
		lds_target.SetItem(   ll_Row, 'code', lds_source.GetItemNumber( li_k, 'code' ) )
		lds_target.SetItem(   ll_Row, 'name',ls_temp )
		lds_target.SetItem(   ll_Row, 'content', ls_content )
	ElseIf li_Find > 0 Then
		If left( ls_content, 7 ) = 'column(' Then
			ll_ID = Long( ads_source.Describe(  ls_temp + ".ID" ) )
			ll_TID = Long( ads_target.Describe( ls_temp + ".ID" ) )
			If ll_ID <> ll_TID Then
				ls_Values[1] = String( ll_ID  )
				ls_Target_Content =  lds_target.GetItemString( li_Find, 'content' )
				ls_Target_Content = of_SetObjectattribute_value( ls_Target_Content, ls_Attributes, ls_values )
				lds_target.SetItem(   li_Find, 'content', ls_Target_Content )
			End If
		End If
		//added by gavins 20130423
		If ii_Screen_ID = 3 And ( ls_temp = 'category'  Or ls_temp = 'master_contract_name'  Or ls_temp = 'app_facility'  Or  ls_temp = 'custom_status1'  Or ls_temp = 'custom_status2' ) Or & 
		( ( ii_Screen_ID = 1 Or ii_Screen_ID = 2 ) And ( ls_temp = 'custom_status1' or ls_temp = 'custom_status2')  ) 	Then
			ls_Tag =  ads_source.Describe( ls_Temp  + ".tag" )
			If  NOT( ls_Tag = '!' or ls_Tag = '?'  Or ls_Tag = '1#'  ) and len( ls_tag ) > 0  Then//synchronize only one
				ls_Ttag = ads_target.Describe( ls_Temp  + ".tag" )
				If ls_Tag <> ls_Ttag Then 	ls_Modify = ls_Modify  + ls_Temp + ".tag='" + ls_Tag + "' " 
				
			End If
		End If
	End If	
Next
//delete column
For li_k =1 To lds_target.Rowcount( )
	ls_Temp = lds_target.GetItemString( li_k, 'name' )
	ls_content = lds_target.GetItemString( li_k, 'content' )
	If Left( ls_Content, 7 ) <> 'column(' Then continue
	If  IsNull( ls_temp ) Or Trim( ls_temp ) = '' Then Continue
	li_Find = lds_source.Find( "name = '" + ls_temp + "'",1, lds_source.RowCount( ))
	If li_Find = 0 Then
		lds_target.DeleteRow( li_k )
		li_k = li_k - 1
	End If	
Next

lds_target.SetSort( "code" )
lds_target.Sort( )
ls_temp = "" 
For li_k = 1 To lds_target.RowCount( )
	ls_temp += lds_target.GetItemString( li_k, 'content' ) + "~r~n"
Next
ls_s_syntax = ls_S_pre +'~r~n' + ls_Temp + ls_S_Last



ads_Source.Create( ls_s_syntax, ls_Err )
If Len( ls_Err ) > 0 Then
	MessageBox( 'Tips', ls_Err )
	gnv_debug.of_output( true, 'The new upgrade method is failure, syntax=' + ls_S_syntax + ', error=' + ls_Err  )
	Return -1
End If

If Len( ls_Modify ) > 0 Then
	ls_Err = ads_Source.Modify( ls_Modify )
	If Len( ls_Err ) > 0 Then
		MessageBox( 'Tips', ls_Err )
		gnv_debug.of_output( true, 'The new upgrade method is failure, modify=' + ls_Modify + ', error=' + ls_Err )
		Return -1
	End If
End If

Destroy(  lds_source )  
destroy( lds_target )
destroy( lds_Create )

Return 1
end function

public function string of_setobjectattribute_value (string as_content, string as_objects[], string as_values[]);Long	 	ll_pos, ll_POS2, ll_LastPos, ll_id
String		ls_Content, ls_Object
Integer	li_i, li_k

ls_Content = as_Content

ll_pos = 1
ll_pos = pos( ls_Content, '=' , ll_pos )
do while ll_pos  > 0 
	If  Mid( ls_Content, ll_Pos+1 , 1 ) = '"' Then
		ll_Pos2 = Pos( ls_content, '"', ll_Pos + 2 ) 
		do while ll_Pos2 > 0 
			If Mid( ls_content, ll_Pos2 - 1, 1 ) = '~~' 	Then
				ll_Pos2 = Pos( ls_content, '"', ll_Pos2 + 1 ) 
			Else
				Exit
			End If
		loop
		ll_Pos = ll_Pos2
	Else
		ll_LastPos =  LastPos( ls_Content, ' ', ll_Pos )
		If ll_LastPos = 0 Then
			ll_LastPos =  LastPos( ls_Content, '(', ll_Pos ) 
		End If
		ls_object =  Mid( ls_Content, ll_LastPos + 1, ll_Pos -  ll_LastPos - 1 )
		For li_i = 1 To Upperbound( as_objects )
			If ls_Object = as_objects[li_i] Then
				li_k ++
				ls_Content = Replace( ls_Content, ll_Pos + 1,  Pos( ls_Content, ' ', ll_Pos ) - ll_Pos - 1, as_values[li_i]  )
			End If
		Next	
	End If	
	
	If li_k = Upperbound( as_objects )  Then exit
	ll_Pos++
	ll_Pos = pos( ls_Content, '=' , ll_pos )
loop

return ls_Content
end function

public function integer of_getobjectattribute_value (string as_content, string as_objects[], string as_values[]);Long	 	ll_pos, ll_POS2, ll_LastPos, ll_id
String		ls_Content, ls_Object
Integer	li_i, li_k

ls_Content = as_Content

ll_pos = 1
ll_pos = pos( ls_Content, '=' , ll_pos )
do while ll_pos  > 0 
	If  Mid( ls_Content, ll_Pos+1 , 1 ) = '"' Then
		ll_Pos2 = Pos( ls_content, '"', ll_Pos + 2 ) 
		do while ll_Pos2 > 0 
			If Mid( ls_content, ll_Pos2 - 1, 1 ) = '~~' 	Then
				ll_Pos2 = Pos( ls_content, '"', ll_Pos2 + 1 ) 
			Else
				Exit
			End If
		loop
		ll_Pos = ll_Pos2
	Else
		ll_LastPos =  LastPos( ls_Content, ' ', ll_Pos )
		If ll_LastPos = 0 Then
			ll_LastPos =  LastPos( ls_Content, '(', ll_Pos ) 
		End If
		ls_object =  Mid( ls_Content, ll_LastPos + 1, ll_Pos -  ll_LastPos - 1 )
		For li_i = 1 To Upperbound( as_objects )
			If ls_Object = as_objects[li_i] Then
				li_k ++
				as_values[li_i] = Mid( ls_Content,  ll_Pos + 1,  Pos( ls_Content, ' ', ll_Pos ) - ll_Pos - 1 )
			End If
		Next	
	End If	
	
	If li_k = Upperbound( as_objects )  Then exit
	ll_Pos++
	ll_Pos = pos( ls_Content, '=' , ll_pos )
loop

return 0
end function

public subroutine of_repair_picture ();//////////////////////////////////////////////////////////////////// //
// $<function>n_cst_contract_sqlof_asa_6_changes()
// $<arguments> Boolean ab_force_update
// $<returns> (none)
// $<description>Contract module modification
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 08.09.2006 by Liang QingShi
//////////////////////////////////////////////////////////////////////
Integer i,li_num,li_rowcount,li_row
String ls_tab_name[],ls_screen_name[],ls_dw_name[],ls_dataobject[]
String ls_sql,ls_error_create
n_cst_datastore lds_sql
n_cst_datastore lds_source,lds_target,lds_properties
Long ll_count , ll_find
Boolean lb_update_falg
Long ll_view_id,ll_screen_id
String ls_dataobject1
DateTime ldt_modify_date
String   ls_ForceUpdates[]
String ls_ForceUpdates1001[] //only for default view
string 	ls_ForceUpdates_screen
String   ls_text
String   ls_Error
str_dwsyntax lstr_syntax[]	//jervis 05.19.2011
/*******************************///added by gainvs 20120305 required grid
String		ls_GridDataObject[], ls_ScreenStyle[], ls_NeedModify[], ls_column[]
Boolean	lb_GridExists
Integer	li_k, li_Cycle, li_ReturnUpgrade, li_a
String		ls_GridSQL, ls_sObjects, ls_Type
n_ds		lds_Original, lds_pic
Boolean			lb_Upgrade[], lb_Error
String				ls_FreeSyntax[], ls_GridSyntax[]
String				ls_TargetSyntax, ls_filename, ls_Path, ls_object
Boolean			lb_NewUpgrade
String 			is_pic_path = 'Bitmap' , ls_originalFile

ls_path = gs_dir_path + gs_DefDirName +"\" + is_pic_path + "\"
gnv_appeondll.of_parsepath(ls_path)

lds_pic = create n_ds
lds_pic.dataobject = 'd_conv_view_pic'
lds_pic.SetTransobject( sqlca)

long ll_FRow, ll_x, ll_y, ll_datalen
n_cst_filesrv   lnv_filesrv
blob			lb_file
string 		ls_band, ls_pictype
/*******************************/
lnv_filesrv = create n_cst_filesrv

lb_update_falg = True
lds_source = Create n_cst_datastore
lds_sql = Create n_cst_datastore
lds_target = Create n_cst_datastore
lds_properties = Create n_cst_datastore

//initilize log service  //added by gavins 20120601
IF Not IsValid(gnv_logservice) THEN gnv_logservice = Create n_logservice



//Add by jervis -- 05.17.2011
of_per_screen_process()


lds_properties.DataObject = "d_update_user_datawindow_objlist"
lds_sql.DataObject = 'd_contract_dw_sql_update'
lds_sql.SetTransObject(sqlca)
//$<modify> 03.12.2008 by Andy
if lds_sql.Retrieve() = -1 then
	ls_Error= "n_cst_update_screen.of_appeon2_changes() Information: lds_sql.Retrieve() failed, call support." 
	IF IsValid(gnv_logservice)THEN 
		gnv_logservice.of_setloglevel(2) //warning level
		gnv_logservice.of_log_warning(ls_Error)
		gb_upgrade_failed = TRUE			
	END IF
end if
//end of modify 03.12.2008

ls_tab_name[1] = 'tabpage_search'
ls_tab_name[2] = 'tabpage_search'
ls_tab_name[3] = 'tabpage_details'
ls_tab_name[4] = 'tabpage_details'
ls_tab_name[5] = 'tabpage_details'
ls_tab_name[6] = 'tabpage_details'
ls_tab_name[7] = 'tabpage_details'
ls_tab_name[8] = 'tabpage_details'
ls_tab_name[9] = 'tabpage_details'
ls_tab_name[10] = 'tabpage_details'
ls_tab_name[11] = 'tabpage_requirements'
ls_tab_name[12] = 'tabpage_requirements'
ls_tab_name[13] = 'tabpage_requirements'
ls_tab_name[14] = 'tabpage_contacts'
ls_tab_name[15] = 'tabpage_contacts'
ls_tab_name[16] = 'tabpage_contacts'
ls_tab_name[17] = 'tabpage_contacts'
ls_tab_name[18] = 'tabpage_locations'
ls_tab_name[19] = 'tabpage_locations'
ls_tab_name[20] = 'tabpage_locations'
ls_tab_name[21] = 'tabpage_locations'
ls_tab_name[22] = 'tabpage_orgabizations'
ls_tab_name[23] = 'tabpage_orgabizations'
ls_tab_name[24] = 'tabpage_orgabizations'
ls_tab_name[25] = 'tabpage_orgabizations'
ls_tab_name[26] = 'tabpage_fee_schedules'
ls_tab_name[27] = 'tabpage_fee_schedules'
ls_tab_name[28] = 'tabpage_fee_schedules'
ls_tab_name[29] = 'tabpage_fee_schedules'
ls_tab_name[30] = 'tabpage_fee_schedules'
ls_tab_name[31] = 'tabpage_fee_sched2'
ls_tab_name[32] = 'tabpage_images'
ls_tab_name[33] = 'tabpage_action_items'
ls_tab_name[34] = 'tabpage_qrg'
ls_tab_name[35] = 'tabpage_qrg'
ls_tab_name[36] = 'tabpage_qrg'
ls_tab_name[37] = 'tabpage_qrg'
ls_tab_name[38] = 'tabpage_qrg'
ls_tab_name[39] = 'tabpage_qrg'
ls_tab_name[40] = 'tabpage_qrg'
ls_tab_name[41] = 'tabpage_qrg'
ls_tab_name[42] = 'tabpage_action_items'
ls_tab_name[43] = 'tabpage_details'
ls_tab_name[44] = 'tabpage_images'
ls_tab_name[45] = 'tabpage_images'
ls_tab_name[46] = 'tabpage_images'
ls_tab_name[47] = 'tabpage_images'
ls_tab_name[48] = 'tabpage_images'
ls_tab_name[49] = 'tabpage_images'
ls_tab_name[50] = 'tabpage_details' //Added by Ken.Guo on 2009-02-10
ls_tab_name[51] = 'tabpage_images'	//Added by Scofield on 2010-04-20
ls_tab_name[52] = 'tabpage_images'	//Added by Scofield on 2010-04-20
//Add custom multi data tabpage - jervis 05.31.2011
ls_tab_name[53] = 'tabpage_multi'  
ls_tab_name[54] = 'tabpage_multi'  
ls_tab_name[55] = 'tabpage_multi'  

ls_tab_name[56] = 'tabpage_images' //add by gavins20120131
ls_tab_name[57] = 'tabpage_images'
ls_tab_name[58] = 'tabpage_email'							//Added By Mark Lee 02/04/2013

ls_screen_name[1] = 'Search->Search Criteria'
ls_screen_name[2] = 'Search->Contract Browse'
ls_screen_name[3] = 'Details->Contract Detail'
ls_screen_name[4] = 'Details->Products'
ls_screen_name[5] = 'Details->Contract Dates'
ls_screen_name[6] = 'Details->Contracted Company Contact'
ls_screen_name[7] = 'Details->Our Company Contact'
ls_screen_name[8] = 'Details->Notes Tab->Notes'
ls_screen_name[9] = 'Details->Custom Data Tab->Custom Data'
//ls_screen_name[10] = 'Details->Audit Trail Tab->Audit Trail'
ls_screen_name[10] = 'Details->Custom Data 2->Custom Data 2'
ls_screen_name[11] = 'Requirements->Profile Selection'
ls_screen_name[12] = 'Requirements->Profile Detail'
ls_screen_name[13] = 'Requirements->Profile Detail'
ls_screen_name[14] = 'Other Contacts->Contacts List'
ls_screen_name[15] = 'Other Contacts->Contact Details'
ls_screen_name[16] = 'Other Contacts->Contact Information'
ls_screen_name[17] = 'Other Contacts->Contact Notes'
ls_screen_name[18] = 'Locations->Parent Organization'
ls_screen_name[19] = 'Locations->Group/Location'
ls_screen_name[20] = 'Locations->Associated Physicians'
ls_screen_name[21] = 'Locations->Specialties'
ls_screen_name[22] = 'Organizations->Organization List'
ls_screen_name[23] = 'Organizations->Address'
ls_screen_name[24] = 'Organizations->Notes'
ls_screen_name[25] = 'Organizations->Organization Contacts'
ls_screen_name[26] = 'Fee Schedules->Browse Tab->Fee Schedules'
ls_screen_name[27] = 'Fee Schedules->Browse Tab->Fee Schedule Locations'
ls_screen_name[28] = 'Fee Schedules->Browse Tab->Fees'
ls_screen_name[29] = 'Fee Schedules->Browse Tab->Providers'
ls_screen_name[30] = 'Fee Schedules->Notes Tab->User Defined data'
ls_screen_name[31] = 'Fee Schedule (NM)->Fee Schedule (Non Healthcare)'
ls_screen_name[32] = 'Document Manager->Document Tab->Search Criteria'
ls_screen_name[33] = 'Action Items->Action Item List'
ls_screen_name[34] = 'QRG->Select Data Tab->Report Profiles'
ls_screen_name[35] = 'QRG->Select Data Tab->Basic Information to Include'
ls_screen_name[36] = 'QRG->Select Data Tab->Contract Contact Information to Include'
ls_screen_name[37] = 'QRG->Select Data Tab->Precertifications Requirements'
ls_screen_name[38] = 'QRG->Select Data Tab->Authorizations Requirements'
ls_screen_name[39] = 'QRG->Select Data Tab->Fee Schedule Data to Include'
ls_screen_name[40] = 'QRG->Select Data Tab->Organization Types to Include'
ls_screen_name[41] = 'QRG->Select Data Tab->Requirements to Include'
ls_screen_name[42] = 'Action Items->Action Item Browse'
ls_screen_name[43] = 'Details->Linked Contracts Tab->Linked Contracts'
ls_screen_name[44] = 'Document Manager->Document Tab->Document Browse'
ls_screen_name[45] = 'Document Manager->Work Flow Tab->Search Criteria'
ls_screen_name[46] = 'Document Manager->Work Flow Tab->Action Item Browse'
ls_screen_name[47] = 'Document Manager->Work Flow Tab->Action Item Detail'
ls_screen_name[48] = 'Document Manager->Audit Trail Tab->Search Criteria'
ls_screen_name[49] = 'Document Manager->Audit Trail Tab->Document Browse'
ls_screen_name[50] = 'Details->Group Access Tab->Group Access' //Added by Ken.Guo on 2009-02-10
ls_screen_name[51] = 'Document Manager->Document Tab->Added Document Properties'			//Added by Scofield on 2010-04-20
ls_screen_name[52] = 'Document Manager->Document Tab->Created Document Properties'		//Added by Scofield on 2010-04-20
ls_screen_name[53] = 'Custom Multi->Header->Header'
ls_screen_name[54] = 'Custom Multi->Detail->Browse'
ls_screen_name[55] = 'Custom Multi->Detail->Detail'

ls_screen_name[56] ='Document Manager->Document Tab->Document Browse'//add by gavins 20120131
ls_screen_name[57] ='Document Manager->Document Tab->Document History'
ls_screen_name[58] ='Email Manager->'																			//Added By Mark Lee 02/04/2013

ls_dw_name[1] = 'dw_search'
ls_dw_name[2] = 'dw_search_det1'
ls_dw_name[3] = 'dw_1'
ls_dw_name[4] = 'dw_products'
ls_dw_name[5] = 'dw_contract_dates'
ls_dw_name[6] = 'dw_ccc'
ls_dw_name[7] = 'dw_occ'
ls_dw_name[8] = 'dw_1'
ls_dw_name[9] = 'dw_1'
ls_dw_name[10] = 'dw_1'
ls_dw_name[11] = 'dw_2'
ls_dw_name[12] = 'dw_req_det'
ls_dw_name[13] = 'dw_req_det'
ls_dw_name[14] = 'dw_search'
ls_dw_name[15] = 'dw_detail'
ls_dw_name[16] = 'dw_phone'
ls_dw_name[17] = 'dw_notes'
ls_dw_name[18] = 'dw_main'
ls_dw_name[19] = 'dw_detail'
ls_dw_name[20] = 'dw_doctors'
ls_dw_name[21] = 'dw_spec'
ls_dw_name[22] = 'dw_search'
ls_dw_name[23] = 'dw_main'
ls_dw_name[24] = 'dw_notes'
ls_dw_name[25] = 'dw_contacts'
ls_dw_name[26] = 'dw_main'
ls_dw_name[27] = 'dw_locations'
ls_dw_name[28] = 'dw_fee_schedule'
ls_dw_name[29] = 'dw_codes'
ls_dw_name[30] = 'dw_1'
ls_dw_name[31] = 'dw_fee_nm'
ls_dw_name[32] = 'dw_filter'
ls_dw_name[33] = 'dw_1'
ls_dw_name[34] = 'dw_profile'
ls_dw_name[35] = 'dw_basic_info'
ls_dw_name[36] = 'dw_contact_info'
ls_dw_name[37] = 'dw_precert'
ls_dw_name[38] = 'dw_auth'
ls_dw_name[39] = 'dw_1'
ls_dw_name[40] = 'dw_2'
ls_dw_name[41] = 'dw_requirements'
ls_dw_name[42] = 'dw_1'
ls_dw_name[43] = 'dw_1'
ls_dw_name[44] = 'dw_browse'
ls_dw_name[45] = 'dw_filter'
ls_dw_name[46] = 'dw_browse'
ls_dw_name[47] = 'dw_detail'
ls_dw_name[48] = 'dw_filter'
ls_dw_name[49] = 'dw_browse'
ls_dw_name[50] = 'dw_1' //Added by Ken.Guo on 2009-02-10
ls_dw_name[51] = 'dw_1'	//Added by Scofield on 2010-04-20
ls_dw_name[52] = 'dw_1'	//Added by Scofield on 2010-04-20
ls_dw_name[53] = 'dw_header'
ls_dw_name[54] = 'dw_browse'
ls_dw_name[55] = 'dw_detail'
ls_dw_name[56] = 'dw_browse' //add by gavins 20120131
ls_dw_name[57] = 'dw_detail'
ls_dw_name[58] = ''										//Added By Mark Lee 02/04/2013

ls_dataobject[1] = 'd_contract_search'
ls_dataobject[2] = 'd_sp_contract_search'
ls_dataobject[3] = 'd_contract_det_master'
ls_dataobject[4] = ''
ls_dataobject[5] = 'd_contract_det_master_2'
ls_dataobject[6] = ''
ls_dataobject[7] = ''
ls_dataobject[8] = 'd_contract_det_notes'
ls_dataobject[9] = 'd_contract_det_custom'
//ls_dataobject[10] = 'd_view_audit2_ctx'
ls_dataobject[10] = 'd_contract_det_custom_2'
ls_dataobject[11] = ''
ls_dataobject[12] = 'd_contract_profile_req2'
ls_dataobject[13] = 'd_contract_profile_req_existing'
ls_dataobject[14] = 'd_contract_det_contact_contact'
ls_dataobject[15] = 'd_contract_det_contact_contact_det'
ls_dataobject[16] = ''
ls_dataobject[17] = 'd_contract_det_contact_contact_notes'
ls_dataobject[18] = ''
ls_dataobject[19] = 'd_contract_group_linked_locations'
ls_dataobject[20] = ''
ls_dataobject[21] = ''
ls_dataobject[22] = ''
ls_dataobject[23] = 'd_org_tabpg'
ls_dataobject[24] = 'd_org_notes'
ls_dataobject[25] = ''
ls_dataobject[26] = ''
ls_dataobject[27] = ''
ls_dataobject[28] = ''
ls_dataobject[29] = ''
ls_dataobject[30] = 'd_ctx_schedule_fee_notes'
ls_dataobject[31] = 'd_contract_fee_sched_nm'
ls_dataobject[32] = 'd_dm_browse_filter'
ls_dataobject[33] = 'd_cntx_action_items'
ls_dataobject[34] = 'd_report_hdr'
ls_dataobject[35] = ''
ls_dataobject[36] = ''
ls_dataobject[37] = ''
ls_dataobject[38] = ''
ls_dataobject[39] = ''
ls_dataobject[40] = ''
ls_dataobject[41] = 'd_contract_profile_req_questions'
ls_dataobject[42] = ''
ls_dataobject[43] = 'd_sp_contract_search'
ls_dataobject[44] = 'd_dm_doc_tree'
ls_dataobject[45] = 'd_dm_ai_filter'
ls_dataobject[46] = ''
ls_dataobject[47] = 'd_dm_doc_ai_detail'
ls_dataobject[48] = 'd_dm_audit_filter'
ls_dataobject[49] = ''
ls_dataobject[50] = ''	//Added by Ken.Guo on 2009-02-10
ls_dataobject[51] = 'd_dm_new_buy_document'			//Added by Scofield on 2010-04-20
ls_dataobject[52] = 'd_dm_new_sell_document'			//Added by Scofield on 2010-04-20
ls_dataobject[53] = 'd_contract_multi_header'	
ls_dataobject[54] = 'd_contract_multi_browse'	
ls_dataobject[55] = 'd_contract_multi_detail'	
ls_dataobject[56] = ''	//add by gavin 20120131
ls_dataobject[57] = ''	
ls_dataobject[58] = ''												//Added By Mark Lee 02/04/2013

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05.28.2008 by Andy
ls_ForceUpdates[UpperBound(ls_dataobject[])] = ""
ls_ForceUpdates[1]  = "category.dddw.name='d_dddw_user_access_category' app_facility.tabsequence=32766 app_facility.x='3803' app_facility.y='68' app_facility.height='60' app_facility.width='594' app_facility.visible='0' app_facility_t.x='3803' app_facility_t.y='12' app_facility_t.height='52' app_facility_t.width='489' app_facility_t.visible='0' facility_name_t.visible='1' facility_name.visible='1' facility_name.dddw.name='dddw_contact_company_search' facility_name.dddw.displaycolumn='facility_name' facility_name.dddw.datacolumn='facility_name' facility_name.dddw.percentwidth=200 b_clear.visible='1' b_more.visible='1' " + &
" ctx_id.dddw.name='d_dddw_ctx_ids' ctx_id.dddw.displaycolumn='ctx_id' ctx_id.dddw.datacolumn='ctx_id' ctx_id.dddw.percentwidth=150  ctx_id.dddw.allowedit=yes ctx_id.dddw.useasborder=yes  ctx_id.dddw.nilisnull=yes ctx_id.dddw.hscrollbar=yes ctx_id.dddw.vscrollbar=yes ctx_id.dddw.autoretrieve=no" //added by gavins 20130426
//ls_ForceUpdates[2]  = "p_2.visible=~"1~~tif( style ='-' and  master_cnt  >0,1,0) ~" p_1.visible=~"1~~tif( style ='+' and  master_cnt  >0,1,0) ~" "
//ls_ForceUpdates[2]  = "p_2.visible='0' p_1.visible='0'  "
ls_ForceUpdates[6]  = "contact_phone.format='[general]' contact_phone.edit.limit=0 contact_phone.edit.case=any contact_phone.edit.focusrectangle=no contact_phone.edit.autoselect=no " // contact_phone.edit.imemode=0 " //Commented By Ken.Guo 05/29/2013. do not support imemode for Web
ls_ForceUpdates[7]  = "contact_type.visible = 0 contact_type_t.visible = 0 association.Visible = 1 association_t.Visible = 1 contact_phone.format='[general]' contact_phone.edit.limit=0 contact_phone.edit.case=any contact_phone.edit.focusrectangle=no contact_phone.edit.autoselect=no " // contact_phone.edit.imemode=0 "
ls_ForceUpdates[8]  = "notes.edit.autohscroll=no " 			//Alfee 06.17.2008
ls_ForceUpdates[11] = "rqmnt_name.DDDW.UseAsBorder='no' destroy b_add "	//Added by Scofield on 2009-06-23
ls_ForceUpdates[12] = "category_name_t.visible = '0' gb_1.background.mode='1' gb_1.background.color='553648127' p_1.visible=~"1~~tif( value_type =  5,1,0)~" "
ls_ForceUpdates[13] = "gb_1.background.mode='1' gb_1.background.color='553648127' t_1.visible='0' DataWindow.Detail.Height='118' DataWindow.Detail.Height.AutoSize='No' clause.visible = '0' b_1.visible = '0' category_name.visible='1' p_1.visible=~"1~~tif( value_type =  5,1,0)~" "
ls_ForceUpdates[15] = "app_facility_street_1.visible='1' app_facility_street_2.visible='1' app_facility_street_3.visible='1' app_facility_city.visible='1' app_facility_state.visible='1' app_facility_zip.visible='1' ctx_contacts_street_1.visible='0' ctx_contacts_street_2.visible='0' ctx_contacts_street_3.visible='0' ctx_contacts_city.visible='0' ctx_contacts_state.visible='0' ctx_contacts_zip.visible='0' ctx_contacts_state_t.visible='0' ctx_contacts_state_t.x='1065'  ctx_contacts_state_t.y='1148' ctx_contacts_zip_t.visible='0' ctx_contacts_zip_t.x='1669' ctx_contacts_zip_t.y='1148' app_facility_state_t.visible='1'  app_facility_zip_t.visible='1' "
ls_ForceUpdates[16] = "phone.format='[general]' phone.edit.limit=0 phone.edit.case=any phone.edit.focusrectangle=no phone.edit.autoselect=no " // phone.edit.imemode=0 "
ls_ForceUpdates[25] = "phone.format='[general]' phone.edit.limit=0 phone.edit.case=any phone.edit.focusrectangle=no phone.edit.autoselect=no " // phone.edit.imemode=0 "
ls_ForceUpdates[27] = "location.tag='Contract Local Code' location.dddw.name='d_dddw_location' location.dddw.displaycolumn='local1' location.dddw.datacolumn='local' "
ls_ForceUpdates[32] = "b_close.Visible = 1 doc_type.dddw.useasborder=yes doc_type.tag='Contract Document Type' doc_type.dddw.name='d_dddw_code_lookup_doc_type' doc_type.dddw.displaycolumn='code' doc_type.dddw.datacolumn='code' doc_type.dddw.percentwidth=300 doc_type.dddw.lines=20 doc_type.dddw.vscrollbar=yes doc_type.dddw.allowedit=yes"  //modified by gavins 20130412

//Added By Mark Lee 05/28/2013 return the code.
ls_ForceUpdates[33] = "compute_1.Expression=~"wordcap(if( isnull(document_name), if(len(alm_action_title) >0, alm_action_title, action_description) , left(document_name,len( document_name ) - 4)  + ' - ' +  if(len(alm_action_title) >0, alm_action_title, action_description) ))~" action_type.dddw.name='d_dddw_code_lookup' action_type.dddw.displaycolumn='custom_1' action_type.dddw.datacolumn='lookup_code' action_type.dddw.percentwidth=275 " + &
								" action_type.protect='0~~tif((not isnull(wf_id)) or  active_status < 0 ,1,0)' " + &
								" action_user.protect='0~~tif(active_status < 0 ,1,0)' " + &
								" action_date.protect='0~~tif(active_status < 0 ,1,0)' " + &
								" due_date.protect='0~~tif(active_status < 0 ,1,0)' " + &
								" notes.protect='0~~tif(active_status < 0 ,1,0)' " + &
								" action_status.protect='0~~tif( wf_complete_flag = ~~'Y~~' or active_status < 0,1,0)' " + &
								" wf_assigned_by.protect='0~~tif(active_status < 0 ,1,0)' " + &
								" inserted_at_date_time.protect='0~~tif(active_status < 0 ,1,0)' " 
//ls_ForceUpdates[43] = "p_2.visible='1~~tif( style =~~'-~~' and  master_cnt  >0,1,0) ' p_1.visible='1~~tif( style =~~'+~~' and  master_cnt  >0,1,0) ' "
ls_ForceUpdates[45] = "DataWindow.Detail.Height='248' b_close.Visible = 1"						//Added by Scofield on 2010-03-30
ls_ForceUpdates[46] = "wf_assigned_by.visible='1' wf_assigned_by_t.visible='1' " //Add by Evan on 03.31.2008
ls_ForceUpdates[47] = "b_print.visible=~"1~~tif(active_status < 0 or readonly_flag = 1,0,if(wf_id > 0 and print_flag < 1 and f_get_gb_workflow(),0,if((wf_id <= 0 or Not f_get_gb_workflow()) and (isnull(code_lookup_custom_6) or trim(code_lookup_custom_6) = ~~~"~~~" ),0,1)))~" b_notes.visible=~"1~~tif(active_status < 0,0,1)~" " //Delete " or  readonly_flag = 1 or wf_complete_flag = 'Y'" - jervis 02.21.2011
ls_ForceUpdates[48] = "b_close.Visible = '1' b_me.Visible = '1'"
ls_ForceUpdates[52] = "doc_type.tag='Contract Document Type' doc_type.dddw.name='d_dddw_code_lookup_doc_type' doc_type.dddw.displaycolumn='code' doc_type.dddw.datacolumn='code' doc_type.dddw.percentwidth=300 doc_type.dddw.lines=20 doc_type.dddw.vscrollbar=yes " //Added By Ken.Guo 2011-04-01.

//---------------------------- APPEON END ----------------------------

//Added By Ken.Guo 12/15/2011. only for default view 1001
ls_ForceUpdates1001[UpperBound(ls_dataobject[])] = ""
ls_ForceUpdates1001[2] = 'object_related.visible = "1" '
/*******************************************///added by gavins 20120305 grid
ls_GridDataObject[ UpperBound( ls_dataobject[] )]=""
//
ls_GridDataObject[2]= 'd_sp_contract_search_grid'
ls_GridDataObject[4] = 'd_ctx_products'
ls_GridDataObject[6] = 'd_contract_det_contact_external'
ls_GridDataObject[7] = 'd_contract_det_contact_external'
ls_GridDataObject[11] = 'd_profile_header'
//
ls_GridDataObject[14] = 'd_contract_det_contact_contact_gd'
ls_GridDataObject[16] = 'd_contract_det_contact_contact_phone'
ls_GridDataObject[18] = 'd_contract_multi_group_browse'
ls_GridDataObject[20] = 'd_contract_group_practitioners_existing'
ls_GridDataObject[21] = 'd_cntx_location_spec'
ls_GridDataObject[22] = 'd_org_search2'
ls_GridDataObject[25] = 'd_org_contacts'
ls_GridDataObject[26] = 'd_ctx_free_sched_hdr'
ls_GridDataObject[27] = 'd_ctx_schedule_fee_locations'
ls_GridDataObject[28] = 'd_ctx_schedule_fee_detail'
ls_GridDataObject[29] = 'd_ctx_schedule_fee_pracs'
ls_GridDataObject[35] = 'd_qrg_sys_fields'
ls_GridDataObject[36] = 'd_qrg_sys_fields'
ls_GridDataObject[37] = 'd_profile_codes'
ls_GridDataObject[38] = 'd_profile_codes'
ls_GridDataObject[39] = 'd_qrg_sys_fields'
ls_GridDataObject[40] = 'd_profile_codes'
ls_GridDataObject[42] = 'd_cntx_action_items_browse'
//
ls_GridDataObject[43]= 'd_sp_contract_search_grid'
ls_GridDataObject[46] = 'd_dm_doc_ai_browse'
ls_GridDataObject[49] = 'd_dm_doc_audit_browse'
ls_GridDataObject[50] = 'd_contract_det_group_access'	
//
ls_GridDataObject[54]= 'd_contract_multi_browse_gd'
ls_GridDataObject[56] = 'd_dm_doc_tree'	
ls_GridDataObject[57] = 'd_dm_doc_tree_detail'	


ls_ScreenStyle[ UpperBound( ls_dataobject[] )]=""
ls_ScreenStyle[2] = 'F'
ls_ScreenStyle[4] = 'G'
ls_ScreenStyle[6] = 'G'
ls_ScreenStyle[7] = 'G'
ls_ScreenStyle[11] = 'G'
ls_ScreenStyle[14] = 'F'
ls_ScreenStyle[16] = 'G'
ls_ScreenStyle[18] = 'G'
ls_ScreenStyle[20] = 'G'
ls_ScreenStyle[21] = 'G'
ls_ScreenStyle[22] = 'G'
ls_ScreenStyle[25] = 'G'
ls_ScreenStyle[26] = 'G'
ls_ScreenStyle[27] = 'G'
ls_ScreenStyle[28] = 'G'
ls_ScreenStyle[29] = 'G'
ls_ScreenStyle[35] = 'G'
ls_ScreenStyle[36] = 'G'
ls_ScreenStyle[37] = 'G'
ls_ScreenStyle[38] = 'G'
ls_ScreenStyle[39] = 'G'
ls_ScreenStyle[40] = 'G'
ls_ScreenStyle[42] = 'G'
ls_ScreenStyle[43] = 'F'
ls_ScreenStyle[46] = 'G'
ls_ScreenStyle[49] = 'G'
ls_ScreenStyle[50] = 'G'
ls_ScreenStyle[54] = 'F'
ls_ScreenStyle[56] = 'G'
ls_ScreenStyle[57] = 'G'

ls_NeedModify[ UpperBound( ls_dataobject[] )]=""
ls_NeedModify[2] = 'Y'
ls_NeedModify[14] = 'Y'
ls_NeedModify[43] = 'Y'
ls_NeedModify[54] = 'Y'

/*******************************************///added by gavins 20120314 backup screen
//n_cst_update_data  lnv_data
n_cst_update_data_clx  lnv_data //(Appeon)Alfee 01.21.2014 - V142 ISG-CLX
//lnv_data = Create n_cst_update_data
lnv_data = Create n_cst_update_data_clx  //(Appeon)Alfee 01.21.2014 - V142 ISG-CLX

lnv_data.of_backup_allscreen( )

If IsValid( lnv_data ) Then Destroy( lnv_data )

/*******************************************///added by gavins 20120521 optimize upgrade
lb_update_falg = true
/*******************************************/
li_num = UpperBound(ls_tab_name)
ll_count = lds_sql.RowCount()
IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
IF IsValid(w_infodisp) THEN w_infodisp.Title = 'Update screen of view'
IF IsValid(w_infodisp) THEN w_infodisp.Center = True
IF IsValid(w_infodisp) THEN w_infodisp.st_complete.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_3.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_information.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'Update screen of view, Please stand by!'
IF IsValid(w_infodisp) THEN w_infodisp.wf_set_min_max(1,li_num)
FOR i = 1 To li_num
	if i = 48 or i = 49 or i = 44 then continue //modified by gavins 20120319 grid   add 44
	
	Yield()
	IF IsValid(w_infodisp) THEN
		w_infodisp.wf_step_pbar(1)
		w_infodisp.st_1.Text = 'Modification ' + String(i) + ' of ' + String(li_num)+', Please stand by!'
	END IF
	
	/*******************************///added by gavins 20120305 grid
	lb_GridExists = False
	if Not( IsNull( ls_GridDataObject[i]  ) Or Trim( ls_GridDataObject[i]  ) = ''  ) Then lb_GridExists = True 
	/*******************************/
	
	lds_source.dataobject = ls_dataobject[i]
	lds_source.settransobject(sqlca)

	//Modified By Ken.Guo 2011-01-20	
	//ll_find = lds_sql.Find("dataobject = '" + ls_dataobject[i] + "'" + " and screen_name = '" + ls_screen_name[i] + "'", 1 , ll_count)
	ll_find = lds_sql.Find("screen_id = " + String(i), 1 , ll_count)

	IF ll_find > 0 THEN
		IF lb_update_falg THEN //Update All Screen syntax
		/**********************************///added by gavins 20120305 grid
			If lb_GridExists Then
				li_Cycle = 2
			Else
				li_Cycle = 1
			End If
		/**********************************/
				DO
					ll_view_id = lds_sql.GetItemNumber(ll_find,"data_view_id")
					ll_screen_id = lds_sql.GetItemNumber(ll_find,"screen_id")
					lds_pic.Retrieve( ll_view_id,ll_screen_id)

					ii_Screen_ID = ll_screen_id
								
					
					 For li_k = 1 To li_Cycle
						Yield()
						//Update Screen syntax
										
						/************************************///added by gavins 20120305 grid
						If ( IsNull( ls_dataobject[i] ) Or Trim( ls_dataobject[i] ) = '' ) and li_k = 1 Then 
							lstr_syntax[ll_view_id].as_syntax[ll_screen_id] = ""
							lstr_syntax[ll_view_id].as_fieldlist[ll_screen_id] = ""  //jervis 10.18.2011
							lstr_syntax[ll_view_id].as_gridsyntax[ll_screen_id] = ""
							lstr_syntax[ll_view_id].as_gridfieldlist[ll_screen_id] =""
							Continue
						End If
						If li_k = 2 Then
							lds_source.dataobject = ls_GridDataObject[i]	
						Else
							lds_source.DataObject = ls_dataobject[i]
						End If
						/************************************/
						lds_source.SetTransObject(sqlca)
									
						//Added By Ken.Guo 2011-02-28.
						IF IsValid(w_infodisp) THEN
							w_infodisp.st_1.Text = 'Modification ' + String(i) + ' of ' + String(li_num) + '(View ID = ' + String(ll_view_id)  +'), Please stand by!'
						END IF				
						/********************///added by gavins 20120305 grid
							
						IF appeongetclienttype() = 'PB' THEN
							If li_k = 2 Then
								ls_sql = f_get_screen_gridsql(ll_view_id,ll_screen_id,false)  
							Else
								ls_sql = f_get_screen_sql(ll_view_id,ll_screen_id,false)  //add false argu - jervis 10.11.2011
							End If
						ELSE
							If li_k = 2 Then
								ls_sql = lds_sql.GetItemString(ll_find,"grid_sql")
							Else
								ls_sql = lds_sql.GetItemString(ll_find,"dw_sql")
							End If
						END IF

									
						if ( isnull( ls_sql ) or len( ls_sql ) = 0 ) then continue
						/********************/					
	
						lds_target.Create( ls_sql )
	
						ls_sObjects  = lds_target.Describe("DataWindow.Objects")
						inv_string.of_parsetoarray(ls_sObjects,'~t',ls_Column[])
							
						For li_a = 1 To Upperbound( ls_Column[] )
							ls_Type = lds_target.Describe( ls_Column[li_a] + ".type" )
							If  ( lower(ls_Type) = 'bitmap' ) and Left(ls_Column[li_a], 6) = 'object'   Then  
								ls_originalFile = lds_target.describe(  ls_Column[li_a] + ".filename" )
								ls_filename = Mid( ls_originalFile, LastPos( ls_originalFile, '\' ) + 1 )
								ll_FRow = lds_pic.Find( "pic_name = '" + ls_Column[li_a] +"'", 1, lds_pic.Rowcount( ) )
												
								If Not FileExists( ls_Path + ls_filename ) and ll_FRow <= 0 and lower(ls_filename) <> 'stop.bmp'Then
									
									If FileExists( ls_originalFile ) Then
										lnv_filesrv.of_fileread( ls_originalFile, ref lb_file)
										If len( lb_file ) > 0 Then
											ll_x = long( lds_target.describe(  ls_Column[li_a] + ".x" )			)
											ll_y = long ( lds_target.describe(  ls_Column[li_a] + ".y" )			 )
											ls_band =  lds_target.describe(  ls_Column[li_a] + ".band" )
											insert into conv_view_pic ( view_id
																		,Screen_id
																		,pic_type
																		,pic_band
																		,pic_name
																		,pic_filename
																		,pic_x
																		,pic_y
																		,pic_width
																		,pic_height
																		 )
																		 values( :ll_view_id,
																			 :ll_screen_id, 
																			 "screen",
																			 :ls_band, 
																			 :ls_Column[li_a], 
																			  substring( :ls_filename,1,2 ) + cast( :ll_view_id as varchar(10))  + '_' + cast( :ll_screen_id as varchar(10)) +
																			substring( :ls_filename, charindex( '_',:ls_filename, charindex( '_',:ls_filename, 3 ) + 1 ),99)
																			  ,:ll_x
																			  ,:ll_y
																			  ,0
																			  ,0
																		  );
											Updateblob conv_view_pic set pic_bitmap = :lb_file where pic_name =  :ls_Column[li_a];
											if sqlca.sqlcode < 0 then	
												MessageBox( 'Tips',  "n_cst_update_screen.of_appeon2_changes() Information: UPDATEBLOB failed, call support."  + SQLCA.sqlerrtext + "~r~n" )
												Rollback;
												lb_Error = true //added by gavins 20120524
											else 
												commit;
											end if								
										end if
									Else
										lds_target.Modify( ls_Column[li_a] + ".filename ='stop.bmp'")							 
									End If									
								Else
									ls_pictype = lds_pic.getitemstring( ll_FRow, 'pic_type' )
									ll_datalen = 0
									select datalength(pic_bitmap) into :ll_datalen from conv_view_pic where pic_name = :ls_Column[li_a] and view_id =:ll_view_id and screen_id = :ll_screen_id and pic_type=:ls_pictype;
									If ll_datalen = 0 or isnull(ll_datalen) then
										lds_target.Modify( ls_Column[li_a] + ".filename ='stop.bmp'")				
									End If
									
								End If								
							End If
						Next
						ls_sql = lds_target.Describe( "datawindow.syntax" )
	
						/************************///added by gavins 20120305 grid
						If li_k = 2 Then
							lstr_syntax[ll_view_id].as_gridsyntax[ll_screen_id] = ls_sql
						Else
							lstr_syntax[ll_view_id].as_syntax[ll_screen_id] = ls_sql
							lstr_syntax[ll_view_id].as_gridsyntax[ll_screen_id] = ""
							lstr_syntax[ll_view_id].as_gridfieldlist[ll_screen_id] =""
						End If					
						/************************/		
						//lds_sql.setitem(ll_find,'modify_date',today())	APB Bug,need use datetime convert 08.04.2007
						lds_sql.SetItem(ll_find,'modify_date',DateTime(Today(),Now()))			
						
						ls_sql = ""
					Next//	
					IF ll_find = ll_count THEN EXIT
					/************************///added by gavins 20120305 grid
//					If li_k = 2 Then
//						ll_find = lds_sql.Find("grid_dataobject = '" + ls_GridDataObject[i] + "'" + " and screen_name = '" + ls_screen_name[i] + "'", ll_find + 1 , ll_count)
//					Else
//						ll_find = lds_sql.Find("dataobject = '" + ls_dataobject[i] + "'" + " and screen_name = '" + ls_screen_name[i] + "'", ll_find + 1 , ll_count)
//					End If
					ll_find = lds_sql.Find("screen_id = " + String(i),  ll_find + 1 , ll_count)
					/************************/
				LOOP While (ll_find > 0)	
		ELSE
			//update sql when update = 1 and version > number of current version
		END IF
		
		

	END IF
	
NEXT

//$<modify> 03.12.2008 by Andy
/*
IF lds_sql.Update() <> 1 THEN
	ii_num++
	IF ii_num < 3 THEN
		of_appeon2_changes()
	END IF
END IF
ii_num = 1
*/


if lds_sql.Update() <> 1 then
	ls_Error= "n_cst_update_screen.of_appeon2_changes() Information: lds_sql.Update() failed, call support." 
	IF IsValid(gnv_logservice)THEN 
		gnv_logservice.of_setloglevel(2) //warning level
		gnv_logservice.of_log_warning(ls_Error)
	END IF	
	Rollback;
	lb_Error = true //added by gavins 20120524
else
	COMMIT;
end if
//end of modify 03.12.2008

//$<Add> 03.12.2008 by Andy
//Reason:When syntax length more than 32766,Update will failed in ASA DB in WEB 
blob lblob_syntax,lblob_opsyntax
string ls_opsyntax,ls_lookuplist, ls_Modify
ll_count = lds_sql.Rowcount( )
IF IsValid(w_infodisp) THEN w_infodisp.Title = 'Update syntax of view'
IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'Update syntax of view, Please stand by!'
IF IsValid(w_infodisp) THEN w_infodisp.wf_set_min_max(1,ll_count)
FOR i = 1 to ll_count
	Yield()	
	
	ll_view_id   = lds_sql.GetItemNumber(i,"data_view_id")
	ll_screen_id = lds_sql.GetItemNumber(i,"screen_id")
	ls_Modify = lds_sql.GetItemString(i,"grid_modify") //add by gavins 20120305 grid
	//PB Bug,When syntax length more than 32766, Get error -- jervis 05.18.2011
	//ls_sql       = lds_sql.GetitemString(i,"dw_sql")
	//lblob_syntax = blob(ls_sql)
	IF IsValid(w_infodisp) THEN
		w_infodisp.wf_step_pbar(1)
		w_infodisp.st_1.Text = 'Modification ' + String(i) + ' of ' + String(ll_count)+'(View ID = ' + String(ll_view_id)  +' ,Screen ID = ' + string(ll_screen_id ) + ' ), Please stand by!'
	END IF
	
	/**********************************/
	If Not( IsNull( lstr_syntax[ll_view_id].as_gridsyntax[ll_screen_id]  ) Or Trim( lstr_syntax[ll_view_id].as_gridsyntax[ll_screen_id]  ) = '' ) Then
		lb_GridExists = True
		li_cycle = 2
	Else
		li_Cycle = 1
	End If
	/**********************************/	
	ls_error = ""
	For li_k = 1 To li_Cycle
		If li_k = 1 Then
			//if the freeform is not exists  the grid must exists.
			If 	IsNull( lstr_syntax[ll_view_id].as_syntax[ll_screen_id] ) Or Trim( lstr_syntax[ll_view_id].as_syntax[ll_screen_id] ) = '' Then Continue //added by gavins 20120319 grid 
			lblob_syntax = blob(lstr_syntax[ll_view_id].as_syntax[ll_screen_id] )
			ls_opsyntax = ""
			ls_lookuplist = ""

			//get opsyntax -jervis 10.18.2011
			gf_get_opsyntax(lstr_syntax[ll_view_id].as_syntax[ll_screen_id] ,lstr_syntax[ll_view_id].as_fieldlist[ll_screen_id],ls_opsyntax,ls_lookuplist)
			ls_SQL = ls_opsyntax
			lblob_opsyntax = blob(ls_opsyntax)
		
			UPDATEBLOB ctx_screen SET dw_sql = :lblob_syntax   WHERE data_view_id = :ll_view_id 	AND screen_id = :ll_screen_id;
			if sqlca.sqlcode < 0 then	
				ls_Error= "n_cst_update_screen.of_appeon2_changes() Information: UPDATEBLOB failed, call support."  + SQLCA.sqlerrtext + "~r~n"
				Rollback;
				lb_Error = true //added by gavins 20120524
			else 
				commit;
			end if

			UPDATEBLOB ctx_screen SET dw_opsql = :lblob_opsyntax WHERE data_view_id = :ll_view_id 	AND screen_id = :ll_screen_id;
			if sqlca.sqlcode < 0 then	
				ls_Error+= "n_cst_update_screen.of_appeon2_changes() Information: UPDATEBLOB failed, call support."  + SQLCA.sqlerrtext + "~r~n"
				Rollback;
				lb_Error = true //added by gavins 20120524
			else 
				commit;
			end if
		
		
		Else// grid
			lblob_syntax = blob(lstr_syntax[ll_view_id].as_Gridsyntax[ll_screen_id] )
			ls_opsyntax = ""
			ls_lookuplist = ""
			ls_Error = ''
			//get opsyntax -jervis 10.18.2011
			gf_get_opsyntax(lstr_syntax[ll_view_id].as_gridsyntax[ll_screen_id] ,lstr_syntax[ll_view_id].as_gridfieldlist[ll_screen_id],ls_opsyntax,ls_lookuplist)
			
//			If ls_Modify = 'Y' Then//add by gavins 20120305 grid
//				of_ModifyDataWindow( ls_SQL, ls_opsyntax, 'grid' )//freeform to grid 				
//			End If
			
			lblob_opsyntax = blob(ls_opsyntax)
		
			UPDATEBLOB ctx_screen SET grid_sql = :lblob_syntax    WHERE data_view_id = :ll_view_id 	AND screen_id = :ll_screen_id;
			if sqlca.sqlcode < 0 then	
				ls_Error= "n_cst_update_screen.of_appeon2_changes() Information: UPDATEBLOB failed, call support."  + SQLCA.sqlerrtext + "~r~n"
				Rollback;
				lb_Error = true //added by gavins 20120524
			else 
				commit;
			end if

			UPDATEBLOB ctx_screen SET grid_opsql = :lblob_opsyntax WHERE data_view_id = :ll_view_id 	AND screen_id = :ll_screen_id;
			if sqlca.sqlcode < 0 then	
				ls_Error+= "n_cst_update_screen.of_appeon2_changes() Information: UPDATEBLOB failed, call support."  + SQLCA.sqlerrtext + "~r~n"
				Rollback;
				lb_Error = true //added by gavins 20120524
			else 
				commit;
			end if
		
			
		
			
		End If
		/**********************************/
	Next
next
//End of add 03.12.2008

//$<add> 11.08.2006 By: Davis
//$<reason> Fix a defect.


If isvalid(lds_sql) Then Destroy lds_sql
If isvalid(lds_source) Then Destroy lds_source
If isvalid(lds_target) Then Destroy lds_target
If isvalid(lds_properties) Then Destroy lds_properties
IF IsValid(w_infodisp) THEN Close(w_infodisp)

If lb_Error Then
		if ls_error <> "" then
				IF IsValid(gnv_logservice)THEN 
					gnv_logservice.of_setloglevel(2) //warning level
					gnv_logservice.of_log_warning(ls_Error)
						
				END IF
			end if
	MessageBox( 'Tips',  'Repair failed.' +  ls_error )
Else
	MessageBox( 'Tips', 'Repairs are completed!' )	
End If

end subroutine

on n_cst_update_screen.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_update_screen.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

