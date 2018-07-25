$PBExportHeader$w_wv_role_management.srw
forward
global type w_wv_role_management from w_sheet
end type
type dw_right from u_dw within w_wv_role_management
end type
type st_4 from statictext within w_wv_role_management
end type
type st_3 from statictext within w_wv_role_management
end type
type st_2 from statictext within w_wv_role_management
end type
type dw_module from u_dw within w_wv_role_management
end type
type dw_module_sub from u_dw within w_wv_role_management
end type
type cb_copy from commandbutton within w_wv_role_management
end type
type cb_create from commandbutton within w_wv_role_management
end type
type cb_rename from commandbutton within w_wv_role_management
end type
type gb_2 from groupbox within w_wv_role_management
end type
type gb_1 from groupbox within w_wv_role_management
end type
type cb_close from commandbutton within w_wv_role_management
end type
type tab_1 from tab within w_wv_role_management
end type
type tabpage_1 from userobject within tab_1
end type
type st_1 from statictext within tabpage_1
end type
type cbx_3 from checkbox within tabpage_1
end type
type cbx_2 from checkbox within tabpage_1
end type
type cbx_1 from checkbox within tabpage_1
end type
type tabpage_1 from userobject within tab_1
st_1 st_1
cbx_3 cbx_3
cbx_2 cbx_2
cbx_1 cbx_1
end type
type tab_1 from tab within w_wv_role_management
tabpage_1 tabpage_1
end type
type dw_role from u_dw within w_wv_role_management
end type
type cb_delete from commandbutton within w_wv_role_management
end type
end forward

global type w_wv_role_management from w_sheet
integer width = 3086
integer height = 1836
string title = "WebView Access Role Management"
boolean maxbox = false
long backcolor = 33551856
dw_right dw_right
st_4 st_4
st_3 st_3
st_2 st_2
dw_module dw_module
dw_module_sub dw_module_sub
cb_copy cb_copy
cb_create cb_create
cb_rename cb_rename
gb_2 gb_2
gb_1 gb_1
cb_close cb_close
tab_1 tab_1
dw_role dw_role
cb_delete cb_delete
end type
global w_wv_role_management w_wv_role_management

type variables
long il_role_id = 0

end variables

forward prototypes
public function integer of_createrole (string as_type)
end prototypes

public function integer of_createrole (string as_type);//====================================================================
// $<function> of_createrole
// $<arguments>
// 	value	string	as_type
// $<returns> integer
// $<description> Create and copy role
// $<add> (Appeon) evan 02.20.2012
//====================================================================

integer i, li_rc
long ll_role_id
long ll_role_right_id
long ll_value_id = 2
string ls_role_name
datastore lds_rights

// Get new role name
if as_Type = "Copy!" then
	li_rc = dw_role.Event ue_GetRoleName(il_role_id, ls_role_name)
	if li_rc = -1 then Return -1
	li_rc = MessageBox("Copy Role", "Are you sure you want to copy the role named " + ls_role_name + "?", Question!, YesNo!)
	if li_rc = 2 then Return -1
end if
Open(w_wv_get_role_name)
ls_role_name = Message.StringParm
if ls_role_name = "" then Return -1

// Get role_id and role_right_id max values
gnv_appeondb.of_StartQueue()
SELECT max(role_id) INTO :ll_role_id FROM wv_security_role;
SELECT max(role_right_id) INTO :ll_role_right_id FROM wv_security_role_right;
gnv_appeondb.of_CommitQueue()
if IsNull(ll_role_id) then ll_role_id = 0;
if IsNull(ll_role_right_id) then ll_role_right_id = 0;
ll_role_id ++

// Insert connected records
lds_rights = Create datastore
lds_rights.DataObject = "d_wv_security_right_upd"
lds_rights.SetTransObject(SQLCA)

if as_Type = "Create!" then
	gnv_appeondb.of_StartQueue()
	INSERT INTO wv_security_role (role_id, role_name)
		VALUES (:ll_role_id, :ls_role_name);
	INSERT INTO	wv_security_role_right (role_id, action_id, value_id)
		SELECT :ll_role_id, action_id, :ll_value_id FROM wv_security_right_action;
	lds_rights.Retrieve(ll_role_id)
	gnv_appeondb.of_CommitQueue()
else
	gnv_appeondb.of_StartQueue()
	INSERT INTO wv_security_role (role_id, role_name)
		VALUES (:ll_role_id, :ls_role_name);
	INSERT INTO	wv_security_role_right (role_id, action_id, value_id)
		SELECT :ll_role_id, action_id, value_id FROM wv_security_role_right WHERE role_id = :il_role_id;
	lds_rights.Retrieve(ll_role_id)
	gnv_appeondb.of_CommitQueue()
end if

for i = 1 to lds_rights.RowCount()
	ll_role_right_id ++
	lds_rights.SetItem(i, "role_right_id", ll_role_right_id)
next
lds_rights.Update()
Destroy lds_rights

// Refresh role name dddw
dw_role.Event ue_SetRoleName(ll_role_id, ls_role_name)

Return 1
end function

on w_wv_role_management.create
int iCurrent
call super::create
this.dw_right=create dw_right
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.dw_module=create dw_module
this.dw_module_sub=create dw_module_sub
this.cb_copy=create cb_copy
this.cb_create=create cb_create
this.cb_rename=create cb_rename
this.gb_2=create gb_2
this.gb_1=create gb_1
this.cb_close=create cb_close
this.tab_1=create tab_1
this.dw_role=create dw_role
this.cb_delete=create cb_delete
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_right
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.dw_module
this.Control[iCurrent+6]=this.dw_module_sub
this.Control[iCurrent+7]=this.cb_copy
this.Control[iCurrent+8]=this.cb_create
this.Control[iCurrent+9]=this.cb_rename
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.cb_close
this.Control[iCurrent+13]=this.tab_1
this.Control[iCurrent+14]=this.dw_role
this.Control[iCurrent+15]=this.cb_delete
end on

on w_wv_role_management.destroy
call super::destroy
destroy(this.dw_right)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_module)
destroy(this.dw_module_sub)
destroy(this.cb_copy)
destroy(this.cb_create)
destroy(this.cb_rename)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.cb_close)
destroy(this.tab_1)
destroy(this.dw_role)
destroy(this.cb_delete)
end on

type dw_right from u_dw within w_wv_role_management
integer x = 1993
integer y = 492
integer width = 983
integer height = 1068
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_wv_security_right"
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//====================================================================
// $<event> constructor()
// $<arguments>
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 02.15.2012
//====================================================================

this.SetTransObject(SQLCA)
this.of_SetUpdateAble(false)
this.of_SetRowSelect(true)
end event

event itemchanged;call super::itemchanged;//====================================================================
// $<event> itemchanged()
// $<arguments>
//		value long		row
//		value dwobject	dwo
//		value string	data
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 02.16.2012
//====================================================================

long ll_value_id
long ll_action_id

ll_value_id = Long(data)
ll_action_id = this.GetItemNumber(Row, "action_id")

// Update access right
gnv_appeondb.of_StartQueue()
UPDATE wv_security_role_right
	SET value_id = :ll_value_id
WHERE	action_id = :ll_action_id AND role_id = :il_role_id;
COMMIT;
gnv_appeondb.of_CommitQueue()
end event

type st_4 from statictext within w_wv_role_management
integer x = 2025
integer y = 436
integer width = 288
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Access"
boolean focusrectangle = false
end type

type st_3 from statictext within w_wv_role_management
integer x = 1051
integer y = 436
integer width = 288
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Function"
boolean focusrectangle = false
end type

type st_2 from statictext within w_wv_role_management
integer x = 96
integer y = 436
integer width = 288
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Module"
boolean focusrectangle = false
end type

type dw_module from u_dw within w_wv_role_management
integer x = 69
integer y = 492
integer width = 937
integer height = 1068
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_wv_security_module"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//====================================================================
// $<event> constructor()
// $<arguments>
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 02.15.2012
//====================================================================

this.SetTransObject(SQLCA)
this.of_SetUpdateAble(false)
this.of_SetRowSelect(true)
end event

event rowfocuschanged;call super::rowfocuschanged;//====================================================================
// $<event> rowfocuschanged()
// $<arguments>
// 	value	long	currentrow
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 02.15.2012
//====================================================================

long ll_module_id

// Reset detail data
dw_right.Reset()
dw_module_sub.Reset()

// Retrieve submodules
if CurrentRow > 0 then
	ll_module_id = this.GetItemNumber(CurrentRow, "module_id")
	dw_module_sub.Retrieve(ll_module_id)
end if
end event

type dw_module_sub from u_dw within w_wv_role_management
integer x = 1029
integer y = 492
integer width = 937
integer height = 1068
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_wv_security_module_sub"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//====================================================================
// $<event> constructor()
// $<arguments>
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 02.15.2012
//====================================================================

this.SetTransObject(SQLCA)
this.of_SetUpdateAble(false)
this.of_SetRowSelect(true)
end event

event rowfocuschanged;call super::rowfocuschanged;//====================================================================
// $<event> rowfocuschanged()
// $<arguments>
// 	value	long	currentrow
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 02.15.2012
//====================================================================

long ll_module_id

// Retrieve access rights
dw_right.Reset()
if CurrentRow > 0 then
	ll_module_id = this.GetItemNumber(CurrentRow, "module_id")
	dw_right.Retrieve(il_role_id, ll_module_id)
end if
end event

type cb_copy from commandbutton within w_wv_role_management
integer x = 2235
integer y = 224
integer width = 343
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Co&py Role"
boolean cancel = true
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Copy role
// $<add> (Appeon) evan 02.17.2012
//====================================================================

of_CreateRole("Copy!")
end event

type cb_create from commandbutton within w_wv_role_management
integer x = 1513
integer y = 224
integer width = 343
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Create Role"
boolean cancel = true
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Create role
// $<add> (Appeon) evan 02.17.2012
//====================================================================

of_CreateRole("Create!")
end event

type cb_rename from commandbutton within w_wv_role_management
integer x = 2597
integer y = 224
integer width = 370
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Rename Role"
boolean cancel = true
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Rename role
// $<add> (Appeon) evan 02.16.2012
//====================================================================

integer li_rc
string ls_role_name

// Get new role name
li_rc = dw_role.Event ue_GetRoleName(il_role_id, ls_role_name)
if li_rc = -1 then Return
li_rc = MessageBox("Rename Role", "Are you sure you want to rename the role named " + ls_role_name + "?", Question!, YesNo!)
if li_rc = 2 then Return
Open(w_wv_get_role_name)
ls_role_name = Message.StringParm
if ls_role_name = "" then Return

// Rename role
gnv_appeondb.of_StartQueue()
UPDATE wv_security_role
	SET role_name = :ls_role_name
WHERE	role_id = :il_role_id;
COMMIT;
gnv_appeondb.of_CommitQueue()
dw_role.Event ue_SetRoleName(il_role_id, ls_role_name)
end event

type gb_2 from groupbox within w_wv_role_management
integer x = 50
integer y = 380
integer width = 2949
integer height = 1192
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Role Settings"
end type

type gb_1 from groupbox within w_wv_role_management
integer x = 46
integer y = 136
integer width = 2953
integer height = 228
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Role"
end type

type cb_close from commandbutton within w_wv_role_management
integer x = 2638
integer y = 4
integer width = 343
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clos&e"
boolean cancel = true
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Close
// $<add> (Appeon) evan 02.13.2012
//====================================================================

Close(Parent)
end event

type tab_1 from tab within w_wv_role_management
integer x = 5
integer y = 8
integer width = 3026
integer height = 1708
boolean enabled = false
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
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_1)
end on

event selectionchanged;//====================================================================
// $<event> selectionchanged()
// $<arguments>
// 	value	integer	oldindex
// 	value	integer	newindex
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 02.13.2012
//====================================================================


end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2990
integer height = 1592
long backcolor = 33551856
string text = "Webview"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
st_1 st_1
cbx_3 cbx_3
cbx_2 cbx_2
cbx_1 cbx_1
end type

on tabpage_1.create
this.st_1=create st_1
this.cbx_3=create cbx_3
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.Control[]={this.st_1,&
this.cbx_3,&
this.cbx_2,&
this.cbx_1}
end on

on tabpage_1.destroy
destroy(this.st_1)
destroy(this.cbx_3)
destroy(this.cbx_2)
destroy(this.cbx_1)
end on

type st_1 from statictext within tabpage_1
integer x = 1413
integer y = 1508
integer width = 352
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Access Key :"
boolean focusrectangle = false
end type

type cbx_3 from checkbox within tabpage_1
integer x = 2624
integer y = 1504
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Full Access"
boolean checked = true
end type

type cbx_2 from checkbox within tabpage_1
integer x = 2117
integer y = 1504
integer width = 480
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Read-only Access"
boolean threestate = true
boolean thirdstate = true
end type

type cbx_1 from checkbox within tabpage_1
integer x = 1774
integer y = 1504
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "No Access"
end type

type dw_role from u_dw within w_wv_role_management
event type integer ue_getrolename ( long al_role_id,  ref string as_role_name )
event type integer ue_setrolename ( long al_role_id,  string as_role_name )
event type integer ue_deleterole ( long al_role_id )
integer x = 78
integer y = 228
integer width = 1417
integer height = 96
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_wv_select_role"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type integer ue_getrolename(long al_role_id, ref string as_role_name);//====================================================================
// $<event> ue_getrolename()
// $<arguments>
//		value long	al_role_id
// 	ref string	as_role_name
// $<returns> integer
// $<description> Get role name
// $<add> (Appeon) evan 02.16.2012
//====================================================================

long ll_Row
datawindowchild ldwc_child

if IsNull(al_role_id) or al_role_id < 1 then Return -1

this.GetChild("role_id", ldwc_child)
ll_Row = ldwc_child.Find("role_id=" + String(al_role_id), 1, ldwc_child.RowCount())
if ll_Row < 1 then Return -1

as_role_name = ldwc_child.GetItemString(ll_Row, "role_name")

Return 1
end event

event type integer ue_setrolename(long al_role_id, string as_role_name);//====================================================================
// $<event> ue_setrolename()
// $<arguments>
//		value long		al_role_id
// 	value string	as_role_name
// $<returns> integer
// $<description> Set role name
// $<add> (Appeon) evan 02.16.2012
//====================================================================

long ll_Row
datawindowchild ldwc_child

if IsNull(al_role_id) or al_role_id < 1 then Return -1

this.GetChild("role_id", ldwc_child)
ll_Row = ldwc_child.Find("role_id=" + String(al_role_id), 1, ldwc_child.RowCount())
if ll_Row > 0 then
	ldwc_child.SetItem(ll_Row, "role_name", as_role_name)
	this.SetItem(1, "role_id", al_role_id)
else
	ll_Row = ldwc_child.InsertRow(0)
	ldwc_child.SetItem(ll_Row, "role_id", al_role_id)
	ldwc_child.SetItem(ll_Row, "role_name", as_role_name)
	this.SetItem(1, "role_id", al_role_id)
	this.Event ItemChanged(1, this.object.role_id, String(al_role_id))
end if

ldwc_child.Sort()
ldwc_child.SelectRow(0, false)

Return 1
end event

event type integer ue_deleterole(long al_role_id);//====================================================================
// $<event> ue_deleterole()
// $<arguments>
//		value long	al_role_id
// $<returns> integer
// $<description> Delete role
// $<add> (Appeon) evan 02.17.2012
//====================================================================

long ll_Row
datawindowchild ldwc_child

if IsNull(al_role_id) or al_role_id < 1 then Return -1

// Delete role
this.GetChild("role_id", ldwc_child)
ll_Row = ldwc_child.Find("role_id=" + String(al_role_id), 1, ldwc_child.RowCount())
if ll_Row > 0 then
	ldwc_child.DeleteRow(ll_Row)
end if

// Set default role
if ldwc_child.RowCount() > 0 then
	al_role_id = ldwc_child.GetItemNumber(1, "role_id")
	this.SetItem(1, "role_id", al_role_id)
	this.Event ItemChanged(1, this.object.role_id, String(al_role_id))
else
	SetNull(al_role_id)
	this.SetItem(1, "role_id", al_role_id)
	dw_right.Reset()
	dw_module_sub.Reset()
	dw_module.Reset()
end if

Return 1
end event

event constructor;call super::constructor;//====================================================================
// $<event> constructor()
// $<arguments>
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 02.15.2012
//====================================================================

this.SetTransObject(SQLCA)
this.of_SetUpdateAble(false)
this.InsertRow(0)
end event

event itemchanged;call super::itemchanged;//====================================================================
// $<event> itemchanged()
// $<arguments>
//		value long		row
//		value dwobject	dwo
//		value string	data
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 02.15.2012
//====================================================================

// Get role id
il_role_id = Long(data)

// Retrieve modules
if dw_module.RowCount() < 1 then
	dw_module.Retrieve()
else
	if dw_module.RowCount() > 0 then
		if dw_module.GetRow() = 1 then
			dw_module.Event RowFocusChanged(1)
		else
			dw_module.ScrollToRow(1)
		end if
	else
		dw_right.Reset()
		dw_module_sub.Reset()
	end if
end if

dw_module.SelectRow(0, false)
dw_module.SelectRow(1, true)
end event

type cb_delete from commandbutton within w_wv_role_management
integer x = 1874
integer y = 224
integer width = 343
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete Role"
boolean cancel = true
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Delete role
// $<add> (Appeon) evan 02.17.2012
//====================================================================

long li_rc
long ll_count //maha 02.03.2014
string ls_role_name

// Delete confirmation
li_rc = dw_role.Event ue_GetRoleName(il_role_id, ls_role_name)
if li_rc = -1 then Return

//Start Code Change ----02.03.2014 #V14 maha
//---------Begin Modified by (Appeon)Stephen 03.01.2016 for Bug #5012- Can't delete WebView role because it is connected to user role with same ID--------
//select count(*) into :ll_count from security_users where role_id = :il_role_id;
select count(*) into :ll_count from security_users where wv_role_id = :il_role_id;
//---------End Modfiied ------------------------------------------------------

if ll_count > 0 then 
	messagebox('Delete','This role is connected to ' + string(ll_count) + ' user(s) and cannot be deleted.',Exclamation!)
	Return -1
end if
//End Code Change ----02.03.2014

li_rc = MessageBox("Delete Role", "Are you sure you want to permanently delete the role named " + ls_role_name + "?", Question!, YesNo!)
if li_rc = 2 then Return

// Delete connected records
gnv_appeondb.of_StartQueue()
DELETE FROM	wv_security_role_right WHERE role_id = :il_role_id;
DELETE FROM	wv_security_role WHERE role_id = :il_role_id;
COMMIT;
gnv_appeondb.of_CommitQueue()
dw_role.Event ue_DeleteRole(il_role_id)
end event

