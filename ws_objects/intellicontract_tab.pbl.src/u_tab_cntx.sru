$PBExportHeader$u_tab_cntx.sru
$PBExportComments$[intellicontract_tab]  Contract Contact Tab Page
forward
global type u_tab_cntx from u_tab
end type
type tabpage_contact_search from u_tabpg_cntct_search within u_tab_cntx
end type
type tabpage_contact_search from u_tabpg_cntct_search within u_tab_cntx
end type
type tabpage_details from u_tabpg_cntct_details within u_tab_cntx
end type
type tabpage_details from u_tabpg_cntct_details within u_tab_cntx
end type
type tabpage_custom from u_tabpg_cntct_custom within u_tab_cntx
end type
type tabpage_custom from u_tabpg_cntct_custom within u_tab_cntx
end type
type tabpage_access from u_tabpg_cntct_access within u_tab_cntx
end type
type tabpage_access from u_tabpg_cntct_access within u_tab_cntx
end type
end forward

global type u_tab_cntx from u_tab
integer width = 3918
integer height = 2200
long backcolor = 33551856
boolean createondemand = true
alignment alignment = center!
tabpage_contact_search tabpage_contact_search
tabpage_details tabpage_details
tabpage_custom tabpage_custom
tabpage_access tabpage_access
end type
global u_tab_cntx u_tab_cntx

type variables
long 		il_contact_id
long		il_facility_id
boolean	ib_ConFlag
string 	is_access

STRING IS_MODE
CONSTANT STRING EDIT = 'EDIT'
CONSTANT STRING NEW = 'NEW'

integer ii_accessright //(Appeon)Toney 11.29.2013 - V141 ISG-CLX,Fix history BugT101503,append readonly security control 
end variables

forward prototypes
public function integer of_set_contact_id (long al_contact_id)
public function integer of_set_mode (string as_mode)
public function string of_get_mode ()
public function boolean of_getflag ()
public function integer of_set_facility_id (long al_facility_id, string as_access)
public function long of_get_contact_id ()
public function long of_get_facility_id ()
end prototypes

public function integer of_set_contact_id (long al_contact_id);il_contact_id = al_contact_id

//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-03-27 By: Wu ZhiJun
//$<reason> Add the ib_ConFlag
ib_ConFlag = true
//--------------------------- APPEON END -----------------------------

return success

end function

public function integer of_set_mode (string as_mode);
IS_MODE = AS_MODE

RETURN SUccess
end function

public function string of_get_mode ();






RETURN IS_MODE
end function

public function boolean of_getflag ();//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-03-27 By: Wu ZhiJun
//$<reason> Return the ib_ConFlag
return ib_ConFlag
//--------------------------- APPEON END -----------------------------

end function

public function integer of_set_facility_id (long al_facility_id, string as_access);il_facility_id = al_facility_id
is_access = as_access 	//jervis 12.01.2010
ib_ConFlag = false

if is_access <> 'N' then
	this.tabpage_access.enabled = true
end if
return success

end function

public function long of_get_contact_id ();/******************************************************************************************************************
**  [PUBLIC]   : of_get_contact_id( )
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_ret

IF f_validstr(string(il_contact_id)) AND il_contact_id <> 0 THEN
	LL_ret =  IL_contact_id
ELSE
	LL_ret = FAilure
	
END IF



return ll_ret
end function

public function long of_get_facility_id ();/******************************************************************************************************************
**  [PUBLIC]   : of_get_facility_id( )
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: WuZhiJun  
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_ret

IF f_validstr(string(il_facility_id)) AND il_facility_id <> 0 THEN
	LL_ret =  il_facility_id
ELSE
	LL_ret = FAilure
END IF

return ll_ret
end function

on u_tab_cntx.create
this.tabpage_contact_search=create tabpage_contact_search
this.tabpage_details=create tabpage_details
this.tabpage_custom=create tabpage_custom
this.tabpage_access=create tabpage_access
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_contact_search
this.Control[iCurrent+2]=this.tabpage_details
this.Control[iCurrent+3]=this.tabpage_custom
this.Control[iCurrent+4]=this.tabpage_access
end on

on u_tab_cntx.destroy
call super::destroy
destroy(this.tabpage_contact_search)
destroy(this.tabpage_details)
destroy(this.tabpage_custom)
destroy(this.tabpage_access)
end on

event selectionchanging;long 		ll_Row
integer	li_Rtn
String	ls_FirstName,ls_LastName

setpointer(hourglass!)
This.tabpage_details.of_accepttext(false)
This.tabpage_custom.of_accepttext(false)
this.tabpage_access.of_accepttext( false)


//li_Rtn = This.tabpage_details.of_updatespending( )
li_Rtn = this.of_updatespending( ) //jervis 11.22.2010
if li_Rtn  = 1 then
	if This.tabpage_details.dw_master.event pfc_validation( ) = success and This.tabpage_details.dw_facility_detail.event pfc_validation( ) = success and this.tabpage_access.dw_access.event pfc_validation( ) = success THEN
		iw_parent.event dynamic pfc_save( )
	else
		return 1
	end if
//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-04-24 By: Wu ZhiJun
//$<reason> Fix a bug	
elseif li_Rtn  = 0 then
	if oldindex = 2 and newindex = 3 then
		Tabpage_details.dw_master.AcceptText()
		ll_Row = Tabpage_details.dw_master.GetRow()
		if ll_Row > 0 then
			ls_FirstName = Tabpage_details.dw_master.GetItemString(ll_Row,'first_name')
			if IsNull(ls_FirstName) or Trim(ls_FirstName) = '' then
				MessageBox('Information','First Name is required.')
				Tabpage_details.dw_master.SetColumn('first_name')
				Tabpage_details.dw_master.SetFocus()
				return 1
			end if
		end if
		
		ll_Row = Tabpage_details.dw_master.GetRow()
		if ll_Row > 0 then
			ls_LastName = Tabpage_details.dw_master.GetItemString(ll_Row,'last_name')
			if IsNull(ls_LastName) or Trim(ls_LastName) = '' then
				MessageBox('Information','Last Name is required.')
				Tabpage_details.dw_master.SetColumn('last_name')
				Tabpage_details.dw_master.SetFocus()
				return 1
			end if
		end if
	end if
end if
//--------------------------- APPEON END -----------------------------
setpointer(arrow!)
end event

event selectionchanged;call super::selectionchanged;string ls_readonly
if newindex =  1 then return SUCCESS

if is_mode <> 'NEW' and f_ValidStr(is_mode) then
	if OLDindex = 1 and NEWindex = 2 or OLDindex = 1 and NEWindex = 3 or OLDindex = 3 and NEWindex = 2 then
	  iw_parent.FUNCTION DYNAMIC of_retrieve()
	end if	
end if

//Add Group Access - jervis 11.22.2010
if NEWindex = 4 then
	this.tabpage_access.of_set_facility_id( il_facility_id)
	this.tabpage_access.dw_access.event pfc_retrieve( )
end if

if newindex > 1 and is_mode <> 'NEW' then
	if is_access = 'F' then 
		ls_readonly = 'no'
	else
		ls_readonly = 'yes'
	end if
	if newindex = 2 then 
		this.tabpage_details.dw_facility_detail.Modify("datawindow.readonly = " + ls_readonly )
		this.tabpage_details.dw_master.Modify("datawindow.readonly = " + ls_readonly )
		this.tabpage_details.dw_contact_master.Modify("datawindow.readonly = " + ls_readonly )
		this.tabpage_details.dw_1.Modify("datawindow.readonly = " + ls_readonly )
	elseif newindex = 3 then
		this.tabpage_custom.dw_2.Modify("datawindow.readonly = " + ls_readonly )
	elseif newindex = 4 then
		//---------Begin Added by (Appeon)Toney 11.29.2013 for V141 ISG-CLX--------
		//$Reason:Fix history BugT101503,append readonly security control 
		IF ii_accessright = 1 THEN 
			ls_readonly = 'yes'
			this.tabpage_access.dw_access.of_disable_columns( )
		END IF
		//---------End Added ------------------------------------------------------------------
		this.tabpage_access.dw_access.Modify("datawindow.readonly = " + ls_readonly )
		if ls_readonly = 'no' then
			this.tabpage_access.cb_add.enabled = true
			this.tabpage_access.cb_delete.enabled = true
		else
			this.tabpage_access.cb_add.enabled = false
			this.tabpage_access.cb_delete.enabled = false
		end if
	end if
end if
end event

event constructor;call super::constructor;int li_right
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.07.2006 By: LeiWei
//$<reason> Performance tuning.
This.Selecttab(2)			//initialization the tab2
This.Selecttab(3)			////Added By mark 03/23/12 initialization the tab3
This.Selecttab(4)			////Added By mark 03/23/12 initialization the tab4
This.Selecttab(1)			//Set the tab1 as the default tabpage
//---------------------------- APPEON END ----------------------------


//Set group access - jervis 12.02.2010
li_right = w_mdi.of_security_access(6951)			//Group Access for ctx
ii_accessright = li_right //(Appeon)Toney 11.29.2013 - V141 ISG-CLX,Fix history BugT101503,append readonly security control 
if li_right = 0 or gnv_data.of_GetItem( "icred_settings", "group_access", False ) = '0' then
	this.tabpage_access.visible = false
else
	//li_right = w_mdi.of_security_access(6951)			//Group Access for company
	if gnv_data.of_GetItem( "icred_settings", "company_group_access", False ) = '0' then 
		this.tabpage_access.visible = false
	end if
end if

end event

type tabpage_contact_search from u_tabpg_cntct_search within u_tab_cntx
integer x = 18
integer y = 112
integer width = 3881
integer height = 2072
string text = "Search"
string picturename = "Search!"
long picturemaskcolor = 12632256
end type

event dragdrop;call super::dragdrop;

IW_parent.FUNCTION DYNAMIC PFC_UPDATE()
end event

type tabpage_details from u_tabpg_cntct_details within u_tab_cntx
integer x = 18
integer y = 112
integer width = 3881
integer height = 2072
string text = "Details"
string picturename = "ArrangeTables!"
long picturemaskcolor = 12632256
end type

type tabpage_custom from u_tabpg_cntct_custom within u_tab_cntx
integer x = 18
integer y = 112
integer width = 3881
integer height = 2072
string text = "Custom"
string picturename = "Custom081!"
long picturemaskcolor = 12632256
end type

type tabpage_access from u_tabpg_cntct_access within u_tab_cntx
integer x = 18
integer y = 112
integer width = 3881
integer height = 2072
string text = "Group Access"
string picturename = "ArrangeIcons!"
end type

