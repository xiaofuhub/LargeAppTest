$PBExportHeader$w_report_data_design.srw
$PBExportComments$(Appeon)Toney 06.10.2013 - V141 ISG-CLX
forward
global type w_report_data_design from w_main
end type
type cb_2 from commandbutton within w_report_data_design
end type
type cb_1 from commandbutton within w_report_data_design
end type
type uo_design from pfc_cst_u_report_data_design within w_report_data_design
end type
end forward

global type w_report_data_design from w_main
integer x = 5
integer y = 336
integer width = 3799
integer height = 3144
string title = "Custom Report Design"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
boolean center = true
event pfc_cst_view_manager ( )
event pfc_cst_field_properties ( )
event pfc_cst_select_view ( )
event pfc_cst_new_screen_painter ( )
event pfc_cst_display_only ( )
event ue_rbuttondown ( )
event type integer ue_modify ( string as_modifytype )
event type string ue_setmodify ( string as_modify )
event type integer ue_selectmultiobject ( string as_type,  pfc_cst_u_band_report adw_band,  string as_name )
event ue_new ( string as_objtype )
event type integer ue_arrange ( string as_type )
event pfc_cst_batch_properties ( )
cb_2 cb_2
cb_1 cb_1
uo_design uo_design
end type
global w_report_data_design w_report_data_design

type variables
Boolean ib_disable_activate = FALSE

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-05 By: Andy
String  is_CurBand
boolean ib_PreparCopying=FALSE
string  is_CopySyntax=''

str_selectobj_report	istr_SelectObj[]
string  is_CurSelectObj

String  is_AddObjectType
//string  is_NewObject[]

long	  ii_index=0

String  is_OrgSyntax

long	  il_FirstSelectColor=15793151

boolean ib_cut = false

//---------------------------- APPEON END ----------------------------
end variables

forward prototypes
public function long wf_isselected (string as_name)
public function integer wf_object_all_unselect ()
public function integer wf_makeband (string as_syntax)
public function integer wf_selectmultiobj (keycode key, unsignedlong keyflags)
public function pfc_cst_u_band_report wf_getband (string as_band)
public function integer wf_preparecopy (pfc_cst_u_band_report adw_band)
public function integer wf_copyobject (pfc_cst_u_band_report adw_band)
public function integer wf_addobject (string as_objtype, long al_x, long al_y)
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

event ue_rbuttondown();//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-05 By: Andy

m_screen_design_rmb  lm

lm = create m_screen_design_rmb
//lm.item[1].popmenu(this.x+ this.pointerx()+ 20,this.y + this.pointery() + 250)
lm.item[1].popmenu(this.pointerx(),this.pointery())

destroy  lm
//---------------------------- APPEON END ----------------------------
end event

event type integer ue_modify(string as_modifytype);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-05 By: Andy
string  ls_Name
pfc_cst_u_band_report   ldw_band
int   li_ret
long  ll,ll_Count,ll_index,ll_Cnt
long	ll_find,ll_object_id

ldw_band = wf_getband(is_CurBand)

ls_Name = ldw_band.is_CurObj
ll_Count = upperbound(istr_SelectObj[])
CHOOSE CASE as_modifytype
	CASE 'delete'
		if ll_Count=0 then
			IF ls_Name = '' THEN return -1
			//$<Modify> 03.17.2008 by Andy
			IF Pos(lower(ls_Name),"object") > 0 then
				if messagebox("Alert","Are you sure you want to delete object "+ls_name+"?",Question!,yesno!,1)=2 then return -1
				ldw_band.modify("destroy "+ls_Name)
				ldw_band.of_unselectobj(ls_Name)
				this.event ue_setmodify("destroy "+ls_Name)
				
				//Clear the object in the is_Objects[]
				ll_Cnt = UpperBound(ldw_band.is_Objects)
				FOR ll_index = 1 to ll_Cnt
					if ldw_band.is_Objects[ll_index] = ls_Name then 
						ldw_band.is_Objects[ll_index] = ""
						exit
					end if
				NEXT
			else
				MessageBox("Clear Error", "You can't delete field or field label objects.  To hide these objects, set the Visible property in the properties dialog box to No.")
			end if
		else
			if messagebox("Alert","Are you sure you want to delete the selected object?",Question!,yesno!,1)=2 then return -1
			FOR ll = 1 TO ll_Count 
				ldw_band = wf_getband(istr_SelectObj[ll].fband.is_bandtype)
				ls_Name = istr_SelectObj[ll].fname
				IF ls_Name = '' THEN return -1 
				//$<Modify> 03.17.2008 by Andy
				IF Pos(lower(ls_Name),"object") > 0 then
					ldw_band.modify("destroy "+ls_Name)
					ldw_band.of_unselectobj(ls_Name)
					this.event ue_setmodify("destroy "+ls_Name)
								
					//Clear the object in the is_Objects[]
					ll_Cnt = UpperBound(ldw_band.is_Objects)
					FOR ll_index = 1 to ll_Cnt
						if ldw_band.is_Objects[ll_index] = ls_Name then 
							ldw_band.is_Objects[ll_index] = ""
							exit
						end if
					NEXT
				else
					MessageBox("Clear Error", "You can't delete field or field label objects.  To hide these objects, set the Visible property in the properties dialog box to No.")
					return -1
				end if					
			next
		end if

	CASE 'copy'
		if ll_Count=0 then
			IF ls_Name = '' THEN return -1 
			wf_prepareCopy(ldw_band)
		end if
	CASE 'cut'
		if ll_Count=0 then
			IF ls_Name = '' THEN return -1 
			ib_cut = true
			li_ret = wf_prepareCopy(ldw_band)
			IF li_ret > 0 THEN
				//<Modify> 11/20/2007 by: Andy
				//ldw_band.modify("destroy "+ls_Name)				
				uo_design.uo_band.dw_header.modify("destroy "+ls_Name)
				uo_design.uo_band.dw_detail.modify("destroy "+ls_Name)
				uo_design.uo_band.dw_summary.modify("destroy "+ls_Name)
				uo_design.uo_band.dw_footer.modify("destroy "+ls_Name)
				
				ldw_band.of_unselectobj(ls_Name)
				this.event ue_setmodify("destroy "+ls_Name)
				
				//Clear the object in the is_Objects[]
				ll_Cnt = UpperBound(ldw_band.is_Objects)
				FOR ll = 1 to ll_Cnt
					if ldw_band.is_Objects[ll] = ls_Name then 
						ldw_band.is_Objects[ll] = ""
						exit
					end if
				NEXT

			END IF
		end if
	CASE 'paste'
		if ll_Count=0 then
			return wf_CopyObject(ldw_band)
		end if
		
END CHOOSE

return 1
//---------------------------- APPEON END ----------------------------

end event

event type string ue_setmodify(string as_modify);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-06 By: Andy
string  ls_err

ls_err = uo_design.uo_band.dw_Syntax.modify(as_modify)

return ls_Err
//---------------------------- APPEON END ----------------------------
end event

event type integer ue_selectmultiobject(string as_type, pfc_cst_u_band_report adw_band, string as_name);//--------------------------- APPEON BEGIN ---------------------------

// Function: ue_selectmultiobject()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string        	as_type 	
// 	value	pfc_cst_u_band	adw_band	
// 	value	string        	as_name 	
//--------------------------------------------------------------------
// Returns:  
//--------------------------------------------------------------------
// Author:	Andy		Date: Nov 06,2007
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
long   ll_Count,ll_Color,ll_Seq,ll
str_Selectobj_report  lstr_Empty[]
pfc_cst_u_band_report ldw_Band

CHOOSE CASE  lower(as_type)
	CASE 'mouse' 
		ll_Seq = wf_isselected(as_name)
		IF ll_Seq > 0 THEN 
			istr_SelectObj[ll_Seq].fband.of_unselectobj(as_Name)
			istr_SelectObj[ll_seq].FName = ''
		ELSE 
			ll_Count = Upperbound(istr_SelectObj) 
			IF is_CurSelectObj <> '' AND ll_Count = 0 AND  is_CurSelectObj<> as_Name THEN
				ll_Count ++
				ldw_Band = wf_getband(uo_design.uo_band.dw_Syntax.describe(is_CurSelectObj+".band"))
				istr_SelectObj[ll_Count].fband = ldw_band
				istr_SelectObj[ll_Count].fname = is_CurSelectObj
				ldw_band.of_selectobject(is_CurSelectObj)
			END IF

			ll_Count ++
			istr_SelectObj[ll_Count].fband = adw_band
			istr_SelectObj[ll_Count].fname = as_name
			adw_band.of_selectobject(as_Name)
		END IF
		
	CASE 'clear' 
		wf_object_all_unselect()
END CHOOSE

return 1
//---------------------------- APPEON END ----------------------------

end event

event ue_new(string as_objtype);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-12-03 By: Andy
//$<Reason> Fix a defect.
if uo_design.ib_set_tab_order then return
uo_design.st_add.visible = true
//---------------------------- APPEON END ----------------------------

is_addobjectType = as_objtype

end event

event type integer ue_arrange(string as_type);str_SelectObj_report   lstr_temp[]
long   ll,ll_Count,ll_Upper
long  ll_x,ll_y,ll_Width,ll_Height,ll_temp,ll_Bottom
string  ls_Modify,ls_band
long ll_linex1,ll_linex2,ll_liney1,ll_liney2
string	ls_name
long	   ll_find,ll_object_id
string   ls_col_name

ll_Count = Upperbound(istr_SelectObj)
IF ll_Count < 1 THEN return -1
FOR ll = 1  TO ll_Count
	IF istr_SelectObj[ll].FName <> '' THEN
		ll_Upper++
		lstr_temp[ll_Upper] = istr_SelectObj[ll]
	END IF
NEXT

ll_Count =  Upperbound(lstr_temp)
IF ll_Count < 2 THEn return -1

CHOOSE CASE lower(as_type)
	CASE 'snap_to_left' 
		IF uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".type") <> 'line' THEN 
			ll_x = long(uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".x"))
		else
			ll_x = long(uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".x1"))
		end if
		FOR ll = 2 TO ll_Count
			IF uo_design.uo_band.dw_syntax.describe(lstr_temp[ll].FName+".type") <> 'line' THEN 
				ls_Modify = lstr_temp[ll].FName+".x=" + string(ll_x)
			else
				ll_linex1 = long(uo_design.uo_band.dw_syntax.describe(lstr_temp[ll].FName+".x1"))
				ll_linex2 = long(uo_design.uo_band.dw_syntax.describe(lstr_temp[ll].FName+".x2")) - (ll_linex1 - ll_x)
				
				ls_Modify = lstr_temp[ll].FName+".x1=" + string(ll_x)
				ls_Modify +="~t" + lstr_temp[ll].FName+".x2=" + string(ll_linex2)
			end if
			lstr_temp[ll].FBand.modify(ls_Modify)
			this.event ue_Setmodify(ls_modify)
		NEXT
	CASE 'snap_to_top'
		IF uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".type") <> 'line' THEN 
			ll_y = long(uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".y"))
		else
			ll_y = long(uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".y1"))
		end if
		
		ls_band = uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".band")   
		FOR ll = 2 TO ll_Count
			if uo_design.uo_band.dw_syntax.describe(lstr_temp[ll].FName+".band") <> ls_band then continue 
			IF uo_design.uo_band.dw_syntax.describe(lstr_temp[ll].FName+".type") <> 'line' THEN 
				ls_Modify = lstr_temp[ll].FName+".y=" + string(ll_y)
			else
				ll_liney1 = long(uo_design.uo_band.dw_syntax.describe(lstr_temp[ll].FName+".y1"))
				ll_liney2 = long(uo_design.uo_band.dw_syntax.describe(lstr_temp[ll].FName+".y2")) - (ll_liney1 - ll_y)
				ls_Modify = lstr_temp[ll].FName+".y1=" + string(ll_y)
				ls_Modify +="~t" + lstr_temp[ll].FName+".y2=" + string(ll_liney2)
			end if
			
			lstr_temp[ll].FBand.modify(ls_Modify)
			this.event ue_Setmodify(ls_modify)
		NEXT
	CASE 'same_height'
		IF uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".type") <> 'line' THEN 
			ll_temp = long(uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".height"))
		else
			ll_temp = long(uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".y2")) - long(uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".y1"))

		end if
		FOR ll = 2 TO ll_Count
			IF uo_design.uo_band.dw_syntax.describe(lstr_temp[ll].FName+".type") <> 'line' THEN 
				ls_Modify = lstr_temp[ll].FName+".height=" + string(ll_temp)
			else
				ls_Modify = lstr_temp[ll].FName+".y2=" + string(long(uo_design.uo_band.dw_syntax.describe(lstr_temp[ll].FName+".y1")) + ll_temp)
			end if
			lstr_temp[ll].FBand.modify(ls_Modify)
			this.event ue_Setmodify(ls_modify)
		NEXT

	CASE 'same_width'
		IF uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".type") <> 'line' THEN 
			ll_temp = long(uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".width"))
		else
			ll_temp = long(uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".x2")) - long(uo_design.uo_band.dw_syntax.describe(lstr_temp[1].FName+".x1"))
		end if
		FOR ll = 2 TO ll_Count
			IF uo_design.uo_band.dw_syntax.describe(lstr_temp[ll].FName+".type") <> 'line' THEN 
				ls_Modify = lstr_temp[ll].FName+".width=" + string(ll_temp)

			else
				ls_Modify = lstr_temp[ll].FName+".x2=" + string(long(uo_design.uo_band.dw_syntax.describe(lstr_temp[ll].FName+".x1")) + ll_temp)
			end if
			lstr_temp[ll].FBand.modify(ls_Modify)
			this.event ue_Setmodify(ls_modify)
		NEXT
	CASE ELSE
END CHOOSE	

return 1
end event

event pfc_cst_batch_properties();Open(w_contract_batch_update_prop)
end event

public function long wf_isselected (string as_name);//--------------------------- APPEON BEGIN ---------------------------

//====================================================================
// Event: wf_isselected()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_name	
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Andy		Date: Nov 06,2007
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
long   ll,ll_Count

ll_Count = upperbound(istr_SelectObj)
FOR ll = 1 TO ll_Count
	IF lower(istr_SelectObj[ll].FName) = lower(as_name) THEN
		return ll
	END IF
NEXT

return -1

//---------------------------- APPEON END ----------------------------


end function

public function integer wf_object_all_unselect ();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-06 By: Andy

int li_count,li
string ls_modify,ls_name,ls_type
str_SelectObj_report   lstr_empty[]

li_count = upperbound(istr_SelectObj)

for li=1 to li_count
	ls_name = istr_SelectObj[li].Fname
	IF ls_Name = '' THEN continue
	istr_SelectObj[li].FBand.of_UnSelectObj(ls_Name)
next

istr_SelectObj = lstr_Empty
return 1

//---------------------------- APPEON END ----------------------------

end function

public function integer wf_makeband (string as_syntax);//====================================================================
// Event: of_makeband()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_syntax	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Andy		Date: Nov 06,2007
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

string   ls_Syntax,ls_Err
int  li
str_Selectobj_report Str_Null[]
String        ls_Null[]

ls_Syntax = as_syntax
uo_design.uo_band.dw_Syntax.Create(ls_Syntax)
	
uo_design.uo_band.dw_Syntax.settransobject(SQLCA)

//$<add> 2007-11-07 By: Andy
uo_design.of_retrieve_dw_properties( uo_design.uo_band.dw_Syntax )

is_OrgSyntax = uo_design.uo_band.dw_syntax.describe('datawindow.syntax')

li  = uo_design.uo_band.dw_Header.create(is_OrgSyntax,ls_err)
uo_design.uo_band.dw_header.DYNAMIC event ue_regenerate()
uo_design.uo_band.dw_header.idw_syntax = uo_design.uo_band.dw_syntax

//headergroup
li = uo_design.uo_band.dw_headergroup.create(is_OrgSyntax,ls_err)
uo_design.uo_band.dw_headergroup.DYNAMIC event ue_regenerate()
uo_design.uo_band.dw_headergroup.idw_syntax = uo_design.uo_band.dw_syntax

li = uo_design.uo_band.dw_detail.create(is_OrgSyntax,ls_err)
uo_design.uo_band.dw_detail.DYNAMIC event ue_regenerate()
uo_design.uo_band.dw_detail.idw_syntax = uo_design.uo_band.dw_syntax

//trailergroup
li = uo_design.uo_band.dw_trailergroup.create(is_OrgSyntax,ls_err)
uo_design.uo_band.dw_trailergroup.DYNAMIC event ue_regenerate()
uo_design.uo_band.dw_trailergroup.idw_syntax = uo_design.uo_band.dw_syntax

li = uo_design.uo_band.dw_Summary.create(is_OrgSyntax,ls_err)
uo_design.uo_band.dw_Summary.DYNAMIC event ue_regenerate()
uo_design.uo_band.dw_Summary.idw_syntax = uo_design.uo_band.dw_syntax

li = uo_design.uo_band.dw_Footer.create(is_OrgSyntax,ls_err)
uo_design.uo_band.dw_Footer.DYNAMIC event ue_regenerate()
uo_design.uo_band.dw_footer.idw_syntax = uo_design.uo_band.dw_syntax

uo_design.uo_band.dw_header.Height = long(uo_design.uo_band.dw_syntax.describe("datawindow.header.height"))
uo_design.uo_band.dw_headergroup.Height = long(uo_design.uo_band.dw_syntax.describe("datawindow.header.1.height"))
uo_design.uo_band.dw_detail.Height = long(uo_design.uo_band.dw_syntax.describe("datawindow.detail.height"))
uo_design.uo_band.dw_trailergroup.Height = long(uo_design.uo_band.dw_syntax.describe("datawindow.trailer.1.height"))
uo_design.uo_band.dw_Summary.Height = long(uo_design.uo_band.dw_syntax.describe("datawindow.Summary.height"))
uo_design.uo_band.dw_Footer.Height = long(uo_design.uo_band.dw_syntax.describe("datawindow.Footer.height"))

uo_design.uo_band.st_header.y = uo_design.uo_band.dw_header.y + uo_design.uo_band.dw_header.height// - 4
//ib_group
if uo_design.uo_band.ib_group then
	uo_design.uo_band.dw_headergroup.y = uo_design.uo_band.st_header.y + uo_design.uo_band.st_header.height// - 4
	uo_design.uo_band.st_headergroup.y = uo_design.uo_band.dw_headergroup.y + uo_design.uo_band.dw_headergroup.height// - 4
	
	uo_design.uo_band.dw_detail.y = uo_design.uo_band.st_headergroup.y + uo_design.uo_band.st_headergroup.height// - 4
	uo_design.uo_band.st_detail.y = uo_design.uo_band.dw_detail.y + uo_design.uo_band.dw_detail.height// - 4

	uo_design.uo_band.dw_trailergroup.y = uo_design.uo_band.st_detail.y + uo_design.uo_band.st_detail.height// - 4
	uo_design.uo_band.st_trailergroup.y = uo_design.uo_band.dw_trailergroup.y + uo_design.uo_band.dw_trailergroup.height// - 4

	uo_design.uo_band.dw_summary.y = uo_design.uo_band.st_trailergroup.y + uo_design.uo_band.st_trailergroup.height// - 4
	uo_design.uo_band.st_summary.y = uo_design.uo_band.dw_summary.y + uo_design.uo_band.dw_summary.height// - 4
else
	uo_design.uo_band.dw_detail.y = uo_design.uo_band.st_header.y + uo_design.uo_band.st_header.height// - 4
	uo_design.uo_band.st_detail.y = uo_design.uo_band.dw_detail.y + uo_design.uo_band.dw_detail.height// - 4

	uo_design.uo_band.dw_summary.y = uo_design.uo_band.st_detail.y + uo_design.uo_band.st_detail.height// - 4
	uo_design.uo_band.st_summary.y = uo_design.uo_band.dw_summary.y + uo_design.uo_band.dw_summary.height// - 4
end if

uo_design.uo_band.dw_footer.y = uo_design.uo_band.st_summary.y + uo_design.uo_band.st_summary.height// - 4
uo_design.uo_band.st_footer.y = uo_design.uo_band.dw_footer.y + uo_design.uo_band.dw_footer.height// - 4

uo_design.uo_band.dw_header.bringtotop  = TRUE
uo_design.uo_band.dw_detail.bringtotop  = TRUE
uo_design.uo_band.dw_summary.bringtotop  = TRUE
uo_design.uo_band.dw_footer.bringtotop  = TRUE
uo_design.uo_band.st_header.bringtotop  = TRUE
uo_design.uo_band.st_detail.bringtotop  = TRUE
uo_design.uo_band.st_summary.bringtotop  = TRUE
uo_design.uo_band.st_footer.bringtotop  = TRUE
uo_design.uo_band.dw_headergroup.bringtotop  = TRUE
uo_design.uo_band.dw_trailergroup.bringtotop  = TRUE
uo_design.uo_band.st_headergroup.bringtotop  = TRUE
uo_design.uo_band.st_trailergroup.bringtotop  = TRUE


//$<del> 05.23.2008 by Andy
//uo_design.uo_band.dw_ruler.setposition(ToBottom! )

iStr_SelectObj = Str_Null
//is_NewObject   = ls_Null


return 1

//---------------------------- APPEON END ----------------------------

end function

public function integer wf_selectmultiobj (keycode key, unsignedlong keyflags);//--------------------------- APPEON BEGIN ---------------------------

//====================================================================
// Event: w_contract_data_design_new.wf_selectmultiobj()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	keycode     	key     	
// 	value	unsignedlong	keyflags	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Andy		Date: Nov 07,2007
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long   ll_Count,ll_Color,ll,ll_x1,ll_x2,ll_Y1,ll_y2,ll_Band
long  ll_objX,ll_ObjY,ll_Height,ll_Width
string  ls_obj,ls_Objects[],ls_Name,ls_Band,ls_Type,ls_FirstType
pfc_cst_u_band_report  ldw_band

ll_Count = upperbound(istr_SelectObj)
IF keyflags <> 2 AND keyflags <> 3 THEN return -1

IF ll_Count > 0 THEN
	ls_obj = istr_SelectObj[ll_Count].Fname
	ls_FirstType = 'selected'
ELSE
	ls_obj = is_CurSelectObj
	ls_FirstType = 'unselected'
END IF
IF ls_obj = '' THEN return -1

ldw_Band = wf_getband(uo_design.uo_band.dw_Syntax.describe(ls_obj+".band"))
IF ls_FirstType = 'unselected' THEN
	istr_SelectObj[1].FBand = ldw_Band
	istr_SelectObj[1].FName = ls_Obj
	ldw_Band.Of_SelectObject(ls_obj)
	ldw_Band.modify(ls_Obj+".background.color="+string(il_firstselectcolor))
	ldw_Band.modify(ls_Obj+".brush.color="+string(il_firstselectcolor))
END IF

IF keyflags = 2 THEN 
	CHOOSE CASE  key
		CASE keyleftarrow!
				ll_Count = Upperbound(istr_SelectObj) 
				
				ll_x1 = long(ldw_Band.describe(ls_obj+".x"))
				ll_y1 = long(ldw_Band.describe(ls_obj+".y")) 
				ll_y2 = ll_y1 +  long(ldw_Band.describe(ls_obj+".height"))
				
				FOr ll =1 TO upperbound(ldw_Band.is_Objects[])
					ls_name = ldw_Band.is_Objects[ll]
					IF ls_Name = ls_obj THEN continue
					IF long(ldw_Band.describe(ls_name+".x")) > ll_x1 THEN continue

					ll_Height = long(ldw_Band.describe(ls_name+".height"))
					ll_ObjY = long(ldw_Band.describe(ls_name+".y"))

					IF ll_ObjY >= ll_y1 - ll_Height AND ll_ObjY <= ll_y2 THEN
						ll_Count ++
						
						istr_SelectObj[ll_Count].fband = ldw_band
						istr_SelectObj[ll_Count].fname = ls_name
					
						ldw_Band.of_selectobject(ls_Name)
					END IF
				NEXT
		CASE keyrightarrow!
				ll_Count = Upperbound(istr_SelectObj) 
				
				ll_x1 = long(ldw_Band.describe(ls_obj+".x"))
				ll_y1 = long(ldw_Band.describe(ls_obj+".y")) 
				ll_y2 = ll_y1 +  long(ldw_Band.describe(ls_obj+".height"))
				
				FOr ll =1 TO upperbound(ldw_Band.is_Objects[])
					ls_name = ldw_Band.is_Objects[ll]
					IF ls_Name = ls_obj THEN continue
					IF long(ldw_Band.describe(ls_name+".x")) < ll_x1 THEN continue

					ll_Height = long(ldw_Band.describe(ls_name+".height"))
					ll_ObjY = long(ldw_Band.describe(ls_name+".y"))

					IF ll_ObjY >= ll_y1 - ll_Height AND ll_ObjY <= ll_y2 THEN
						ll_Count ++
						istr_SelectObj[ll_Count].fband = ldw_band
						istr_SelectObj[ll_Count].fname = ls_name
					
						ldw_Band.of_selectobject(ls_Name)
					END IF
				NEXT
		CASE keyA! 
				ll_Count = Upperbound(istr_SelectObj) 

				FOR ll_Band = 1 TO 4
					CHOOSE CASE ll_Band
						CASE 1
							ldw_Band = uo_design.uo_band.dw_Header
						CASE 2
							ldw_Band = uo_design.uo_band.dw_Detail
						CASE 3
							ldw_Band = uo_design.uo_band.dw_Summary
						CASE ELSE
							ldw_Band = uo_design.uo_band.dw_Footer
					END CHOOSE
					FOR ll =1 TO upperbound(ldw_Band.is_Objects[])
						ls_name = ldw_Band.is_Objects[ll]
						IF ls_Name = ls_obj OR wf_isSelected(ls_name) > 0 THEN continue
						ll_Count ++
						istr_SelectObj[ll_Count].fband = ldw_band
						istr_SelectObj[ll_Count].fname = ls_name
						ldw_Band.of_selectobject(ls_Name)
					NEXT
				NEXT
	END CHOOSE
ELSE 
	CHOOSE CASE  key
		CASE keyleftarrow! 
				ll_Count = Upperbound(istr_SelectObj) 
				
				ll_x1 = long(ldw_Band.describe(ls_obj+".x"))
				ll_y1 = long(ldw_Band.describe(ls_obj+".y")) 
				ll_y2 = ll_y1 +  long(ldw_Band.describe(ls_obj+".height"))
				ls_Type = ldw_Band.describe(ls_obj+".type")
				
				FOr ll =1 TO upperbound(ldw_Band.is_Objects[])
					ls_name = ldw_Band.is_Objects[ll]
					IF ls_Name = ls_obj THEN continue
					IF ls_Type <> ldw_band.describe(ls_name+'.type') THen continue
					IF long(ldw_Band.describe(ls_name+".x")) > ll_x1 THEN continue

					ll_Height = long(ldw_Band.describe(ls_name+".height"))
					ll_ObjY = long(ldw_Band.describe(ls_name+".y"))

					IF ll_ObjY >= ll_y1 - ll_Height AND ll_ObjY <= ll_y2 THEN
						ll_Count ++
						istr_SelectObj[ll_Count].fband = ldw_band
						istr_SelectObj[ll_Count].fname = ls_name
					
						ldw_Band.of_selectobject(ls_Name)
					END IF
				NEXT
		CASE keyrightarrow!
				ll_Count = Upperbound(istr_SelectObj) 
				
				ll_x1 = long(ldw_Band.describe(ls_obj+".x"))
				ll_y1 = long(ldw_Band.describe(ls_obj+".y")) 
				ll_y2 = ll_y1 +  long(ldw_Band.describe(ls_obj+".height"))
				ls_Type = ldw_Band.describe(ls_obj+".type")
				
				FOr ll =1 TO upperbound(ldw_Band.is_Objects[])
					ls_name = ldw_Band.is_Objects[ll]
					IF ls_Name = ls_obj THEN continue
					
					IF ls_Type <> ldw_band.describe(ls_name+'.type') THen continue
					IF long(ldw_Band.describe(ls_name+".x")) < ll_x1 THEN continue

					ll_Height = long(ldw_Band.describe(ls_name+".height"))
					ll_ObjY = long(ldw_Band.describe(ls_name+".y"))

					IF ll_ObjY >= ll_y1 - ll_Height AND ll_ObjY <= ll_y2 THEN
						ll_Count ++
						istr_SelectObj[ll_Count].fband = ldw_band
						istr_SelectObj[ll_Count].fname = ls_name
					
						ldw_Band.of_selectobject(ls_Name)
					END IF
				NEXT
		CASE keyA! 
				ll_Count = Upperbound(istr_SelectObj) 
				
				FOR ll =1 TO upperbound(ldw_Band.is_Objects[])
					ls_name = ldw_Band.is_Objects[ll]
					IF ls_Name = ls_obj OR wf_isSelected(ls_name) > 0 THEN continue
					ll_Count ++
					istr_SelectObj[ll_Count].fband = ldw_band
					istr_SelectObj[ll_Count].fname = ls_name
					ldw_Band.of_selectobject(ls_Name)
				NEXT
	END CHOOSE
END IF


return 1

//---------------------------- APPEON END ----------------------------
end function

public function pfc_cst_u_band_report wf_getband (string as_band);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-05 By: Andy
pfc_cst_u_band_report  ldw
GraphicObject lobject

CHOOSE CASE upper(as_Band)
	CASE 'HEADER'
		return uo_design.uo_band.dw_header
	CASE 'DETAIL'
		return uo_design.uo_band.dw_detail
	CASE 'SUMMARY'
		return uo_design.uo_band.dw_Summary
	CASE 'FOOTER'
		return uo_design.uo_band.dw_Footer
	CASE 'HEADERGROUP','HEADER.1'
		return uo_design.uo_band.dw_headergroup		
	CASE 'TRAILERGROUP','TRAILER.1'
		return uo_design.uo_band.dw_trailergroup		
	CASE ELSE		
		return uo_design.uo_band.dw_Header
END CHOOSE
//---------------------------- APPEON END ----------------------------
end function

public function integer wf_preparecopy (pfc_cst_u_band_report adw_band);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-05 By: Andy

string   ls_Syntax
boolean   lb_Found = FALSE
long   ll_enter_pos = 0,ll_RowStart 
string   ls_RowStr

IF adw_band.is_CurObj = '' THEN 

	return -1
END IF

ib_PreparCopying =  true
ls_Syntax = lower(adw_band.describe("datawindow.syntax"))

ll_RowStart = 1
DO WHILE ll_RowStart < len(ls_Syntax)
	ll_enter_Pos = pos(ls_Syntax,'~r~n',ll_RowStart)
	ls_RowStr = mid(ls_Syntax,ll_RowStart,ll_Enter_Pos - ll_RowStart )

	ll_RowStart = ll_Enter_pos + 1
	IF pos(ls_RowStr,"name="+lower(adw_band.is_CurObj)+" ") > 0 THEN
		IF adw_band.describe(adw_band.is_CurObj+".type") = 'column' THEN
			IF pos(ls_RowStr,"column=(type") > 0 THEN
				continue
			END IF
		END IF
		lb_Found = TRUE
		exit
	END IF
LOOP 

IF lb_Found THEN
	is_CopySyntax = ls_RowStr
	long  ll_pos,ll_NextBlank

	ll_pos = pos(is_CopySyntax," background.mode=")
	ll_NextBlank = pos(is_CopySyntax," ",ll_pos + 17)
	IF ll_Pos > 0 AND ll_NextBlank > 0 THEN
		is_CopySyntax = replace(is_CopySyntax,ll_Pos ,ll_NextBlank - ll_pos," background.mode='"+uo_design.uo_band.dw_Syntax.describe(adw_Band.is_CurObj+".background.mode")+"'")
	END IF

	ll_pos = pos(is_CopySyntax," background.color=")
	ll_NextBlank = pos(is_CopySyntax," ",ll_pos + 18)
	IF ll_Pos > 0 AND ll_NextBlank > 0 THEN
		is_CopySyntax = replace(is_CopySyntax,ll_Pos ,ll_NextBlank - ll_pos," background.color='"+uo_design.uo_band.dw_Syntax.describe(adw_Band.is_CurObj+".background.color")+"'")
	END IF

	return 1
ELSE
	return -1
END IF
//---------------------------- APPEON END ----------------------------
end function

public function integer wf_copyobject (pfc_cst_u_band_report adw_band);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-08 By: Andy
long   ll_x,ll_y,ll_pos,ll_NextBlank,ll_Bound
string  ls_err,ls_Modify,ls_NewName,ls_ObjType,ls_index,ls_objects,ls_nametemp
long  ll_x1,ll_y1,ll_x2,ll_y2
long  ll_k,ll_max
integer li_object_no
string  ls_obj_name
Long ll_Cnt, ll
boolean lb_flag = False

IF ib_preparcopying AND is_copysyntax<> '' THEN
	
	ls_Modify = lower(is_CopySyntax)

	ll_pos = pos(ls_Modify,"(")
	ls_ObjType = trim(left(ls_Modify,ll_pos - 1))

	ls_ObjType = mid(ls_ObjType,2,1) 

	ll_pos = pos(ls_Modify,"name=")
	ll_NextBlank = pos(ls_Modify," ",ll_pos + 5)
	
	if ib_cut then 
		ls_NewName = mid(ls_Modify,ll_Pos + 5,ll_NextBlank - ll_pos - 5)
	else
		FOR li_object_no = 1 TO 1000
			ls_obj_name = uo_design.uo_band.dw_syntax.Describe("object" + String(li_object_no) + "_" + ls_ObjType + ".name")
			IF lower(ls_obj_name) = "object" + String(li_object_no) + '_' + lower(ls_ObjType) THEN CONTINUE
			
			EXIT
		NEXT
		ls_NewName = "object" + String(li_object_no) + '_' + ls_ObjType	
	end if
	
	if Not ib_cut then
		IF ll_Pos > 0 AND ll_NextBlank > 0 THEN
			ls_Modify = replace(ls_Modify,ll_Pos ,ll_NextBlank - ll_pos," name="+ls_NewName+" ")
		END IF
	end if
	
	ll_pos = pos(ls_Modify," band=")
	ll_NextBlank = pos(ls_Modify," ",ll_pos + 6)
	IF ll_Pos > 0 AND ll_NextBlank > 0 THEN
		ls_Modify = replace(ls_Modify,ll_Pos ,ll_NextBlank - ll_pos," band="+lower(adw_band.is_BandType)+" ")
	END IF
	
	//ll_X = 8
	ll_y = 8

	CHOOSE CASE lower(ls_ObjType)
		CASE 'l'
			/*
			ll_pos = pos(ls_Modify," x1=")
			ll_NextBlank = pos(ls_Modify," ",ll_pos + 4)
			IF ll_pos > 0 AND ll_NextBlank > 0 THEN
				ll_x1 = long(mid(ls_Modify,ll_pos + 4,ll_NextBlank - ll_pos - 6))
				ls_Modify = replace(ls_Modify,ll_pos ,ll_NextBlank - ll_pos," x1='"+string(ll_x)+"' ")
			END IF
			*/
			ll_pos = pos(ls_Modify," y1=")
			ll_NextBlank = pos(ls_Modify," ",ll_pos + 4)
			IF ll_Pos > 0 AND ll_NextBlank > 0 THEN
				ll_y1 = long(mid(ls_Modify,ll_pos + 4,ll_NextBlank - ll_pos - 6))
				ls_Modify = replace(ls_Modify,ll_Pos ,ll_NextBlank - ll_pos," y1='"+string(ll_y)+"' ")
			END IF
			/*
			ll_pos = pos(ls_Modify," x2=")
			ll_NextBlank = pos(ls_Modify," ",ll_pos + 4)
			IF ll_pos > 0 AND ll_NextBlank > 0 THEN
				ll_x2 = long(mid(ls_Modify,ll_pos + 4,ll_NextBlank - ll_pos - 6))
				ll_x2 += ll_x - ll_x1
				ls_Modify = replace(ls_Modify,ll_pos ,ll_NextBlank - ll_pos," x2='"+string(ll_x2)+"' ")
			END IF
			*/
			ll_pos = pos(ls_Modify," y2=")
			ll_NextBlank = pos(ls_Modify," ",ll_pos + 4)
			IF ll_Pos > 0 AND ll_NextBlank > 0 THEN
				ll_y2 = long(mid(ls_Modify,ll_pos + 4,ll_NextBlank - ll_pos - 6))
				ll_y2 += ll_y - ll_y1
				ls_Modify = replace(ls_Modify,ll_Pos ,ll_NextBlank - ll_pos," y2='"+string(ll_y)+"' ")
			END IF
		CASE ELSE
			/*
			ll_pos = pos(ls_Modify," x=")
			ll_NextBlank = pos(ls_Modify," ",ll_pos + 3)
			IF ll_pos > 0 AND ll_NextBlank > 0 THEN
				ls_Modify = replace(ls_Modify,ll_pos ,ll_NextBlank - ll_pos," x='"+string(ll_x)+"' ")
			END IF
			*/
			ll_pos = pos(ls_Modify," y=")
			ll_NextBlank = pos(ls_Modify," ",ll_pos + 3)
			IF ll_Pos > 0 AND ll_NextBlank > 0 THEN
				ls_Modify = replace(ls_Modify,ll_Pos ,ll_NextBlank - ll_pos," y='"+string(ll_y)+"' ")
			END IF
		
	END CHOOSE
		
	ls_Modify = "create "+ls_Modify
	ls_err = adw_band.modify(ls_Modify)

	IF ls_Err <> '' THEN 
		messagebox('Copy',  'Syntax error, unable to copy!' +"~r~n"+ls_Err)
		return -1
	END IF
	this.event ue_setmodify(ls_Modify)
	adw_band.is_CurObj = ls_NewName
	adw_Band.of_unselectObj(adw_Band.is_OrgObj)
	adw_Band.of_selectobject(ls_NewName)
	adw_Band.is_OrgObj = ls_NewName
	
	if ib_cut then
		ll_Cnt = UpperBound(adw_band.is_Objects)
		FOR ll = 1 to ll_Cnt
			if adw_band.is_Objects[ll] = ls_NewName then 
				lb_flag = true
				exit
			end if
		NEXT	
		if Not lb_flag then
			adw_band.is_Objects[upperbound(adw_band.is_Objects) + 1] = ls_NewName
		end if
	else
		adw_band.is_Objects[upperbound(adw_band.is_Objects) + 1] = ls_NewName
	end if
ELSE
	return -1
END IF

ib_cut = false
return 1
//---------------------------- APPEON END ----------------------------
end function

public function integer wf_addobject (string as_objtype, long al_x, long al_y);//--------------------------- APPEON BEGIN ---------------------------

//====================================================================
// Event: w_contract_data_design.wf_addobject()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	string	as_objtype	
// 	long  	al_x      	
// 	long  	al_y      	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Andy		Date: Nov 6,2007
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
string ls_name,ls_modify,ls_err,ls_band='',ls_index, ls_objects,ls_nametemp
int ll_x,ll_y
long ll_k,ll_max
pfc_cst_u_band_report   ldw_band
Integer li_object_no
String ls_obj_name
str_pass lstr_pass,lstr_Ret
long		ll_object_no
long		ll_row
string 	ls_objtype,ls_objtext,ls_objborder
long		ll_objwidth,ll_objheight


//$<add> 2007-12-03 By: Andy
uo_design.st_add.visible = False
//END OF add

ll_x = al_x
ll_y = al_y

CHOOSE CASE UPPER(is_CurBand)
	CASE 'HEADER'
		ls_Band = 'header'
		ldw_band = uo_design.uo_band.dw_Header		
	CASE 'DETAIL'
		ls_Band = 'detail'
		ldw_band = uo_design.uo_band.dw_detail		
	CASE 'SUMMARY'
		ls_Band = 'summary'
		ldw_band = uo_design.uo_band.dw_Summary		
	CASE 'FOOTER'
		ls_Band = 'footer'
		ldw_Band = uo_design.uo_band.dw_Footer	
	CASE 'HEADERGROUP','HEADER.1'
		ls_Band = 'header.1'
		ldw_band = uo_design.uo_band.dw_Headergroup				
	CASE 'TRAILERGROUP','TRAILER.1'
		ls_Band = 'trailer.1'
		ldw_band = uo_design.uo_band.dw_trailergroup		
	CASE else
		RETURN -1
		
END CHOOSE

if ls_Band='' then return -1

FOR li_object_no = 1 TO 1000
	ls_obj_name = uo_design.uo_band.dw_syntax.Describe("object" + String(li_object_no) + "_" + left(is_AddObjectType,1) + ".name")
	IF lower(ls_obj_name) = "object" + String(li_object_no) + '_' + lower(left(is_AddObjectType,1)) THEN CONTINUE
	
	EXIT
NEXT
ls_name = "object" + String(li_object_no) + '_' + left(is_AddObjectType,1)
//SELECT Max(conv_view_report_objects.conv_view_object_id)  
//INTO :ll_object_no  
//FROM conv_view_report_objects;  
//IF IsNull(ll_object_no) THEN ll_object_no = 0
//ll_object_no ++
//ls_name = "object" + String(ll_object_no)

choose case as_objType
	case 'text'
		ls_objtype='T'
		ls_objtext='text'
		ll_objwidth=150
		ll_objheight=52
		ls_objborder='0'
		ls_modify = 'create text(band='+ls_Band+' alignment="0" text="text" border="0" color="0" '&
						+'x="'+string(ll_x)+'" y="'+string(ll_y)+'" height="52" width="150" '&
						+' name='+ls_name+'  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'
	case 'groupbox' 
		ls_objtype='B'
		ls_objtext='none'
		ll_objwidth=660
		ll_objheight=390
		ls_objborder='5'
		ls_modify = 'create groupbox(band='+ls_Band+' text="none" border="5" color="128" x="'+string(ll_x)+'" y="'+string(ll_y)+'" height="390" width="660"  name='+ls_name+'  font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'
	case 'compute'
		ls_objtype='C'
		ls_objtext=''
		ll_objwidth=520
		ll_objheight=52
		ls_objborder='0'
		ls_modify = 'create compute(band='+ls_Band+' alignment="0" expression="" border="0" color="0" x="'+string(ll_x)+'" y="'+string(ll_y)+'" height="52" width="520"  name='+ls_name+' font.face="MS Sans Serif" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'

end choose

ls_err = ldw_Band.modify(ls_modify)
ls_err = this.event ue_setmodify(ls_Modify)

if ls_err<>'' then 
	messagebox('',ls_err + '~r~n~r~n'+ls_modify)
else
	if as_objType = 'compute' then
		lstr_pass.s_long[1] = 2	//1-Export Call, 2- Screen Painter Call, 3- Advanced Update call	--jervis 03.12.2009
		//lstr_pass.l_facility_id     = -1//-1:screen/else:export
		lstr_pass.s_string          = ""//expression
		lstr_pass.s_string_array[1] = ls_name//object name
		lstr_pass.s_u_dw            = ldw_Band//relative dw
		openwithparm(w_export_expression_report,lstr_pass)
		
		lstr_Ret = message.Powerobjectparm
		//canceled
		if Not IsValid(lstr_Ret) or ISNULL(lstr_Ret) THEN 
			ldw_Band.Modify("destroy " + ls_name)
			this.event ue_setmodify("destroy " + ls_name)
		else
//			is_NewObject[UpperBound(is_NewObject) + 1] = ls_Name
			ldw_Band.is_Objects[UpperBound(ldw_Band.is_Objects) + 1] = ls_Name
			ldw_Band.of_unselectObj(ldw_Band.is_OrgObj)
			ldw_Band.is_OrgObj = ldw_Band.is_CurObj
			ldw_band.is_CurObj = ls_name
			ldw_Band.of_unselectObj(ldw_Band.is_OrgObj)
			ldw_Band.is_OrgObj = ldw_Band.is_CurObj
			ldw_Band.of_selectobject(ls_name)
			ldw_Band.of_setdesign(ls_Name)			
		end if
	else
//		is_NewObject[UpperBound(is_NewObject) + 1] = ls_Name
		ldw_Band.is_Objects[UpperBound(ldw_Band.is_Objects) + 1] = ls_Name
		ldw_Band.of_unselectObj(ldw_Band.is_OrgObj)
		ldw_Band.is_OrgObj = ldw_Band.is_CurObj
		ldw_band.is_CurObj = ls_name
		ldw_Band.of_unselectObj(ldw_Band.is_OrgObj)
		ldw_Band.is_OrgObj = ldw_Band.is_CurObj
		ldw_Band.of_selectobject(ls_name)
		ldw_Band.of_setdesign(ls_Name)		
	end if
	
end if

is_addobjectType = ''
return  1

end function

on w_report_data_design.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.uo_design=create uo_design
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.uo_design
end on

on w_report_data_design.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.uo_design)
end on

event open;call super::open;IF gb_se_version THEN
	uo_design.il_data_view_id = 2
	This.Title = "Custom Report Design"
END IF

uo_design.of_set_parent_window( This )
//uo_design.of_Setup( False )
uo_design.of_Setup_painter()

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
This.Width = 3790
This.Height = 2700

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
uo_design.uo_band.dw_headergroup.of_setuserobject( uo_design)
uo_design.uo_band.dw_detail.of_setuserobject( uo_design)
uo_design.uo_band.dw_trailergroup.of_setuserobject( uo_design)
uo_design.uo_band.dw_Summary.of_setuserobject( uo_design)
uo_design.uo_band.dw_footer.of_setuserobject( uo_design)
//---------------------------- APPEON END ----------------------------

//IF NOT gb_se_version THEN
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<modify> 01.10.2008 By: Evan
//	//$<reason> Close window if cancel select view.
//	//uo_design.TriggerEvent( "pfc_cst_select_view" )//maha 030802
//	integer li_Return
//	li_Return = uo_design.Event pfc_cst_select_view()
//	if li_Return = -1 then
//		Close(this)
//		Return
//	end if
//	//---------------------------- APPEON END ----------------------------
//END IF
//
uo_design.of_create_dw()

end event

event pfc_save;RETURN uo_design.of_save()
end event

event activate;IF ib_disable_activate THEN RETURN

if w_mdi.MenuName <> "m_pfe_cst_contract_data_design" then	//add by jervis 01.07.2009
	w_mdi.ChangeMenu(m_pfe_cst_contract_data_design)
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
		m_pfe_cst_contract_data_design.m_view.m_fieldproperties.enabled = False
		m_pfe_cst_contract_data_design.m_file.m_save.enabled = False
	End If
	uo_design.uo_design.of_setobjectenable( false)
end if
*/
//---------------------------- APPEON END ----------------------------

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

if IsValid(gw_Contract) then
	if gi_contract_view_id = uo_design.il_data_view then
		//Added By Alan on 2009-1-16
		if gw_Contract.tab_contract_details.tabpage_search.ib_autoretrieve = false then gw_Contract.tab_contract_details.tabpage_search.ib_autoretrieve = true
		uo_design.TriggerEvent("ue_RefreshContract")
		
		do while uo_design.il_CurCtxID <> 0
			Yield()
		loop
	end if
end if
//---------------------------- APPEON END ----------------------------

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

uo_design.height = this.height - 280

uo_design.width = this.width - 20
//BEGIN---Modify by Evan 07/14/2008
/*
uo_design.dw_select_section.height = uo_design.height - uo_design.uo_design.height - 20
//uo_design.dw_detail.height = uo_design.dw_select_section.height
uo_design.dw_select_section.width = uo_design.width / 2 - 900
*/
uo_design.uo_select.height = uo_design.height - uo_design.uo_design.height - 10
//END--Modify by Evan 07/14/2008

//uo_design.dw_detail.x = uo_design.dw_select_section.width + 20
//uo_design.dw_detail.width = uo_design.width - uo_design.dw_detail.x - 20

//uo_design.hsb_detail.x = uo_design.dw_detail.x
//uo_design.vsb_detail.x = uo_design.width - 100
//uo_design.hsb_detail.y = uo_design.height - 100
//uo_design.vsb_detail.y = uo_design.dw_detail.y
//uo_design.vsb_detail.height = uo_design.dw_detail.height - 68
//uo_design.hsb_detail.width = uo_design.dw_detail.width - 88
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//BEGIN---Modify by Evan 07/14/2008
//$<Modify> 2007-11-05 By: Andy
//$<Reason> Fix a defect.
/*
uo_design.uo_band.y = uo_design.dw_select_section.y + 8
uo_design.uo_band.height = uo_design.dw_select_section.height - 8
uo_design.uo_band.x = uo_design.dw_select_section.width + 20
uo_design.uo_band.width = uo_design.width - uo_design.uo_band.x - 20
*/
uo_design.uo_band.y = uo_design.uo_select.y
uo_design.uo_band.height = uo_design.uo_select.height
//uo_design.uo_band.x = uo_design.uo_select.width + 20
uo_design.uo_band.width = uo_design.width - uo_design.uo_band.x - 40
//END--Modify by Evan 07/14/2008
 
//uo_design.uo_band.dw_ruler.x = 0
//uo_design.uo_band.dw_ruler.y = 4
//$<modify> 05.23.2008 by Andy
If appeongetclienttype() = 'PB' Then
	uo_design.uo_band.dw_ruler.width = 8*uo_design.uo_band.width//8 
else
	uo_design.uo_band.dw_ruler.width = 2*uo_design.uo_band.width//8 
end if
uo_design.uo_band.dw_ruler.height = 3*uo_design.uo_band.height//10

//uo_design.uo_band.dw_syntax.width = uo_design.uo_band.dw_ruler.width
//uo_design.uo_band.dw_syntax.height = uo_design.uo_band.dw_ruler.height
//end 05.23.2008
//uo_design.uo_band.dw_header.x = uo_design.uo_band.dw_ruler.X 
uo_design.uo_band.dw_header.y = uo_design.uo_band.dw_ruler.Y 
uo_design.uo_band.dw_Header.width = uo_design.uo_band.dw_ruler.width						

uo_design.uo_band.st_header.y = uo_design.uo_band.dw_header.y + uo_design.uo_band.dw_header.height + 4
//uo_design.uo_band.st_header.x = uo_design.uo_band.dw_header.x
uo_design.uo_band.st_header.width = uo_design.uo_band.dw_header.width

//Added By Alan on 2009-2-2
if uo_design.uo_band.ib_group then
	uo_design.uo_band.dw_headergroup.y = uo_design.uo_band.st_header.y + uo_design.uo_band.st_header.height + 4
	uo_design.uo_band.dw_headergroup.width = uo_design.uo_band.dw_header.width 
	uo_design.uo_band.st_headergroup.y = uo_design.uo_band.dw_headergroup.y + uo_design.uo_band.dw_headergroup.height + 4
	//uo_design.uo_band.st_detail.x = uo_design.uo_band.dw_header.x
	uo_design.uo_band.st_headergroup.width = uo_design.uo_band.dw_header.width
	//end
	
	uo_design.uo_band.dw_detail.y = uo_design.uo_band.st_headergroup.y + uo_design.uo_band.st_headergroup.height + 4
	uo_design.uo_band.dw_detail.width = uo_design.uo_band.dw_header.width 
	//uo_design.uo_band.dw_detail.x = uo_design.uo_band.dw_header.x
	uo_design.uo_band.st_detail.y = uo_design.uo_band.dw_detail.y + uo_design.uo_band.dw_detail.height + 4
	//uo_design.uo_band.st_detail.x = uo_design.uo_band.dw_header.x
	uo_design.uo_band.st_detail.width = uo_design.uo_band.dw_header.width
	
	//Added By Alan on 2009-2-2
	uo_design.uo_band.dw_trailergroup.y = uo_design.uo_band.st_detail.y + uo_design.uo_band.st_detail.height + 4
	uo_design.uo_band.dw_trailergroup.width = uo_design.uo_band.dw_header.width 
	//uo_design.uo_band.dw_summary.x = uo_design.uo_band.dw_header.x
	uo_design.uo_band.st_trailergroup.y = uo_design.uo_band.dw_trailergroup.y + uo_design.uo_band.dw_trailergroup.height + 4
	//uo_design.uo_band.st_summary.x = uo_design.uo_band.dw_header.x
	uo_design.uo_band.st_trailergroup.width = uo_design.uo_band.dw_header.width
	//end
	
	uo_design.uo_band.dw_summary.y = uo_design.uo_band.st_trailergroup.y + uo_design.uo_band.st_trailergroup.height + 4
	uo_design.uo_band.dw_summary.width = uo_design.uo_band.dw_header.width 
	//uo_design.uo_band.dw_summary.x = uo_design.uo_band.dw_header.x
	uo_design.uo_band.st_summary.y = uo_design.uo_band.dw_summary.y + uo_design.uo_band.dw_summary.height + 4
	//uo_design.uo_band.st_summary.x = uo_design.uo_band.dw_header.x
	uo_design.uo_band.st_summary.width = uo_design.uo_band.dw_header.width
else
	uo_design.uo_band.dw_detail.y = uo_design.uo_band.st_header.y + uo_design.uo_band.st_header.height + 4
	uo_design.uo_band.dw_detail.width = uo_design.uo_band.dw_header.width 
	//uo_design.uo_band.dw_detail.x = uo_design.uo_band.dw_header.x
	uo_design.uo_band.st_detail.y = uo_design.uo_band.dw_detail.y + uo_design.uo_band.dw_detail.height + 4
	//uo_design.uo_band.st_detail.x = uo_design.uo_band.dw_header.x
	uo_design.uo_band.st_detail.width = uo_design.uo_band.dw_header.width
	
	uo_design.uo_band.dw_summary.y = uo_design.uo_band.st_detail.y + uo_design.uo_band.st_detail.height + 4
	uo_design.uo_band.dw_summary.width = uo_design.uo_band.dw_header.width 
	//uo_design.uo_band.dw_summary.x = uo_design.uo_band.dw_header.x
	uo_design.uo_band.st_summary.y = uo_design.uo_band.dw_summary.y + uo_design.uo_band.dw_summary.height + 4
	//uo_design.uo_band.st_summary.x = uo_design.uo_band.dw_header.x
	uo_design.uo_band.st_summary.width = uo_design.uo_band.dw_header.width	
end if

uo_design.uo_band.dw_footer.y = uo_design.uo_band.st_summary.y + uo_design.uo_band.st_summary.height + 4
uo_design.uo_band.dw_footer.width = uo_design.uo_band.dw_header.width 
//uo_design.uo_band.dw_footer.x = uo_design.uo_band.dw_header.x
uo_design.uo_band.st_footer.y = uo_design.uo_band.dw_footer.y + uo_design.uo_band.dw_footer.height + 4
//uo_design.uo_band.st_footer.x = uo_design.uo_band.dw_header.x
uo_design.uo_band.st_footer.width = uo_design.uo_band.dw_header.width
//---------------------------- APPEON END ----------------------------

end event

event key;call super::key;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-06 By: Andy

//keyflags: 0----none
//				1---shift key
//				2---ctrl key
//				3--shift&ctrl key
string   ls_Modify,ls_Type,ls_obj,ls
long   ll_Step,ll,ll_temp,ll_x,ll_y,ll_Width,ll_Height
long  ll_Bound
int  li_UnitX,li_UnitY

li_unitx = pixelstounits(1,xpixelstounits!) 
li_unity = pixelstounits(1,ypixelstounits!)
   
ll_Bound = upperbound(istr_SelectObj[]) 
IF keyflags = 0 THEN
	IF ll_Bound < 1 THEN
		return
	END IF
	CHOOSE CASE key 
		CASE keyleftarrow!
			ll_Step =  - li_unitx
			ls_Type = 'x'
		CASE keyrightarrow!
			ll_Step = li_unitx
			ls_Type = 'x'
		CASE keyuparrow!
			ll_Step = -li_unity
			ls_Type = 'y'
		CASE keydownarrow!
			ll_Step = li_unity
			ls_Type = 'y'
		CASE else
			return
	END CHOOSE
ELSEIF keyflags = 1 THEN 
	IF ll_Bound < 1 THEN
		return
	END IF
	CHOOSE CASE key 
		CASE keyleftarrow!
			ll_Step = -li_unitx
			ls_Type = 'width'
		CASE keyrightarrow!
			ll_Step = li_unitx
			ls_Type = 'width'
		CASE keyuparrow!
			ll_Step = -li_unitY
			ls_Type = 'height'
		CASE keydownarrow!
			ll_Step = li_unitY
			ls_Type = 'height'
		CASE else
			return
	END CHOOSE
ELSE
	wf_selectMultiObj(key,keyflags)
	return
END IF
FOR ll =  1 to upperbound(istr_SelectObj)
	IF not isnull(istr_SelectObj[ll].FName) AND istr_SelectObj[ll].FName <> '' THEN
		IF uo_design.uo_band.dw_Syntax.describe(istr_SelectObj[ll].FName+".type") <> 'line' THEN 
			ll_temp = long(uo_design.uo_band.dw_Syntax.describe(istr_SelectObj[ll].FName +"."+ls_Type)) + ll_Step
			ls_Modify = istr_SelectObj[ll].FName +"."+ls_Type+"="+string(ll_temp)
		else
			choose case ls_Type
				case 'x'
					ls = string(long(uo_design.uo_band.dw_Syntax.describe(istr_SelectObj[ll].FName+".x1")) + ll_step)
					ls_Modify = istr_SelectObj[ll].FName+".x1="+ls
					ls = string(long(uo_design.uo_band.dw_Syntax.describe(istr_SelectObj[ll].FName+".x2")) + ll_step)
					ls_Modify +="~t" + istr_SelectObj[ll].FName+".x2="+ls
				case 'y'
					ls = string(long(uo_design.uo_band.dw_Syntax.describe(istr_SelectObj[ll].FName+".y1")) + ll_step)
					ls_Modify = istr_SelectObj[ll].FName+".y1="+ls
					ls = string(long(uo_design.uo_band.dw_Syntax.describe(istr_SelectObj[ll].FName+".y2")) + ll_step)
					ls_Modify +="~t" + istr_SelectObj[ll].FName+".y2="+ls
				case 'width'
					ls = string(long(uo_design.uo_band.dw_Syntax.describe(istr_SelectObj[ll].FName+".x2")) + ll_step)
					ls_Modify = istr_SelectObj[ll].FName+".x2="+ls
				case 'height'
					ls = string(long(uo_design.uo_band.dw_Syntax.describe(istr_SelectObj[ll].FName+".y2")) + ll_step)
					ls_Modify = istr_SelectObj[ll].FName+".y2="+ls
			end choose
		end if
		istr_SelectObj[ll].FBand.Modify(ls_Modify)
		this.event ue_Setmodify(ls_Modify)
	END IF
NEXT
//---------------------------- APPEON END ----------------------------


end event

event closequery;string   ls_Syntax
int  li

//uo_design.dw_properties_dw.AcceptText() //Add by Evan 07/18/2008
ls_Syntax = uo_design.uo_band.dw_syntax.describe("datawindow.syntax")

//IF ls_Syntax <> is_OrgSyntax or uo_design.dw_properties_dw.ModifiedCount() > 0 THEN //Modify by Evan 07/18/2008
IF ls_Syntax <> is_OrgSyntax then
	li = messagebox(gnv_app.iapp_object.DisplayName,'Do you want to save changes?',question!,yesnocancel!)
	IF li = 1 THEN
		cb_1.triggerevent("clicked")
	ELSEIF li = 3 THEN
		return 1
	END IF
END IF
end event

type cb_2 from commandbutton within w_report_data_design
integer x = 439
integer y = 2900
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Exit"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_report_data_design
integer x = 37
integer y = 2900
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Save"
end type

event clicked;uo_design.of_save()
end event

type uo_design from pfc_cst_u_report_data_design within w_report_data_design
event destroy ( )
integer width = 3794
integer taborder = 20
boolean border = false
end type

on uo_design.destroy
call pfc_cst_u_report_data_design::destroy
end on

