$PBExportHeader$n_cst_backcolor_settings.sru
forward
global type n_cst_backcolor_settings from nonvisualobject
end type
end forward

global type n_cst_backcolor_settings from nonvisualobject
end type
global n_cst_backcolor_settings n_cst_backcolor_settings

type variables
long il_win_backcolor

DataStore ids_window
end variables

forward prototypes
public function integer of_changewindowbackcolor (window aw_window)
public function long of_getobjectbackcolor (string as_type, powerobject apo_object)
public function integer of_setobjectbackcolor (powerobject apo_object)
public function long of_getdefaultviewwinbackcolor ()
end prototypes

public function integer of_changewindowbackcolor (window aw_window);//////////////////////////////////////////////////////////////////////
// $<function>  of_changewindowbackcolor
// $<arguments> 
// 		window	aw_window
// $<returns>   integer
// $<description> Change back color of window and all child objects
//////////////////////////////////////////////////////////////////////
// $<add> 11/20/2008 by Evan
//////////////////////////////////////////////////////////////////////

long ll_FindRow
long ll_BackColor
string ls_WinName

if not IsValid(aw_window) then Return -1
if not gb_contract_version then Return -1
	
ls_WinName = aw_window.ClassName()
ll_FindRow = ids_window.Find("win_name = '" + ls_WinName + "'", 1, ids_window.RowCount())
if ll_FindRow <= 0 then Return -1

choose case ls_WinName
	case "w_contract"
		ll_BackColor = of_GetObjectBackColor("window!", aw_window)
		if IsNull(ll_BackColor) then ll_BackColor =  67108864
		
		aw_Window.Dynamic of_SetBkColor(ll_BackColor)
	case else
		of_SetObjectBackcolor(aw_window)
end choose

Return 1

end function

public function long of_getobjectbackcolor (string as_type, powerobject apo_object);//////////////////////////////////////////////////////////////////////
// $<function>  of_getobjectbackcolor
// $<arguments> 
//			string		as_type
// 		powerobject	apo_object
// $<returns>   long
// $<description> Get object back color
//////////////////////////////////////////////////////////////////////
// $<add> 11/20/2008 by Evan
//////////////////////////////////////////////////////////////////////

/*
You can get back color according to following methods:
1. Get back color from Datastore according to as_Type
2. Get back color from Datastore according to apo_Object.ClassName()
*/

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2009-07-10 By: Ken.Guo
//$<reason> Get View ID from Contract if contract window is opened.
Long ll_ctx_view_id,ll_row
Long ll_win_ctx_backcolor
string ls_value
If isvalid(gw_contract) Then
	If gw_contract.tab_contract_details.tabpage_search.dw_search_det1.RowCount() > 0 Then
		ls_value = gnv_data.of_getitem( 'data_view','win_backcolor', 'data_view_id = ' + String(gw_contract.il_data_view_id) )
		if (not isnumber(ls_value)) or isnull(ls_value) then  //Add by jervis 12.27.2010
			setnull(ll_win_ctx_backcolor)	
		else
			ll_win_ctx_backcolor =  Long(ls_value	)
		end if
		Return ll_win_ctx_backcolor
	End If
End If
//---------------------------- APPEON END ----------------------------

Return il_win_backcolor
end function

public function integer of_setobjectbackcolor (powerobject apo_object);//////////////////////////////////////////////////////////////////////
// $<function>  of_setobjectbackcolor
// $<arguments> 
// 		powerobject	apo_object
// $<returns>   integer
// $<description> Modify object back color
//////////////////////////////////////////////////////////////////////
// $<add> 11/20/2008 by Evan
//////////////////////////////////////////////////////////////////////

window            lwo_window
tab               lwo_tab
userobject        lwo_userobject
//
checkbox          lwo_checkbox
//commandbutton     lwo_commandbutton
datawindow        lwo_datawindow
//dropdownlistbox   lwo_dropdownlistbox
graph             lwo_graph
groupbox          lwo_groupbox
//hprogressbar      lwo_hprogressbar
//hscrollbar        lwo_hscrollbar
//htrackbar         lwo_htrackbar
//listbox           lwo_listbox
//listview          lwo_listview
//multilineedit     lwo_multilineedit
//omcontrol         lwo_omcontrol
//picture           lwo_picture
radiobutton       lwo_radiobutton
//richtextedit      lwo_richtextedit
statictext        lwo_statictext
statichyperlink   lwo_statichyperlike
//treeview          lwo_treeview
//vprogressbar      lwo_vprogressbar
//vscrollbar        lwo_vscrollbar
//vtrackbar         lwo_vtrackbar
//
//line              lwo_line
oval              lwo_oval
rectangle         lwo_rectangle
roundrectangle    lwo_roundrectangle
//
long    ll_BackColor
integer i, li_Count

if not IsValid(apo_object) then Return -1
if not gb_contract_version then Return -1

choose case apo_object.TypeOf()
	// Container objects
	case window!
		lwo_window = apo_object
		ll_BackColor = of_GetObjectBackColor("window!", apo_object)
		if not IsNull(ll_BackColor) then lwo_window.BackColor = ll_BackColor
		li_Count = UpperBound(lwo_window.control[])
		for i = 1 to li_Count
			of_SetObjectBackColor(lwo_window.control[i])
		next
	case tab!
		lwo_tab = apo_object
		ll_BackColor = of_GetObjectBackColor("tab!", apo_object)
		if not IsNull(ll_BackColor) then lwo_tab.BackColor = ll_BackColor
		li_Count = UpperBound(lwo_tab.control[])
		for i = 1 to li_Count
			of_SetObjectBackColor(lwo_tab.control[i])
		next
	case userobject!
		lwo_userobject = apo_object
		ll_BackColor = of_GetObjectBackColor("userobject!", apo_object)
		if not IsNull(ll_BackColor) then
			lwo_userobject.BackColor = ll_BackColor
			lwo_userobject.TabBackColor = ll_BackColor
		end if
		li_Count = UpperBound(lwo_userobject.control[])
		for i = 1 to li_Count
			of_SetObjectBackColor(lwo_userobject.control[i])
		next
	// Control objects
	case datawindow!
		lwo_datawindow = apo_object
		ll_BackColor = of_GetObjectBackColor("datawindow!", apo_object)
		if not IsNull(ll_BackColor) then
			lwo_datawindow.Modify("datawindow.color=" + String(ll_BackColor))
		end if
	case checkbox!
		lwo_checkbox = apo_object
		ll_BackColor = of_GetObjectBackColor("checkbox!", apo_object)
		if not IsNull(ll_BackColor) then lwo_checkbox.BackColor = ll_BackColor
	case graph!
		lwo_graph = apo_object
		ll_BackColor = of_GetObjectBackColor("graph!", apo_object)
		if not IsNull(ll_BackColor) then lwo_graph.BackColor = ll_BackColor		
	case groupbox!
		lwo_groupbox = apo_object
		ll_BackColor = of_GetObjectBackColor("groupbox!", apo_object)
		if not IsNull(ll_BackColor) then lwo_groupbox.BackColor = ll_BackColor
	case radiobutton!
		lwo_radiobutton = apo_object
		ll_BackColor = of_GetObjectBackColor("radiobutton!", apo_object)
		if not IsNull(ll_BackColor) then lwo_radiobutton.BackColor = ll_BackColor
	case statictext!
      lwo_statictext = apo_object
		ll_BackColor = of_GetObjectBackColor("statictext!", apo_object)
		if not IsNull(ll_BackColor) then	lwo_statictext.BackColor = ll_BackColor
	case statichyperlink!
		lwo_statichyperlike = apo_object
		ll_BackColor = of_GetObjectBackColor("statichyperlink!", apo_object)
		if not IsNull(ll_BackColor) then lwo_statichyperlike.BackColor = ll_BackColor
	case oval!
		lwo_oval = apo_object
		ll_BackColor = of_GetObjectBackColor("oval!", apo_object)
		if not IsNull(ll_BackColor) then lwo_oval.FillColor = ll_BackColor
	case rectangle!
		lwo_rectangle = apo_object
		ll_BackColor = of_GetObjectBackColor("rectangle!", apo_object)
		if not IsNull(ll_BackColor) then lwo_rectangle.FillColor = ll_BackColor
	case roundrectangle!
		lwo_roundrectangle = apo_object
		ll_BackColor = of_GetObjectBackColor("roundrectangle!", apo_object)
		if not IsNull(ll_BackColor) then lwo_roundrectangle.FillColor = ll_BackColor
	case else
		Return -1
end choose

Return 1
end function

public function long of_getdefaultviewwinbackcolor ();//////////////////////////////////////////////////////////////////////
// $<function>  of_getdefaultviewwinbackcolor
// $<arguments> (None)
// $<returns>   long
// $<description> Get window back color of default view
//////////////////////////////////////////////////////////////////////
// $<add> 11/25/2008 by Evan
//////////////////////////////////////////////////////////////////////

SetNull(il_win_backcolor)

SELECT data_view.win_backcolor INTO :il_win_backcolor
FROM  security_users, data_view
WHERE data_view.data_view_id = security_users.contract_default_view AND
      security_users.user_id = :gs_user_id;

Return il_win_backcolor
end function

on n_cst_backcolor_settings.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_backcolor_settings.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//////////////////////////////////////////////////////////////////////
// $<event>  constructor
// $<arguments> 
// $<returns>   long
// $<description> constructor
//////////////////////////////////////////////////////////////////////
// $<add> 11/20/2008 by Evan
//////////////////////////////////////////////////////////////////////

SetNull(il_win_backcolor)

ids_window = Create DataStore
ids_window.DataObject = "d_backcolor_windows"
end event

event destructor;//////////////////////////////////////////////////////////////////////
// $<event>  destructor
// $<arguments> 
// $<returns>   long
// $<description> destructor
//////////////////////////////////////////////////////////////////////
// $<add> 11/20/2008 by Evan
//////////////////////////////////////////////////////////////////////

Destroy ids_window
end event

