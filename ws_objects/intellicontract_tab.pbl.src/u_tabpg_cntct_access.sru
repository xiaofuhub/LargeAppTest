$PBExportHeader$u_tabpg_cntct_access.sru
forward
global type u_tabpg_cntct_access from u_tabpg
end type
type cb_setdefault from commandbutton within u_tabpg_cntct_access
end type
type cb_add from commandbutton within u_tabpg_cntct_access
end type
type cb_delete from commandbutton within u_tabpg_cntct_access
end type
type dw_access from u_dw_contract within u_tabpg_cntct_access
end type
end forward

global type u_tabpg_cntct_access from u_tabpg
integer width = 3899
integer height = 1936
long backcolor = 33551856
cb_setdefault cb_setdefault
cb_add cb_add
cb_delete cb_delete
dw_access dw_access
end type
global u_tabpg_cntct_access u_tabpg_cntct_access

type variables
long il_facility_id
end variables

forward prototypes
public subroutine of_set_facility_id (long al_facility_id)
end prototypes

public subroutine of_set_facility_id (long al_facility_id);il_facility_id = al_facility_id
end subroutine

on u_tabpg_cntct_access.create
int iCurrent
call super::create
this.cb_setdefault=create cb_setdefault
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.dw_access=create dw_access
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_setdefault
this.Control[iCurrent+2]=this.cb_add
this.Control[iCurrent+3]=this.cb_delete
this.Control[iCurrent+4]=this.dw_access
end on

on u_tabpg_cntct_access.destroy
call super::destroy
destroy(this.cb_setdefault)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.dw_access)
end on

type cb_setdefault from commandbutton within u_tabpg_cntct_access
integer x = 2715
integer y = 1824
integer width = 384
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Set As Default"
end type

event clicked;
if dw_access.Modifiedcount( ) + dw_access.filteredcount( ) > 0 then
	MessageBox("Set As Default",'Please save the data.')
	return
end if
delete app_facility_default_access where Upper(user_id) = Upper(:gs_user_id);
insert app_facility_default_access(user_id,group_id,access,notes)
select :gs_user_id,group_id,access,notes
from app_facility_group_access
where facility_id = :il_facility_id;
commit;
end event

type cb_add from commandbutton within u_tabpg_cntct_access
integer x = 3127
integer y = 1824
integer width = 361
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Access"
end type

event clicked;if dw_access.Describe("datawindow.readonly") = "yes" then return
dw_access.event pfc_addrow( )
//dw_access.insertRow( 0)

end event

type cb_delete from commandbutton within u_tabpg_cntct_access
integer x = 3515
integer y = 1824
integer width = 361
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete Access"
end type

event clicked;if dw_access.Describe("datawindow.readonly") = "yes" then return
dw_access.event pfc_deleterow( )
end event

type dw_access from u_dw_contract within u_tabpg_cntct_access
string tag = "Contact For Group Access"
integer x = 9
integer y = 16
integer width = 3867
integer height = 1788
integer taborder = 10
boolean titlebar = true
string title = "Company For Group Access"
string dataobject = "d_facility_group_access"
boolean border = false
end type

event constructor;call super::constructor;gnv_win_backcolor.of_SetObjectBackColor(this) //Add by Evan 11/24/2008
ib_rmbmenu = false

datawindowchild ldwc

if this.GetChild( 'group_id', ldwc) = 1 then
	ldwc.SetTransobject( sqlca)
	ldwc.Retrieve( )
end if
end event

event getfocus;call super::getfocus;this.border = true

end event

event pfc_preupdate;call super::pfc_preupdate;
LONG LL_I


FOR LL_I = 1 TO ROWCOUNT( )
   THIS.OBJECT.facility_id[LL_I] = il_facility_id
NEXT



RETURN SUCcess
end event

event pfc_retrieve;call super::pfc_retrieve;long ll_count
if il_facility_id > 0 then
	ll_count = this.retrieve( il_facility_id)
	if ll_count < 1 then cb_add.event clicked( )
end if
return ll_count
end event

event itemchanged;call super::itemchanged;//---------Begin Added by (Appeon)Toney 11.29.2013 for V141 ISG-CLX--------
//$Reason:Fix history BugT101502,Append code to check the repeat group data
Long ll_null
Integer i
Boolean lb_duplicate
SetNull(ll_null)
If data = '' Then Return 0
If dwo.name = 'group_id' Then
	For i = 1 To This.RowCount()
		If i = row Then Continue
		If This.GetItemNumber(i,'Group_id') = Long(data) Then
			lb_duplicate = True
			Exit
		End If
	Next
	If Not lb_duplicate Then Return 0
	Messagebox('Group Access','Duplicate group, please select again.')
	Post AcceptText()
	Return 2
End If
Return 0
//---------End Added ------------------------------------------------------------------

end event

