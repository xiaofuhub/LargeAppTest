$PBExportHeader$w_wv_select_ldap_user.srw
forward
global type w_wv_select_ldap_user from window
end type
type tv_select from treeview within w_wv_select_ldap_user
end type
type cb_cancel from commandbutton within w_wv_select_ldap_user
end type
type cb_select from commandbutton within w_wv_select_ldap_user
end type
end forward

global type w_wv_select_ldap_user from window
integer width = 1257
integer height = 1320
boolean titlebar = true
string title = "Select LDAP User"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
tv_select tv_select
cb_cancel cb_cancel
cb_select cb_select
end type
global w_wv_select_ldap_user w_wv_select_ldap_user

type variables

end variables

forward prototypes
public function integer of_createtree ()
end prototypes

public function integer of_createtree ();//====================================================================
// $<function> of_CreateTree()
// $<arguments>
// $<returns> integer
// $<description> Create tree
// $<add> (Appeon) evan 03.07.2012
//====================================================================

long j, ll_Count
long i, ll_handle[]
datastore lds_data
treeviewitem ltvi_app
treeviewitem ltvi_user
string ls_appname_old
string ls_appname_curr

lds_data = Create datastore
lds_data.DataObject = "d_wv_ldap_users_tv"
lds_data.SetTransObject(SQLCA)
lds_data.Retrieve()

// Create application nodes
ll_Count = lds_data.RowCount()
for i = 1 to ll_Count
	ls_appname_curr = lds_data.GetItemString(i, "appname")
	if ls_appname_curr <> ls_appname_old then
		ltvi_app.data = ls_appname_curr
		ltvi_app.label = ls_appname_curr
		ltvi_app.PictureIndex = 1
		ltvi_app.SelectedPictureIndex = 2
		ll_handle[UpperBound(ll_handle) + 1] = tv_select.InsertItemLast(0, ltvi_app)
	end if
	ls_appname_old = ls_appname_curr
next

// Create user nodes
ll_Count = UpperBound(ll_handle[])
for i = 1 to ll_Count
	tv_select.GetItem(ll_handle[i], ltvi_app)
	ls_appname_curr = ltvi_app.data
	lds_data.SetFilter("(not isnull(ldap_user)) and (appname = '" + ls_appname_curr + "')")
	lds_data.Filter()
	lds_data.SetSort("ldap_user")
	lds_data.Sort()
	if lds_data.RowCount() > 0 then
		ltvi_app.children = true
		tv_select.SetItem(ll_handle[i], ltvi_app)
	end if
	for j = 1 to lds_data.RowCount()
		ltvi_user.data = lds_data.GetItemString(j, "ldap_user")
		ltvi_user.label = lds_data.GetItemString(j, "ldap_user")
		ltvi_user.PictureIndex = 3
		ltvi_user.SelectedPictureIndex = 4
		tv_select.InsertItemLast(ll_handle[i], ltvi_user)
	next
	tv_select.ExpandItem(ll_handle[i])
next

Destroy lds_data

Return 1
end function

on w_wv_select_ldap_user.create
this.tv_select=create tv_select
this.cb_cancel=create cb_cancel
this.cb_select=create cb_select
this.Control[]={this.tv_select,&
this.cb_cancel,&
this.cb_select}
end on

on w_wv_select_ldap_user.destroy
destroy(this.tv_select)
destroy(this.cb_cancel)
destroy(this.cb_select)
end on

event open;//====================================================================
// $<event> open()
// $<arguments>
// $<returns> long
// $<description> Open event
// $<add> (Appeon) evan 03.07.2012
//====================================================================

of_CreateTree()


end event

type tv_select from treeview within w_wv_select_ldap_user
integer x = 14
integer y = 8
integer width = 1221
integer height = 1096
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
boolean hideselection = false
string picturename[] = {"ApplicationIcon!","Application5!","Custom026!","Custom027!"}
long picturemaskcolor = 12632256
long statepicturemaskcolor = 536870912
end type

event doubleclicked;//====================================================================
// $<event> doubleclicked()
// $<arguments>
//		value long	handle
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 03.07.2012
//====================================================================

cb_select.Event Clicked()
end event

type cb_cancel from commandbutton within w_wv_select_ldap_user
integer x = 773
integer y = 1112
integer width = 343
integer height = 92
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Close
// $<add> (Appeon) evan 03.07.2012
//====================================================================

CloseWithReturn(Parent, "")
end event

type cb_select from commandbutton within w_wv_select_ldap_user
integer x = 421
integer y = 1112
integer width = 343
integer height = 92
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select"
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Select user
// $<add> (Appeon) evan 03.07.2012
//====================================================================

long ll_Handle
string ls_ldap_user
treeviewitem ltvi_item

ll_Handle = tv_select.FindItem(CurrentTreeItem!, 0)
tv_select.GetItem(ll_Handle, ltvi_item)

if ll_Handle = -1 or ltvi_item.SelectedPictureIndex <> 4 then
	MessageBox("Select", "Please select LDAP user.", Exclamation!)
	Return
end if

ls_ldap_user = ltvi_item.label

CloseWithReturn(Parent, ls_ldap_user)
end event

