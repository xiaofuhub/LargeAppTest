$PBExportHeader$w_contract_data_design.srw
forward
global type w_contract_data_design from w_main
end type
type uo_design from pfc_cst_u_contract_data_design within w_contract_data_design
end type
end forward

global type w_contract_data_design from w_main
integer x = 5
integer y = 336
integer width = 4000
integer height = 2232
string title = "Screen Painter (Default System View)"
boolean resizable = false
windowstate windowstate = maximized!
long backcolor = 33551856
event pfc_cst_view_manager ( )
event pfc_cst_field_properties ( )
event pfc_cst_select_view ( )
event pfc_cst_new_screen_painter ( )
event pfc_cst_display_only ( )
event ue_rbuttondown ( )
event type integer ue_modify ( string as_modifytype )
event type string ue_setmodify ( string as_modify )
event type integer ue_selectmultiobject ( string as_type,  pfc_cst_u_band adw_band,  string as_name )
event ue_new ( string as_objtype )
event type integer ue_arrange ( string as_type )
event pfc_cst_batch_properties ( )
event pfc_cst_field_depend ( )
event pfc_cst_option ( )
event pfc_cst_restore ( )
uo_design uo_design
end type
global w_contract_data_design w_contract_data_design

type variables
//Boolean ib_disable_activate = FALSE

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-05 By: Andy
String  is_CurBand
boolean ib_PreparCopying=FALSE
string  is_CopySyntax=''

str_Selectobj	istr_SelectObj[]
string  is_CurSelectObj

String  is_AddObjectType
//string  is_NewObject[]

long	  ii_index=0

//String  is_OrgSyntax	- jervis 03.25.2009

long	  il_FirstSelectColor=15793151

boolean ib_cut = false

//---------------------------- APPEON END ----------------------------

long		il_SaveResult		//Added by Scofield on 2009-04-07
long		il_InitView_id

datastore ids_field_depend	//add by jervis 09.24.2009
end variables

forward prototypes
public function integer wf_preparecopy (pfc_cst_u_band adw_band)
public function integer wf_copyobject (pfc_cst_u_band adw_band)
public function long wf_isselected (string as_name)
public function integer wf_object_all_unselect ()
public function integer wf_addobject (string as_objtype, long al_x, long al_y)
public function integer wf_makeband (string as_syntax)
public function integer wf_selectmultiobj (keycode key, unsignedlong keyflags)
public subroutine wf_getband (string as_band)
end prototypes

event pfc_cst_view_manager();//BEGIN---Modify by Evan 07/15/2008
//Open( w_contract_data_views_manager )
OpenSheet(w_contract_data_views_manager, w_mdi, 4, Original!)
//END---Modify by Evan 07/15/2008
end event

event pfc_cst_field_properties();//BEGIN---Modify by Evan 07/24/2008
//uo_design.TriggerEvent( "ue_field_properties" )
uo_design.TriggerEvent("ue_properties")
//END---Modify by Evan 07/24/2008
end event

event pfc_cst_select_view;uo_design.TriggerEvent( "pfc_cst_select_view" )
end event

event pfc_cst_new_screen_painter;uo_design.TriggerEvent( "pfc_cst_new_screen_painter" )
end event

event pfc_cst_display_only();uo_design.of_set_display_only()
end event

event ue_rbuttondown();////--------------------------- APPEON BEGIN ---------------------------
////$<Modify> 2007-11-05 By: Andy
//
//m_screen_design_rmb  lm
//
//lm = create m_screen_design_rmb
//lm.item[1].popmenu(this.x+ this.pointerx()+ 20,this.y + this.pointery() + 250)
//
//destroy  lm
////---------------------------- APPEON END ----------------------------
end event

event type integer ue_modify(string as_modifytype);////--------------------------- APPEON BEGIN ---------------------------
////$<add> 2007-11-05 By: Andy
//string  ls_Name
//pfc_cst_u_band   ldw_band
//int   li_ret
//long  ll,ll_Count,ll_index,ll_Cnt
//
//ldw_band = wf_getband(is_CurBand)
//
//ls_Name = ldw_band.is_CurObj
//ll_Count = upperbound(istr_SelectObj[])
//CHOOSE CASE as_modifytype
//	CASE 'delete'
//		if ll_Count=0 then
//			IF ls_Name = '' THEN return -1
//			//$<Modify> 03.17.2008 by Andy
//			IF Pos(lower(ls_Name),"object") > 0 then
//				if messagebox("Alert","Are you sure you want to delete object "+ls_name+"?",Question!,yesno!,1)=2 then return -1
//				ldw_band.modify("destroy "+ls_Name)
//				ldw_band.of_unselectobj(ls_Name)
//				this.event ue_setmodify("destroy "+ls_Name)
//				
//				//Clear the object in the is_Objects[]
//				ll_Cnt = UpperBound(ldw_band.is_Objects)
//				FOR ll_index = 1 to ll_Cnt
//					if ldw_band.is_Objects[ll_index] = ls_Name then 
//						ldw_band.is_Objects[ll_index] = ""
//						exit
//					end if
//				NEXT
//			else
//				MessageBox("Clear Error", "You can't delete field or field label objects.  To hide these objects, set the Visible property in the properties dialog box to No.")
//			end if
//		else
//			if messagebox("Alert","Are you sure you want to delete the selected object?",Question!,yesno!,1)=2 then return -1
//			FOR ll = 1 TO ll_Count 
//				ldw_band = wf_getband(istr_SelectObj[ll].fband.is_bandtype)
//				ls_Name = istr_SelectObj[ll].fname
//				IF ls_Name = '' THEN return -1 
//				//$<Modify> 03.17.2008 by Andy
//				IF Pos(lower(ls_Name),"object") > 0 then
//					ldw_band.modify("destroy "+ls_Name)
//					ldw_band.of_unselectobj(ls_Name)
//					this.event ue_setmodify("destroy "+ls_Name)
//								
//					//Clear the object in the is_Objects[]
//					ll_Cnt = UpperBound(ldw_band.is_Objects)
//					FOR ll_index = 1 to ll_Cnt
//						if ldw_band.is_Objects[ll_index] = ls_Name then 
//							ldw_band.is_Objects[ll_index] = ""
//							exit
//						end if
//					NEXT
//				else
//					MessageBox("Clear Error", "You can't delete field or field label objects.  To hide these objects, set the Visible property in the properties dialog box to No.")
//					return -1
//				end if					
//			next
//		end if
//
//	CASE 'copy'
//		if ll_Count=0 then
//			IF ls_Name = '' THEN return -1 
//			wf_prepareCopy(ldw_band)
//		end if
//	CASE 'cut'
//		if ll_Count=0 then
//			IF ls_Name = '' THEN return -1 
//			ib_cut = true
//			li_ret = wf_prepareCopy(ldw_band)
//			IF li_ret > 0 THEN
//				//<Modify> 11/20/2007 by: Andy
//				//ldw_band.modify("destroy "+ls_Name)				
//				uo_design.uo_band.dw_header.modify("destroy "+ls_Name)
//				uo_design.uo_band.dw_detail.modify("destroy "+ls_Name)
//				uo_design.uo_band.dw_summary.modify("destroy "+ls_Name)
//				uo_design.uo_band.dw_footer.modify("destroy "+ls_Name)
//				
//				ldw_band.of_unselectobj(ls_Name)
//				this.event ue_setmodify("destroy "+ls_Name)
//				
//				//Clear the object in the is_Objects[]
//				ll_Cnt = UpperBound(ldw_band.is_Objects)
//				FOR ll = 1 to ll_Cnt
//					if ldw_band.is_Objects[ll] = ls_Name then 
//						ldw_band.is_Objects[ll] = ""
//						exit
//					end if
//				NEXT
//
//			END IF
//		end if
//	CASE 'paste'
//		if ll_Count=0 then
//			return wf_CopyObject(ldw_band)
//		end if
//		
//END CHOOSE
//
return 1
////---------------------------- APPEON END ----------------------------
//
end event

event type string ue_setmodify(string as_modify);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-06 By: Andy
string  ls_err

ls_err = uo_design.uo_band.dw_Syntax.modify(as_modify)

return ls_Err
//---------------------------- APPEON END ----------------------------
end event

event type integer ue_selectmultiobject(string as_type, pfc_cst_u_band adw_band, string as_name);////--------------------------- APPEON BEGIN ---------------------------
//
//// Function: ue_selectmultiobject()
////--------------------------------------------------------------------
//// Description:
////--------------------------------------------------------------------
//// Arguments:
//// 	value	string        	as_type 	
//// 	value	pfc_cst_u_band	adw_band	
//// 	value	string        	as_name 	
////--------------------------------------------------------------------
//// Returns:  
////--------------------------------------------------------------------
//// Author:	Andy		Date: Nov 06,2007
////--------------------------------------------------------------------
//// Modify History:
////
////====================================================================
//long   ll_Count,ll_Color,ll_Seq,ll
//str_Selectobj  lstr_Empty[]
//pfc_cst_u_band ldw_Band
//
//CHOOSE CASE  lower(as_type)
//	CASE 'mouse' 
//		ll_Seq = wf_isselected(as_name)
//		IF ll_Seq > 0 THEN 
//			istr_SelectObj[ll_Seq].fband.of_unselectobj(as_Name)
//			istr_SelectObj[ll_seq].FName = ''
//		ELSE 
//			ll_Count = Upperbound(istr_SelectObj) 
//			IF is_CurSelectObj <> '' AND ll_Count = 0 AND  is_CurSelectObj<> as_Name THEN
//				ll_Count ++
//				ldw_Band = wf_getband(uo_design.uo_band.dw_Syntax.describe(is_CurSelectObj+".band"))
//				istr_SelectObj[ll_Count].fband = ldw_band
//				istr_SelectObj[ll_Count].fname = is_CurSelectObj
//				ldw_band.of_selectobject(is_CurSelectObj)
//			END IF
//
//			ll_Count ++
//			istr_SelectObj[ll_Count].fband = adw_band
//			istr_SelectObj[ll_Count].fname = as_name
//			adw_band.of_selectobject(as_Name)
//		END IF
//		
//	CASE 'clear' 
//		wf_object_all_unselect()
//END CHOOSE
//
return 1
////---------------------------- APPEON END ----------------------------
//
end event

event ue_new(string as_objtype);////--------------------------- APPEON BEGIN ---------------------------
////$<add> 2007-12-03 By: Andy
////$<Reason> Fix a defect.
//if uo_design.ib_set_tab_order then return
//uo_design.st_add.visible = true
////---------------------------- APPEON END ----------------------------
//
//is_addobjectType = as_objtype
//
end event

event type integer ue_arrange(string as_type);//str_SelectObj   lstr_temp[]
//long   ll,ll_Count,ll_Upper
//long  ll_x,ll_y,ll_Width,ll_Height,ll_temp,ll_Bottom
//string  ls_Modify,ls_band
//long ll_linex1,ll_linex2,ll_liney1,ll_liney2
//
//ll_Count = Upperbound(istr_SelectObj)
//IF ll_Count < 1 THEN return -1
//FOR ll = 1  TO ll_Count
//	IF istr_SelectObj[ll].FName <> '' THEN
//		ll_Upper++
//		lstr_temp[ll_Upper] = istr_SelectObj[ll]
//	END IF
//NEXT
//
//ll_Count =  Upperbound(lstr_temp)
//IF ll_Count < 2 THEn return -1
//
//CHOOSE CASE lower(as_type)
//	CASE 'snap_to_left' 
//		IF uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".type") <> 'line' THEN 
//			ll_x = long(uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".x"))
//		else
//			ll_x = long(uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".x1"))
//		end if
//		FOR ll = 2 TO ll_Count
//			IF uo_design.uo_band.dw_syntax.describe(lstr_temp[ll].FName+".type") <> 'line' THEN 
//				ls_Modify = lstr_temp[ll].FName+".x=" + string(ll_x)
//			else
//				ll_linex1 = long(uo_design.uo_band.dw_syntax.describe(lstr_temp[ll].FName+".x1"))
//				ll_linex2 = long(uo_design.uo_band.dw_syntax.describe(lstr_temp[ll].FName+".x2")) - (ll_linex1 - ll_x)
//				
//				ls_Modify = lstr_temp[ll].FName+".x1=" + string(ll_x)
//				ls_Modify +="~t" + lstr_temp[ll].FName+".x2=" + string(ll_linex2)
//			end if
//			lstr_temp[ll].FBand.modify(ls_Modify)
//			this.event ue_Setmodify(ls_modify)
//		NEXT
//	CASE 'snap_to_top'
//		IF uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".type") <> 'line' THEN 
//			ll_y = long(uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".y"))
//		else
//			ll_y = long(uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".y1"))
//		end if
//		
//		ls_band = uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".band")   
//		FOR ll = 2 TO ll_Count
//			if uo_design.uo_band.dw_syntax.describe(lstr_temp[ll].FName+".band") <> ls_band then continue 
//			IF uo_design.uo_band.dw_syntax.describe(lstr_temp[ll].FName+".type") <> 'line' THEN 
//				ls_Modify = lstr_temp[ll].FName+".y=" + string(ll_y)
//			else
//				ll_liney1 = long(uo_design.uo_band.dw_syntax.describe(lstr_temp[ll].FName+".y1"))
//				ll_liney2 = long(uo_design.uo_band.dw_syntax.describe(lstr_temp[ll].FName+".y2")) - (ll_liney1 - ll_y)
//				ls_Modify = lstr_temp[ll].FName+".y1=" + string(ll_y)
//				ls_Modify +="~t" + lstr_temp[ll].FName+".y2=" + string(ll_liney2)
//			end if
//			
//			lstr_temp[ll].FBand.modify(ls_Modify)
//			this.event ue_Setmodify(ls_modify)
//		NEXT
//	CASE 'same_height'
//		IF uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".type") <> 'line' THEN 
//			ll_temp = long(uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".height"))
//		else
//			ll_temp = long(uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".y2")) - long(uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".y1"))
//
//		end if
//		FOR ll = 2 TO ll_Count
//			IF uo_design.uo_band.dw_syntax.describe(lstr_temp[ll].FName+".type") <> 'line' THEN 
//				ls_Modify = lstr_temp[ll].FName+".height=" + string(ll_temp)
//			else
//				ls_Modify = lstr_temp[ll].FName+".y2=" + string(long(uo_design.uo_band.dw_syntax.describe(lstr_temp[ll].FName+".y1")) + ll_temp)
//			end if
//			lstr_temp[ll].FBand.modify(ls_Modify)
//			this.event ue_Setmodify(ls_modify)
//		NEXT
//
//	CASE 'same_width'
//		IF uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".type") <> 'line' THEN 
//			ll_temp = long(uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".width"))
//		else
//			ll_temp = long(uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".x2")) - long(uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".x1"))
//		end if
//		FOR ll = 2 TO ll_Count
//			IF uo_design.uo_band.dw_syntax.describe(lstr_temp[ll].FName+".type") <> 'line' THEN 
//				ls_Modify = lstr_temp[ll].FName+".width=" + string(ll_temp)
//			else
//				ls_Modify = lstr_temp[ll].FName+".x2=" + string(long(uo_design.uo_band.dw_syntax.describe(lstr_temp[ll].FName+".x1")) + ll_temp)
//			end if
//			lstr_temp[ll].FBand.modify(ls_Modify)
//			this.event ue_Setmodify(ls_modify)
//		NEXT
//	CASE ELSE
//END CHOOSE	
//
return 1
end event

event pfc_cst_batch_properties();Open(w_contract_batch_update_prop)
end event

event pfc_cst_field_depend();//Set Field Depend
uo_design.TriggerEvent("ue_field_depend")
end event

event pfc_cst_option();open(w_snaptogrid)
end event

event pfc_cst_restore();//
uo_design.TriggerEvent( "ue_restore" )
end event

public function integer wf_preparecopy (pfc_cst_u_band adw_band);////--------------------------- APPEON BEGIN ---------------------------
////$<add> 2007-11-05 By: Andy
//
//string   ls_Syntax
//boolean   lb_Found = FALSE
//long   ll_enter_pos = 0,ll_RowStart 
//string   ls_RowStr
//
//IF adw_band.is_CurObj = '' THEN 
//
//	return -1
//END IF
//
//ib_PreparCopying =  true
//ls_Syntax = lower(adw_band.describe("datawindow.syntax"))
//
//ll_RowStart = 1
//DO WHILE ll_RowStart < len(ls_Syntax)
//	ll_enter_Pos = pos(ls_Syntax,'~r~n',ll_RowStart)
//	ls_RowStr = mid(ls_Syntax,ll_RowStart,ll_Enter_Pos - ll_RowStart )
//
//	ll_RowStart = ll_Enter_pos + 1
//	IF pos(ls_RowStr,"name="+lower(adw_band.is_CurObj)+" ") > 0 THEN
//		IF adw_band.describe(adw_band.is_CurObj+".type") = 'column' THEN
//			IF pos(ls_RowStr,"column=(type") > 0 THEN
//				continue
//			END IF
//		END IF
//		lb_Found = TRUE
//		exit
//	END IF
//LOOP 
//
//IF lb_Found THEN
//	is_CopySyntax = ls_RowStr
//	long  ll_pos,ll_NextBlank
//
//	ll_pos = pos(is_CopySyntax," background.mode=")
//	ll_NextBlank = pos(is_CopySyntax," ",ll_pos + 17)
//	IF ll_Pos > 0 AND ll_NextBlank > 0 THEN
//		is_CopySyntax = replace(is_CopySyntax,ll_Pos ,ll_NextBlank - ll_pos," background.mode='"+uo_design.uo_band.dw_Syntax.describe(adw_Band.is_CurObj+".background.mode")+"'")
//	END IF
//
//	ll_pos = pos(is_CopySyntax," background.color=")
//	ll_NextBlank = pos(is_CopySyntax," ",ll_pos + 18)
//	IF ll_Pos > 0 AND ll_NextBlank > 0 THEN
//		is_CopySyntax = replace(is_CopySyntax,ll_Pos ,ll_NextBlank - ll_pos," background.color='"+uo_design.uo_band.dw_Syntax.describe(adw_Band.is_CurObj+".background.color")+"'")
//	END IF
//
	return 1
//ELSE
//	return -1
//END IF
////---------------------------- APPEON END ----------------------------
end function

public function integer wf_copyobject (pfc_cst_u_band adw_band);////--------------------------- APPEON BEGIN ---------------------------
////$<add> 2007-11-08 By: Andy
//long   ll_x,ll_y,ll_pos,ll_NextBlank,ll_Bound
//string  ls_err,ls_Modify,ls_NewName,ls_ObjType,ls_index,ls_objects,ls_nametemp
//long  ll_x1,ll_y1,ll_x2,ll_y2
//long  ll_k,ll_max
//integer li_object_no
//string  ls_obj_name
//Long ll_Cnt, ll
//boolean lb_flag = False
//
//IF ib_preparcopying AND is_copysyntax<> '' THEN
//	
//	ls_Modify = lower(is_CopySyntax)
//
//	ll_pos = pos(ls_Modify,"(")
//	ls_ObjType = trim(left(ls_Modify,ll_pos - 1))
//
//	ls_ObjType = mid(ls_ObjType,2,1) 
//
//	ll_pos = pos(ls_Modify,"name=")
//	ll_NextBlank = pos(ls_Modify," ",ll_pos + 5)
//	
//	if ib_cut then 
//		ls_NewName = mid(ls_Modify,ll_Pos + 5,ll_NextBlank - ll_pos - 5)
//	else
//		FOR li_object_no = 1 TO 1000
//			ls_obj_name = uo_design.uo_band.dw_syntax.Describe("object" + String(li_object_no) + "_" + ls_ObjType + ".name")
//			IF lower(ls_obj_name) = "object" + String(li_object_no) + '_' + lower(ls_ObjType) THEN CONTINUE
//			
//			EXIT
//		NEXT
//		ls_NewName = "object" + String(li_object_no) + '_' + ls_ObjType	
//	end if
//	
//	if Not ib_cut then
//		IF ll_Pos > 0 AND ll_NextBlank > 0 THEN
//			ls_Modify = replace(ls_Modify,ll_Pos ,ll_NextBlank - ll_pos," name="+ls_NewName+" ")
//		END IF
//	end if
//	
//	ll_pos = pos(ls_Modify," band=")
//	ll_NextBlank = pos(ls_Modify," ",ll_pos + 6)
//	IF ll_Pos > 0 AND ll_NextBlank > 0 THEN
//		ls_Modify = replace(ls_Modify,ll_Pos ,ll_NextBlank - ll_pos," band="+lower(adw_band.is_BandType)+" ")
//	END IF
//	
//	//ll_X = 8
//	ll_y = 8
//
//	CHOOSE CASE lower(ls_ObjType)
//		CASE 'l'
//			/*
//			ll_pos = pos(ls_Modify," x1=")
//			ll_NextBlank = pos(ls_Modify," ",ll_pos + 4)
//			IF ll_pos > 0 AND ll_NextBlank > 0 THEN
//				ll_x1 = long(mid(ls_Modify,ll_pos + 4,ll_NextBlank - ll_pos - 6))
//				ls_Modify = replace(ls_Modify,ll_pos ,ll_NextBlank - ll_pos," x1='"+string(ll_x)+"' ")
//			END IF
//			*/
//			ll_pos = pos(ls_Modify," y1=")
//			ll_NextBlank = pos(ls_Modify," ",ll_pos + 4)
//			IF ll_Pos > 0 AND ll_NextBlank > 0 THEN
//				ll_y1 = long(mid(ls_Modify,ll_pos + 4,ll_NextBlank - ll_pos - 6))
//				ls_Modify = replace(ls_Modify,ll_Pos ,ll_NextBlank - ll_pos," y1='"+string(ll_y)+"' ")
//			END IF
//			/*
//			ll_pos = pos(ls_Modify," x2=")
//			ll_NextBlank = pos(ls_Modify," ",ll_pos + 4)
//			IF ll_pos > 0 AND ll_NextBlank > 0 THEN
//				ll_x2 = long(mid(ls_Modify,ll_pos + 4,ll_NextBlank - ll_pos - 6))
//				ll_x2 += ll_x - ll_x1
//				ls_Modify = replace(ls_Modify,ll_pos ,ll_NextBlank - ll_pos," x2='"+string(ll_x2)+"' ")
//			END IF
//			*/
//			ll_pos = pos(ls_Modify," y2=")
//			ll_NextBlank = pos(ls_Modify," ",ll_pos + 4)
//			IF ll_Pos > 0 AND ll_NextBlank > 0 THEN
//				ll_y2 = long(mid(ls_Modify,ll_pos + 4,ll_NextBlank - ll_pos - 6))
//				ll_y2 += ll_y - ll_y1
//				ls_Modify = replace(ls_Modify,ll_Pos ,ll_NextBlank - ll_pos," y2='"+string(ll_y)+"' ")
//			END IF
//		CASE ELSE
//			/*
//			ll_pos = pos(ls_Modify," x=")
//			ll_NextBlank = pos(ls_Modify," ",ll_pos + 3)
//			IF ll_pos > 0 AND ll_NextBlank > 0 THEN
//				ls_Modify = replace(ls_Modify,ll_pos ,ll_NextBlank - ll_pos," x='"+string(ll_x)+"' ")
//			END IF
//			*/
//			ll_pos = pos(ls_Modify," y=")
//			ll_NextBlank = pos(ls_Modify," ",ll_pos + 3)
//			IF ll_Pos > 0 AND ll_NextBlank > 0 THEN
//				ls_Modify = replace(ls_Modify,ll_Pos ,ll_NextBlank - ll_pos," y='"+string(ll_y)+"' ")
//			END IF
//		
//	END CHOOSE
//		
//	ls_Modify = "create "+ls_Modify
//	ls_err = adw_band.modify(ls_Modify)
//
//	IF ls_Err <> '' THEN 
//		messagebox('Copy',  'Syntax error, unable to copy!' +"~r~n"+ls_Err)
//		return -1
//	END IF
//	this.event ue_setmodify(ls_Modify)
//	adw_band.is_CurObj = ls_NewName
//	adw_Band.of_unselectObj(adw_Band.is_OrgObj)
//	adw_Band.of_selectobject(ls_NewName)
//	adw_Band.is_OrgObj = ls_NewName
//	
//	if ib_cut then
//		ll_Cnt = UpperBound(adw_band.is_Objects)
//		FOR ll = 1 to ll_Cnt
//			if adw_band.is_Objects[ll] = ls_NewName then 
//				lb_flag = true
//				exit
//			end if
//		NEXT	
//		if Not lb_flag then
//			adw_band.is_Objects[upperbound(adw_band.is_Objects) + 1] = ls_NewName
//		end if
//	else
//		adw_band.is_Objects[upperbound(adw_band.is_Objects) + 1] = ls_NewName
//	end if
//ELSE
//	return -1
//END IF
//
//ib_cut = false
return 1
////---------------------------- APPEON END ----------------------------
end function

public function long wf_isselected (string as_name);////--------------------------- APPEON BEGIN ---------------------------
//
////====================================================================
//// Event: wf_isselected()
////--------------------------------------------------------------------
//// Description:
////--------------------------------------------------------------------
//// Arguments:
//// 	value	string	as_name	
////--------------------------------------------------------------------
//// Returns:  long
////--------------------------------------------------------------------
//// Author:	Andy		Date: Nov 06,2007
////--------------------------------------------------------------------
//// Modify History:
////
////====================================================================
//long   ll,ll_Count
//
//ll_Count = upperbound(istr_SelectObj)
//FOR ll = 1 TO ll_Count
//	IF lower(istr_SelectObj[ll].FName) = lower(as_name) THEN
//		return ll
//	END IF
//NEXT
//
return -1
//
////---------------------------- APPEON END ----------------------------
//
//
end function

public function integer wf_object_all_unselect ();////--------------------------- APPEON BEGIN ---------------------------
////$<add> 2007-11-06 By: Andy
//
//int li_count,li
//string ls_modify,ls_name,ls_type
//str_SelectObj   lstr_empty[]
//
//li_count = upperbound(istr_SelectObj)
//
//for li=1 to li_count
//	ls_name = istr_SelectObj[li].Fname
//	IF ls_Name = '' THEN continue
//	istr_SelectObj[li].FBand.of_UnSelectObj(ls_Name)
//next
//
//istr_SelectObj = lstr_Empty
return 1
//
////---------------------------- APPEON END ----------------------------
//
end function

public function integer wf_addobject (string as_objtype, long al_x, long al_y);////--------------------------- APPEON BEGIN ---------------------------
//
////====================================================================
//// Event: w_contract_data_design.wf_addobject()
////--------------------------------------------------------------------
//// Description:
////--------------------------------------------------------------------
//// Arguments:
//// 	string	as_objtype	
//// 	long  	al_x      	
//// 	long  	al_y      	
////--------------------------------------------------------------------
//// Returns:  integer
////--------------------------------------------------------------------
//// Author:	Andy		Date: Nov 6,2007
////--------------------------------------------------------------------
//// Modify History:
////
////====================================================================
//string ls_name,ls_modify,ls_err,ls_band='',ls_index, ls_objects,ls_nametemp
//int ll_x,ll_y
//long ll_row,ll_k,ll_max
//pfc_cst_u_band   ldw_band
//Integer li_object_no
//String ls_obj_name
//str_pass lstr_pass,lstr_Ret
//
////$<add> 2007-12-03 By: Andy
//uo_design.st_add.visible = False
////END OF add
//
//ll_x = al_x
//ll_y = al_y
//
//CHOOSE CASE UPPER(is_CurBand)
//	CASE 'HEADER'
//		ls_Band = 'header'
//		ldw_band = uo_design.uo_band.dw_Header		
//	CASE 'DETAIL'
//		ls_Band = 'detail'
//		ldw_band = uo_design.uo_band.dw_detail		
//	CASE 'SUMMARY'
//		ls_Band = 'summary'
//		ldw_band = uo_design.uo_band.dw_Summary		
//	CASE 'FOOTER'
//		ls_Band = 'footer'
//		ldw_Band = uo_design.uo_band.dw_Footer		
//	CASE else
//		RETURN -1
//		
//END CHOOSE
//
//if ls_Band='' then return -1
//
//FOR li_object_no = 1 TO 1000
//	ls_obj_name = uo_design.uo_band.dw_syntax.Describe("object" + String(li_object_no) + "_" + left(is_AddObjectType,1) + ".name")
//	IF lower(ls_obj_name) = "object" + String(li_object_no) + '_' + lower(left(is_AddObjectType,1)) THEN CONTINUE
//	
//	EXIT
//NEXT
//ls_name = "object" + String(li_object_no) + '_' + left(is_AddObjectType,1)
//
//choose case as_objType
//	case 'text'
//		ls_modify = 'create text(band='+ls_Band+' alignment="0" text="text" border="0" color="0" '&
//						+'x="'+string(ll_x)+'" y="'+string(ll_y)+'" height="52" width="150" '&
//						+' name='+ls_name+'  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'
//	case 'groupbox' 
//		ls_modify = 'create groupbox(band='+ls_Band+' text="none" border="5" color="128" x="'+string(ll_x)+'" y="'+string(ll_y)+'" height="390" width="660"  name='+ls_name+'  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'
//	case 'compute'
//		ls_modify = 'create compute(band='+ls_Band+' alignment="0" expression="" border="0" color="0" x="'+string(ll_x)+'" y="'+string(ll_y)+'" height="52" width="520"  name='+ls_name+' font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'
//	Case 'oval'
//		ls_modify = 'create ellipse(band=' + String(ls_Band) + ' x="'+String(ll_x) + '" y="' + String(ll_y) + '" height="120" width="137"  name=' + String(ls_name) + ' visible="1" brush.hatch="6" brush.color="33554432" pen.style="0" pen.width="5" pen.color="1073741824"  background.mode="2" background.color="33554432" )'
//end choose
//
//ls_err = ldw_Band.modify(ls_modify)
//ls_err = this.event ue_setmodify(ls_Modify)
//
//if ls_err<>'' then 
//	messagebox('',ls_err + '~r~n~r~n'+ls_modify)
//else
//	if as_objType = 'compute' then
//		lstr_pass.l_facility_id     = -1//-1:screen/else:export
//		lstr_pass.s_string          = ""//expression
//		lstr_pass.s_string_array[1] = ls_name//object name
//		lstr_pass.s_u_dw            = ldw_Band//relative dw
//		openwithparm(w_export_expression,lstr_pass)
//		
//		lstr_Ret = message.Powerobjectparm
//		//canceled
//		if Not IsValid(lstr_Ret) or ISNULL(lstr_Ret) THEN 
//			ldw_Band.Modify("destroy " + ls_name)
//			this.event ue_setmodify("destroy " + ls_name)
//		else
////			is_NewObject[UpperBound(is_NewObject) + 1] = ls_Name
//			ldw_Band.is_Objects[UpperBound(ldw_Band.is_Objects) + 1] = ls_Name
//			ldw_Band.of_unselectObj(ldw_Band.is_OrgObj)
//			ldw_Band.is_OrgObj = ldw_Band.is_CurObj
//			ldw_band.is_CurObj = ls_name
//			ldw_Band.of_unselectObj(ldw_Band.is_OrgObj)
//			ldw_Band.is_OrgObj = ldw_Band.is_CurObj
//			ldw_Band.of_selectobject(ls_name)
//			ldw_Band.of_setdesign(ls_Name)			
//		end if
//	else
////		is_NewObject[UpperBound(is_NewObject) + 1] = ls_Name
//		ldw_Band.is_Objects[UpperBound(ldw_Band.is_Objects) + 1] = ls_Name
//		ldw_Band.of_unselectObj(ldw_Band.is_OrgObj)
//		ldw_Band.is_OrgObj = ldw_Band.is_CurObj
//		ldw_band.is_CurObj = ls_name
//		ldw_Band.of_unselectObj(ldw_Band.is_OrgObj)
//		ldw_Band.is_OrgObj = ldw_Band.is_CurObj
//		ldw_Band.of_selectobject(ls_name)
//		ldw_Band.of_setdesign(ls_Name)		
//	end if
//end if
//
//is_addobjectType = ''
return  1
//
end function

public function integer wf_makeband (string as_syntax);////====================================================================
//// Event: of_makeband()
////--------------------------------------------------------------------
//// Description:
////--------------------------------------------------------------------
//// Arguments:
//// 	value	string	as_syntax	
////--------------------------------------------------------------------
//// Returns:  integer
////--------------------------------------------------------------------
//// Author:	Andy		Date: Nov 06,2007
////--------------------------------------------------------------------
//// Modify History:
////
////====================================================================
//
//string   ls_Syntax,ls_Err
//int  li
//str_Selectobj Str_Null[]
//String        ls_Null[]
//
//ls_Syntax = as_syntax
//uo_design.uo_band.dw_Syntax.Create(ls_Syntax)
//	
//uo_design.uo_band.dw_Syntax.settransobject(SQLCA)
//
////$<add> 2007-11-07 By: Andy
//uo_design.of_retrieve_dw_properties( uo_design.uo_band.dw_Syntax )
//
//is_OrgSyntax = uo_design.uo_band.dw_syntax.describe('datawindow.syntax')
//
//li  = uo_design.uo_band.dw_Header.create(is_OrgSyntax,ls_err)
//uo_design.uo_band.dw_header.DYNAMIC event ue_regenerate()
//uo_design.uo_band.dw_header.idw_syntax = uo_design.uo_band.dw_syntax
//
//li = uo_design.uo_band.dw_detail.create(is_OrgSyntax,ls_err)
////$<add> 03.19.2008 by Andy
//if uo_design.ii_screen_id = 33 or uo_design.ii_screen_id = 47 then
//	uo_design.uo_band.dw_detail.modify( "b_due_date_g.visible='0' b_due_date_r.visible='0'" )
//end if
////end of 03.19.2008
//uo_design.uo_band.dw_detail.DYNAMIC event ue_regenerate()
//uo_design.uo_band.dw_detail.idw_syntax = uo_design.uo_band.dw_syntax
//
//li = uo_design.uo_band.dw_Summary.create(is_OrgSyntax,ls_err)
//uo_design.uo_band.dw_Summary.DYNAMIC event ue_regenerate()
//uo_design.uo_band.dw_Summary.idw_syntax = uo_design.uo_band.dw_syntax
//
//li = uo_design.uo_band.dw_Footer.create(is_OrgSyntax,ls_err)
//uo_design.uo_band.dw_Footer.DYNAMIC event ue_regenerate()
//uo_design.uo_band.dw_footer.idw_syntax = uo_design.uo_band.dw_syntax
//
//uo_design.uo_band.dw_header.Height = long(uo_design.uo_band.dw_syntax.describe("datawindow.header.height"))
//uo_design.uo_band.dw_detail.Height = long(uo_design.uo_band.dw_syntax.describe("datawindow.detail.height"))
//uo_design.uo_band.dw_Summary.Height = long(uo_design.uo_band.dw_syntax.describe("datawindow.Summary.height"))
//uo_design.uo_band.dw_Footer.Height = long(uo_design.uo_band.dw_syntax.describe("datawindow.Footer.height"))
//
//uo_design.uo_band.st_header.y = uo_design.uo_band.dw_header.y + uo_design.uo_band.dw_header.height// - 4
//
//uo_design.uo_band.dw_detail.y = uo_design.uo_band.st_header.y + uo_design.uo_band.st_header.height// - 4
//uo_design.uo_band.st_detail.y = uo_design.uo_band.dw_detail.y + uo_design.uo_band.dw_detail.height// - 4
//
//uo_design.uo_band.dw_summary.y = uo_design.uo_band.st_detail.y + uo_design.uo_band.st_detail.height// - 4
//uo_design.uo_band.st_summary.y = uo_design.uo_band.dw_summary.y + uo_design.uo_band.dw_summary.height// - 4
//
//uo_design.uo_band.dw_footer.y = uo_design.uo_band.st_summary.y + uo_design.uo_band.st_summary.height// - 4
//uo_design.uo_band.st_footer.y = uo_design.uo_band.dw_footer.y + uo_design.uo_band.dw_footer.height// - 4
//
//uo_design.uo_band.dw_header.bringtotop  = TRUE
//uo_design.uo_band.dw_detail.bringtotop  = TRUE
//uo_design.uo_band.dw_summary.bringtotop  = TRUE
//uo_design.uo_band.dw_footer.bringtotop  = TRUE
//uo_design.uo_band.st_header.bringtotop  = TRUE
//uo_design.uo_band.st_detail.bringtotop  = TRUE
//uo_design.uo_band.st_summary.bringtotop  = TRUE
//uo_design.uo_band.st_footer.bringtotop  = TRUE
//
////$<del> 05.23.2008 by Andy
////uo_design.uo_band.dw_ruler.setposition(ToBottom! )
//
//iStr_SelectObj = Str_Null
////is_NewObject   = ls_Null
//
//
return 1
//
////---------------------------- APPEON END ----------------------------
//
end function

public function integer wf_selectmultiobj (keycode key, unsignedlong keyflags);////--------------------------- APPEON BEGIN ---------------------------
//
////====================================================================
//// Event: w_contract_data_design_new.wf_selectmultiobj()
////--------------------------------------------------------------------
//// Description:
////--------------------------------------------------------------------
//// Arguments:
//// 	value	keycode     	key     	
//// 	value	unsignedlong	keyflags	
////--------------------------------------------------------------------
//// Returns:  integer
////--------------------------------------------------------------------
//// Author:	Andy		Date: Nov 07,2007
////--------------------------------------------------------------------
//// Modify History:
////
////====================================================================
//
//long   ll_Count,ll_Color,ll,ll_x1,ll_x2,ll_Y1,ll_y2,ll_Band
//long  ll_objX,ll_ObjY,ll_Height,ll_Width
//string  ls_obj,ls_Objects[],ls_Name,ls_Band,ls_Type,ls_FirstType
//pfc_cst_u_band  ldw_band
//
//ll_Count = upperbound(istr_SelectObj)
//IF keyflags <> 2 AND keyflags <> 3 THEN return -1
//
//IF ll_Count > 0 THEN
//	ls_obj = istr_SelectObj[ll_Count].Fname
//	ls_FirstType = 'selected'
//ELSE
//	ls_obj = is_CurSelectObj
//	ls_FirstType = 'unselected'
//END IF
//IF ls_obj = '' THEN return -1
//
//ldw_Band = wf_getband(uo_design.uo_band.dw_Syntax.describe(ls_obj+".band"))
//IF ls_FirstType = 'unselected' THEN
//	istr_SelectObj[1].FBand = ldw_Band
//	istr_SelectObj[1].FName = ls_Obj
//	ldw_Band.Of_SelectObject(ls_obj)
//	ldw_Band.modify(ls_Obj+".background.color="+string(il_firstselectcolor))
//	ldw_Band.modify(ls_Obj+".brush.color="+string(il_firstselectcolor))
//END IF
//
//IF keyflags = 2 THEN 
//	CHOOSE CASE  key
//		CASE keyleftarrow!
//				ll_Count = Upperbound(istr_SelectObj) 
//				
//				ll_x1 = long(ldw_Band.describe(ls_obj+".x"))
//				ll_y1 = long(ldw_Band.describe(ls_obj+".y")) 
//				ll_y2 = ll_y1 +  long(ldw_Band.describe(ls_obj+".height"))
//				
//				FOr ll =1 TO upperbound(ldw_Band.is_Objects[])
//					ls_name = ldw_Band.is_Objects[ll]
//					IF ls_Name = ls_obj THEN continue
//					IF long(ldw_Band.describe(ls_name+".x")) > ll_x1 THEN continue
//
//					ll_Height = long(ldw_Band.describe(ls_name+".height"))
//					ll_ObjY = long(ldw_Band.describe(ls_name+".y"))
//
//					IF ll_ObjY >= ll_y1 - ll_Height AND ll_ObjY <= ll_y2 THEN
//						ll_Count ++
//						
//						istr_SelectObj[ll_Count].fband = ldw_band
//						istr_SelectObj[ll_Count].fname = ls_name
//					
//						ldw_Band.of_selectobject(ls_Name)
//					END IF
//				NEXT
//		CASE keyrightarrow!
//				ll_Count = Upperbound(istr_SelectObj) 
//				
//				ll_x1 = long(ldw_Band.describe(ls_obj+".x"))
//				ll_y1 = long(ldw_Band.describe(ls_obj+".y")) 
//				ll_y2 = ll_y1 +  long(ldw_Band.describe(ls_obj+".height"))
//				
//				FOr ll =1 TO upperbound(ldw_Band.is_Objects[])
//					ls_name = ldw_Band.is_Objects[ll]
//					IF ls_Name = ls_obj THEN continue
//					IF long(ldw_Band.describe(ls_name+".x")) < ll_x1 THEN continue
//
//					ll_Height = long(ldw_Band.describe(ls_name+".height"))
//					ll_ObjY = long(ldw_Band.describe(ls_name+".y"))
//
//					IF ll_ObjY >= ll_y1 - ll_Height AND ll_ObjY <= ll_y2 THEN
//						ll_Count ++
//						istr_SelectObj[ll_Count].fband = ldw_band
//						istr_SelectObj[ll_Count].fname = ls_name
//					
//						ldw_Band.of_selectobject(ls_Name)
//					END IF
//				NEXT
//		CASE keyA! 
//				ll_Count = Upperbound(istr_SelectObj) 
//
//				FOR ll_Band = 1 TO 4
//					CHOOSE CASE ll_Band
//						CASE 1
//							ldw_Band = uo_design.uo_band.dw_Header
//						CASE 2
//							ldw_Band = uo_design.uo_band.dw_Detail
//						CASE 3
//							ldw_Band = uo_design.uo_band.dw_Summary
//						CASE ELSE
//							ldw_Band = uo_design.uo_band.dw_Footer
//					END CHOOSE
//					FOR ll =1 TO upperbound(ldw_Band.is_Objects[])
//						ls_name = ldw_Band.is_Objects[ll]
//						IF ls_Name = ls_obj OR wf_isSelected(ls_name) > 0 THEN continue
//						ll_Count ++
//						istr_SelectObj[ll_Count].fband = ldw_band
//						istr_SelectObj[ll_Count].fname = ls_name
//						ldw_Band.of_selectobject(ls_Name)
//					NEXT
//				NEXT
//	END CHOOSE
//ELSE 
//	CHOOSE CASE  key
//		CASE keyleftarrow! 
//				ll_Count = Upperbound(istr_SelectObj) 
//				
//				ll_x1 = long(ldw_Band.describe(ls_obj+".x"))
//				ll_y1 = long(ldw_Band.describe(ls_obj+".y")) 
//				ll_y2 = ll_y1 +  long(ldw_Band.describe(ls_obj+".height"))
//				ls_Type = ldw_Band.describe(ls_obj+".type")
//				
//				FOr ll =1 TO upperbound(ldw_Band.is_Objects[])
//					ls_name = ldw_Band.is_Objects[ll]
//					IF ls_Name = ls_obj THEN continue
//					IF ls_Type <> ldw_band.describe(ls_name+'.type') THen continue
//					IF long(ldw_Band.describe(ls_name+".x")) > ll_x1 THEN continue
//
//					ll_Height = long(ldw_Band.describe(ls_name+".height"))
//					ll_ObjY = long(ldw_Band.describe(ls_name+".y"))
//
//					IF ll_ObjY >= ll_y1 - ll_Height AND ll_ObjY <= ll_y2 THEN
//						ll_Count ++
//						istr_SelectObj[ll_Count].fband = ldw_band
//						istr_SelectObj[ll_Count].fname = ls_name
//					
//						ldw_Band.of_selectobject(ls_Name)
//					END IF
//				NEXT
//		CASE keyrightarrow!
//				ll_Count = Upperbound(istr_SelectObj) 
//				
//				ll_x1 = long(ldw_Band.describe(ls_obj+".x"))
//				ll_y1 = long(ldw_Band.describe(ls_obj+".y")) 
//				ll_y2 = ll_y1 +  long(ldw_Band.describe(ls_obj+".height"))
//				ls_Type = ldw_Band.describe(ls_obj+".type")
//				
//				FOr ll =1 TO upperbound(ldw_Band.is_Objects[])
//					ls_name = ldw_Band.is_Objects[ll]
//					IF ls_Name = ls_obj THEN continue
//					
//					IF ls_Type <> ldw_band.describe(ls_name+'.type') THen continue
//					IF long(ldw_Band.describe(ls_name+".x")) < ll_x1 THEN continue
//
//					ll_Height = long(ldw_Band.describe(ls_name+".height"))
//					ll_ObjY = long(ldw_Band.describe(ls_name+".y"))
//
//					IF ll_ObjY >= ll_y1 - ll_Height AND ll_ObjY <= ll_y2 THEN
//						ll_Count ++
//						istr_SelectObj[ll_Count].fband = ldw_band
//						istr_SelectObj[ll_Count].fname = ls_name
//					
//						ldw_Band.of_selectobject(ls_Name)
//					END IF
//				NEXT
//		CASE keyA! 
//				ll_Count = Upperbound(istr_SelectObj) 
//				
//				FOR ll =1 TO upperbound(ldw_Band.is_Objects[])
//					ls_name = ldw_Band.is_Objects[ll]
//					IF ls_Name = ls_obj OR wf_isSelected(ls_name) > 0 THEN continue
//					ll_Count ++
//					istr_SelectObj[ll_Count].fband = ldw_band
//					istr_SelectObj[ll_Count].fname = ls_name
//					ldw_Band.of_selectobject(ls_Name)
//				NEXT
//	END CHOOSE
//END IF
//
//
return 1
//
////---------------------------- APPEON END ----------------------------
end function

public subroutine wf_getband (string as_band);////--------------------------- APPEON BEGIN ---------------------------
////$<add> 2007-11-05 By: Andy
//pfc_cst_u_band  ldw
//GraphicObject lobject
//
//CHOOSE CASE upper(as_Band)
//	CASE 'HEADER'
//		return uo_design.uo_band.dw_header
//	CASE 'DETAIL'
//		return uo_design.uo_band.dw_detail
//	CASE 'SUMMARY'
//		return uo_design.uo_band.dw_Summary
//	CASE 'FOOTER'
//		return uo_design.uo_band.dw_Footer
//	CASE ELSE		
//		return uo_design.uo_band.dw_Header
//
//END CHOOSE
////---------------------------- APPEON END ----------------------------
end subroutine

on w_contract_data_design.create
int iCurrent
call super::create
this.uo_design=create uo_design
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_design
end on

on w_contract_data_design.destroy
call super::destroy
destroy(this.uo_design)
end on

event open;call super::open;IF gb_se_version THEN
	uo_design.il_data_view_id = 2
	This.Title = "Contract Screen Painter"
END IF

ids_field_depend = create datastore	//add by jervis 09.24.2009

uo_design.of_set_parent_window( This )
//uo_design.of_Setup( False )
uo_design.of_Setup_painter()

//modify by gavin on 2009/3/4
uo_design.of_init(this,'screen')
uo_design.of_set_datagroup(true)

This.x = 1
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.06.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason> Fix a defect.
/*
This.y = 296
This.Width = 3543
This.Height = 1800
*/
This.y = 1
This.Width = 3980
This.Height = 2066

//---------------------------- APPEON END ----------------------------

uo_design.x = 1
uo_design.y = 1
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.06.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason> Fix a defect.
/*
uo_design.width = 3543
uo_design.height = 1712
*/
uo_design.width = 3980
uo_design.height = 2000

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-07 By: Andy
uo_design.uo_band.dw_header.of_setuserobject( uo_design)
uo_design.uo_band.dw_detail.of_setuserobject( uo_design)
uo_design.uo_band.dw_Summary.of_setuserobject( uo_design)
uo_design.uo_band.dw_footer.of_setuserobject( uo_design)
//---------------------------- APPEON END ----------------------------

//BEGIN---Modify by Scofield on 2009-09-04
uo_design.uo_band.dw_headergroup.of_setuserobject(uo_design)
uo_design.uo_band.dw_trailergroup.of_setuserobject(uo_design)
//END---Modify by Scofield on 2009-09-04

IF NOT gb_se_version THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 01.10.2008 By: Evan
	//$<reason> Close window if cancel select view.
	//uo_design.TriggerEvent( "pfc_cst_select_view" )//maha 030802
	integer li_Return
	li_Return = uo_design.Event pfc_cst_select_view()
	if li_Return = -1 then
		Close(this)
		Return
	end if
	//---------------------------- APPEON END ----------------------------
END IF

end event

event pfc_save;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2009.04.07 By: Scofield
//$<Reason> Save the result.

long	ll_View_id,ll_Rtn

ll_Rtn = uo_design.of_save()

if IsValid(gw_Contract) then
	if il_InitView_id = uo_design.il_data_view and il_SaveResult <> 1 and uo_Design.ii_screen_id <> 51 and uo_Design.ii_screen_id <> 52 then
		il_SaveResult = ll_Rtn
	end if
end if

//---------Begin Added by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
//Added By Jay Chen 04-03-2014
if IsValid(w_documents_browse) then il_SaveResult = ll_Rtn
//---------End Added ------------------------------------------------------

Return ll_Rtn

//RETURN uo_design.of_save()
//---------------------------- APPEON END ----------------------------

end event

event activate;IF uo_design.ib_disable_activate THEN RETURN

if w_mdi.MenuName <> "m_pfe_cst_contract_data_design" then	//add by jervis 01.07.2009
	w_mdi.ChangeMenu(m_pfe_cst_contract_data_design)
	/*
	if IsValid(gw_Contract) then
		gnv_app.of_modify_menu_attr( m_pfe_cst_contract_data_design.m_File.m_SelectView,'ToolbarItemVisible', false)
	else
		gnv_app.of_modify_menu_attr( m_pfe_cst_contract_data_design.m_File.m_SelectView,'ToolbarItemVisible', true)
	end if
	*/
end if
w_mdi.SetToolbarPos ( 2, 1, 200, False )

long ll_handle
ll_handle = handle(w_mdi)
gnv_appeondll.of_settoolbarpos(ll_handle)

w_mdi.of_menu_security( w_mdi.MenuName )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2008-01-04 By: Andy
//$<Reason> Fix a defect. bug:BugN122503,BugN122504
//Commented by Scofield on 2009-03-24
/*
If uo_design.il_select_view <> 1001 And (uo_design.ii_screen_id = 1 Or uo_design.ii_screen_id = 2) Then
	If isvalid(m_pfe_cst_contract_data_design) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_contract_data_design.m_view.m_fieldproperties,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_contract_data_design.m_file.m_save,'enabled', False)
	End If
	uo_design.uo_design.of_setobjectenable( false)
end if
*/
//---------------------------- APPEON END ----------------------------

//Comment by jervis 02.25.2011
//if IsValid(w_contract_field_properties) then w_contract_field_properties.Show()	//Added by Scofield on 2009-10-12

end event

event close;call super::close;
/*
//maha 100201
messagebox("Contract Screen Painter","Screen changes will not take effect in the Contract folder until it has been regenerated.  ~rIf open, close an reopen. ")

// mskinner 23 feb 2006 -- begin
OpenWITHPARM (w_utl_dvf_order_check,"P") 
if isvalid(w_utl_dvf_order_check) then 
	w_utl_dvf_order_check.visible= false
	w_utl_dvf_order_check.TriggerEvent ("ue_run")
end if 
// mskinner 23 feb 2006 -- end
*/

//Close( w_contract_design_menu )
w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)

w_mdi.of_menu_security( w_mdi.MenuName )

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2009-01-13 By: Scofield
//$<Reason> Refresh Contract Folder.

//---------Begin Added by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
if uo_design.ib_screen_document then //Added By Jay Chen 04-03-2014
	if IsValid(w_documents_browse) then
		if il_SaveResult = 1 then
			uo_design.TriggerEvent("ue_Refreshdocument")
		end if
	end if
else
//---------End Added ------------------------------------------------------
	if IsValid(gw_Contract) then
		if il_SaveResult = 1 then
			uo_design.TriggerEvent("ue_RefreshContract")
			
			do while uo_design.il_CurCtxID <> 0
				Yield()
			loop
		Else
			gw_contract.of_Set_tab_attribute( )//added by gavins 20130415
		end if
	end if
end if
//---------------------------- APPEON END ----------------------------

if isvalid(ids_field_depend) then destroy ids_field_depend

end event

event pfc_preopen;call super::pfc_preopen;long ll_i
string ls_scale

This.of_SetResize(True)

This.inv_resize.of_SetOrigSize (This.workspacewidth(),This.workspaceheight())
ls_scale = this.inv_resize.scale

For ll_i =  1 To upperbound(This.CONTrol)
   This.inv_resize.of_Register (This.CONTrol[ll_i],ls_scale)
Next


end event

event resize;call super::resize;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.11.2007 By: Jack
//$<reason> Fix a defect.

uo_design.height = this.height - 100

//Modified by gavin on 2009-03-05
////BEGIN---Modify by Evan 07/14/2008
///*
//uo_design.dw_select_section.height = uo_design.height - uo_design.uo_design.height - 20
////uo_design.dw_detail.height = uo_design.dw_select_section.height
//uo_design.dw_select_section.width = uo_design.width / 2 - 900
//*/
//uo_design.uo_select.height = uo_design.height - uo_design.uo_design.height - 10
////END--Modify by Evan 07/14/2008
//
////uo_design.dw_detail.x = uo_design.dw_select_section.width + 20
////uo_design.dw_detail.width = uo_design.width - uo_design.dw_detail.x - 20
//
////uo_design.hsb_detail.x = uo_design.dw_detail.x
////uo_design.vsb_detail.x = uo_design.width - 100
////uo_design.hsb_detail.y = uo_design.height - 100
////uo_design.vsb_detail.y = uo_design.dw_detail.y
////uo_design.vsb_detail.height = uo_design.dw_detail.height - 68
////uo_design.hsb_detail.width = uo_design.dw_detail.width - 88
////---------------------------- APPEON END ----------------------------
//
////--------------------------- APPEON BEGIN ---------------------------
////BEGIN---Modify by Evan 07/14/2008
////$<Modify> 2007-11-05 By: Andy
////$<Reason> Fix a defect.
///*
//uo_design.uo_band.y = uo_design.dw_select_section.y + 8
//uo_design.uo_band.height = uo_design.dw_select_section.height - 8
//uo_design.uo_band.x = uo_design.dw_select_section.width + 20
//uo_design.uo_band.width = uo_design.width - uo_design.uo_band.x - 20
//*/
//uo_design.uo_band.y = uo_design.uo_select.y
//uo_design.uo_band.height = uo_design.uo_select.height
//uo_design.uo_band.x = uo_design.uo_select.width + 20
//uo_design.uo_band.width = uo_design.width - uo_design.uo_band.x - 40
////END--Modify by Evan 07/14/2008
//
////uo_design.uo_band.dw_ruler.x = 0
////uo_design.uo_band.dw_ruler.y = 4
////$<modify> 05.23.2008 by Andy
//uo_design.uo_band.dw_ruler.width = 3*uo_design.uo_band.width//8 
//uo_design.uo_band.dw_ruler.height = 3*uo_design.uo_band.height//10
//
////uo_design.uo_band.dw_syntax.width = uo_design.uo_band.dw_ruler.width
////uo_design.uo_band.dw_syntax.height = uo_design.uo_band.dw_ruler.height
////end 05.23.2008
////uo_design.uo_band.dw_header.x = uo_design.uo_band.dw_ruler.X 
//uo_design.uo_band.dw_header.y = uo_design.uo_band.dw_ruler.Y 
//uo_design.uo_band.dw_Header.width = uo_design.uo_band.dw_ruler.width						
//
//uo_design.uo_band.st_header.y = uo_design.uo_band.dw_header.y + uo_design.uo_band.dw_header.height + 4
////uo_design.uo_band.st_header.x = uo_design.uo_band.dw_header.x
//uo_design.uo_band.st_header.width = uo_design.uo_band.dw_header.width
//
//uo_design.uo_band.dw_detail.y = uo_design.uo_band.st_header.y + uo_design.uo_band.st_header.height + 4
//uo_design.uo_band.dw_detail.width = uo_design.uo_band.dw_header.width 
////uo_design.uo_band.dw_detail.x = uo_design.uo_band.dw_header.x
//uo_design.uo_band.st_detail.y = uo_design.uo_band.dw_detail.y + uo_design.uo_band.dw_detail.height + 4
////uo_design.uo_band.st_detail.x = uo_design.uo_band.dw_header.x
//uo_design.uo_band.st_detail.width = uo_design.uo_band.dw_header.width
//
//uo_design.uo_band.dw_summary.y = uo_design.uo_band.st_detail.y + uo_design.uo_band.st_detail.height + 4
//uo_design.uo_band.dw_summary.width = uo_design.uo_band.dw_header.width 
////uo_design.uo_band.dw_summary.x = uo_design.uo_band.dw_header.x
//uo_design.uo_band.st_summary.y = uo_design.uo_band.dw_summary.y + uo_design.uo_band.dw_summary.height + 4
////uo_design.uo_band.st_summary.x = uo_design.uo_band.dw_header.x
//uo_design.uo_band.st_summary.width = uo_design.uo_band.dw_header.width
//
//uo_design.uo_band.dw_footer.y = uo_design.uo_band.st_summary.y + uo_design.uo_band.st_summary.height + 4
//uo_design.uo_band.dw_footer.width = uo_design.uo_band.dw_header.width 
////uo_design.uo_band.dw_footer.x = uo_design.uo_band.dw_header.x
//uo_design.uo_band.st_footer.y = uo_design.uo_band.dw_footer.y + uo_design.uo_band.dw_footer.height + 4
////uo_design.uo_band.st_footer.x = uo_design.uo_band.dw_header.x
//uo_design.uo_band.st_footer.width = uo_design.uo_band.dw_header.width
//---------------------------- APPEON END ----------------------------

end event

event key;call super::key;////--------------------------- APPEON BEGIN ---------------------------
////$<add> 2007-11-06 By: Andy
//
////keyflags: 0----none
////				1---shift key
////				2---ctrl key
////				3--shift&ctrl key
//string   ls_Modify,ls_Type,ls_obj,ls
//long   ll_Step,ll,ll_temp,ll_x,ll_y,ll_Width,ll_Height
//long  ll_Bound
//int  li_UnitX,li_UnitY
//
//li_unitx = pixelstounits(1,xpixelstounits!) 
//li_unity = pixelstounits(1,ypixelstounits!)
//   
//ll_Bound = upperbound(istr_SelectObj[]) 
//IF keyflags = 0 THEN
//	IF ll_Bound < 1 THEN
//		return
//	END IF
//	CHOOSE CASE key 
//		CASE keyleftarrow!
//			ll_Step =  - li_unitx
//			ls_Type = 'x'
//		CASE keyrightarrow!
//			ll_Step = li_unitx
//			ls_Type = 'x'
//		CASE keyuparrow!
//			ll_Step = -li_unity
//			ls_Type = 'y'
//		CASE keydownarrow!
//			ll_Step = li_unity
//			ls_Type = 'y'
//		CASE else
//			return
//	END CHOOSE
//ELSEIF keyflags = 1 THEN 
//	IF ll_Bound < 1 THEN
//		return
//	END IF
//	CHOOSE CASE key 
//		CASE keyleftarrow!
//			ll_Step = -li_unitx
//			ls_Type = 'width'
//		CASE keyrightarrow!
//			ll_Step = li_unitx
//			ls_Type = 'width'
//		CASE keyuparrow!
//			ll_Step = -li_unitY
//			ls_Type = 'height'
//		CASE keydownarrow!
//			ll_Step = li_unitY
//			ls_Type = 'height'
//		CASE else
//			return
//	END CHOOSE
//ELSE
//	wf_selectMultiObj(key,keyflags)
//	return
//END IF
//FOR ll =  1 to upperbound(istr_SelectObj)
//	IF not isnull(istr_SelectObj[ll].FName) AND istr_SelectObj[ll].FName <> '' THEN
//		IF uo_design.uo_band.dw_Syntax.describe(istr_SelectObj[ll].FName+".type") <> 'line' THEN 
//			ll_temp = long(uo_design.uo_band.dw_Syntax.describe(istr_SelectObj[ll].FName +"."+ls_Type)) + ll_Step
//			ls_Modify = istr_SelectObj[ll].FName +"."+ls_Type+"="+string(ll_temp)
//		else
//			choose case ls_Type
//				case 'x'
//					ls = string(long(uo_design.uo_band.dw_Syntax.describe(istr_SelectObj[ll].FName+".x1")) + ll_step)
//					ls_Modify = istr_SelectObj[ll].FName+".x1="+ls
//					ls = string(long(uo_design.uo_band.dw_Syntax.describe(istr_SelectObj[ll].FName+".x2")) + ll_step)
//					ls_Modify +="~t" + istr_SelectObj[ll].FName+".x2="+ls
//				case 'y'
//					ls = string(long(uo_design.uo_band.dw_Syntax.describe(istr_SelectObj[ll].FName+".y1")) + ll_step)
//					ls_Modify = istr_SelectObj[ll].FName+".y1="+ls
//					ls = string(long(uo_design.uo_band.dw_Syntax.describe(istr_SelectObj[ll].FName+".y2")) + ll_step)
//					ls_Modify +="~t" + istr_SelectObj[ll].FName+".y2="+ls
//				case 'width'
//					ls = string(long(uo_design.uo_band.dw_Syntax.describe(istr_SelectObj[ll].FName+".x2")) + ll_step)
//					ls_Modify = istr_SelectObj[ll].FName+".x2="+ls
//				case 'height'
//					ls = string(long(uo_design.uo_band.dw_Syntax.describe(istr_SelectObj[ll].FName+".y2")) + ll_step)
//					ls_Modify = istr_SelectObj[ll].FName+".y2="+ls
//			end choose
//		end if
//		istr_SelectObj[ll].FBand.Modify(ls_Modify)
//		this.event ue_Setmodify(ls_Modify)
//	END IF
//NEXT
////---------------------------- APPEON END ----------------------------
//
//
end event

event closequery;string   ls_Syntax, ls_grid="grid.lines=0"
int  li
long	ll_pos,ll_pos2

uo_design.dw_properties_dw.AcceptText() //Add by Evan 07/18/2008
ls_Syntax = uo_design.uo_band.dw_syntax.describe("datawindow.syntax")

if uo_design.il_dw_style = 1  then
	ll_pos = Pos(ls_Syntax,"processing=0")
	IF ll_pos > 0 THEN
		ls_Syntax = Left(ls_Syntax,ll_pos - 1) + "processing=1" + Mid(ls_Syntax, ll_pos + 12)
	END IF
	ll_Pos = pos( uo_design.is_OrgSyntax,  ls_grid ) 
	ll_pos2 =  pos( ls_Syntax,  ls_grid ) 
	if ll_pos > 0 and ll_pos2 = 0 then
		ls_Syntax = Left(ls_Syntax,ll_pos - 1) + ls_grid +' ' + Mid(ls_Syntax, ll_pos )
	end if
end if

//IF ls_Syntax <> is_OrgSyntax or uo_design.dw_properties_dw.ModifiedCount() > 0 THEN //Modify by Evan 07/18/2008
IF ls_Syntax <> uo_design.is_OrgSyntax or uo_design.dw_properties_dw.ModifiedCount() > 0 THEN //Modify by jervis 03.25.2009
	li = messagebox(gnv_app.iapp_object.DisplayName,'Do you want to save changes?',question!,yesnocancel!)
	IF li = 1 THEN
		IF this.event pfc_save() < 0 THEN
			return 1
		END IF
	ELSEIF li = 3 THEN
		return 1
	END IF
END IF

uo_design.of_deletepicfile( )//added by gavins 20131014
end event

event timer;call super::timer;if uo_design.uo_band.ib_MouseDown and KeyDown(KeyLeftButton!) then
	uo_design.uo_band.of_Modify_Rectangle_Frame()
else
	Timer(0)
	uo_design.uo_band.TriggerEvent("lbuttonup")
end if

end event

type uo_design from pfc_cst_u_contract_data_design within w_contract_data_design
event destroy ( )
integer width = 3963
integer taborder = 20
boolean border = false
end type

on uo_design.destroy
call pfc_cst_u_contract_data_design::destroy
end on

