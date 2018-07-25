$PBExportHeader$w_data_view_required_data_setup.srw
forward
global type w_data_view_required_data_setup from w_popup
end type
type cb_2 from commandbutton within w_data_view_required_data_setup
end type
type cb_1 from commandbutton within w_data_view_required_data_setup
end type
type dw_types from u_dw within w_data_view_required_data_setup
end type
type dw_req from u_dw within w_data_view_required_data_setup
end type
type dw_screen from u_dw within w_data_view_required_data_setup
end type
end forward

global type w_data_view_required_data_setup from w_popup
integer x = 214
integer y = 221
integer width = 2752
integer height = 1988
string title = "Required Data "
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
long backcolor = 33551856
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_types dw_types
dw_req dw_req
dw_screen dw_screen
end type
global w_data_view_required_data_setup w_data_view_required_data_setup

type variables
long il_dv
long il_screen
end variables

forward prototypes
public function integer of_post_set_data (integer al_row, string as_field, string as_value, string as_type)
public function integer of_set_lookup_table ()
end prototypes

public function integer of_post_set_data (integer al_row, string as_field, string as_value, string as_type);long ll_val
string ls_val

if isnull(as_value) then 
	setnull(ls_val)
	ll_val = 0
end if

if as_type = "N" then
	ll_val = long(as_value)
	dw_req.setitem(al_row,as_field,ll_val)
else
	dw_req.setitem(al_row,as_field,ls_val)
end if

return 1
end function

public function integer of_set_lookup_table ();datawindowchild dwchild
integer li_table
string ls_field
string ls_lookup
string ls_cond


debugbreak()
li_table = dw_screen.getitemnumber(dw_screen.getrow(), "table_id")
ls_field = dw_req.getitemstring(1,"req_type_field_name")

ls_cond = "table_id = " + string(li_table) +" and field_name =  '" + ls_field + "'" 
//clipboard(ls_cond) //Comment by Appeon long.zhang 06.30.2016 (BugL063002)
ls_lookup = gnv_data.of_getitem( "sys_fields", "lookup_code", ls_cond )

dw_types.getchild( "lookup_code",  dwchild)
dwchild.settransobject(sqlca)

If IsNull(ls_lookup ) Then //Added by Appeon long.zhang 07.19.2016 (BugL070702)
	dwchild.Reset()
Else
	dwchild.retrieve(ls_lookup)
End If

return 1
end function

on w_data_view_required_data_setup.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_types=create dw_types
this.dw_req=create dw_req
this.dw_screen=create dw_screen
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_types
this.Control[iCurrent+4]=this.dw_req
this.Control[iCurrent+5]=this.dw_screen
end on

on w_data_view_required_data_setup.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_types)
destroy(this.dw_req)
destroy(this.dw_screen)
end on

event open;call super::open;string s  //maha 05.25.2016

il_dv = message.doubleparm

//PFC Linkage //Added by Appeon long.zhang 07.19.2016 (BugL070702)
dw_screen.of_setlinkage( True )
dw_screen.inv_linkage.of_setstyle(dw_screen.inv_linkage.RETRIEVE)
dw_screen.inv_linkage.of_setupdateonrowchange(True)

dw_req.of_setlinkage( True )
dw_req.inv_linkage.of_setmaster( dw_screen)
dw_req.inv_linkage.of_setstyle(dw_req.inv_linkage.RETRIEVE)
dw_req.inv_linkage.of_register( 'data_view_id', 'data_view_id')
dw_req.inv_linkage.of_register( 'screen_id', 'screen_id')

dw_types.of_setlinkage( True )
dw_types.inv_linkage.of_setmaster( dw_req)
dw_types.inv_linkage.of_setstyle(dw_types.inv_linkage.RETRIEVE)
dw_types.inv_linkage.of_register( 'data_view_id', 'data_view_id')
dw_types.inv_linkage.of_register( 'screen_id', 'screen_id')
dw_types.of_setreqcolumn( True)

//dw_screen.retrieve(il_dv)
dw_screen.of_retrieve() ////Added by Appeon long.zhang 07.19.2016 (BugL070702)


//Start Code Change ----05.25.2016 #V152 maha
select data_view_name into :s from data_view where data_view_id = :il_dv;
this.title = "Required Data for the view: " + s
//End Code Change ----05.25.2016
end event

type cb_2 from commandbutton within w_data_view_required_data_setup
integer x = 2341
integer y = 12
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_data_view_required_data_setup
integer x = 1989
integer y = 12
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//dw_req.update()
//dw_types.update()

Parent.Event pfc_save() //Added by Appeon long.zhang 07.19.2016 (BugL070701)
end event

type dw_types from u_dw within w_data_view_required_data_setup
integer x = 827
integer y = 992
integer width = 1856
integer height = 852
integer taborder = 20
string dataobject = "d_data_view_screen_req_types_setup"
end type

event buttonclicked;call super::buttonclicked;integer nr


if dwo.name = "b_add" then
	nr = this.insertrow(0)
	this.setitem(nr, "view_id", il_dv )
	this.setitem(nr, "screen_id", il_screen )
end if

if dwo.name = "b_delete" then
	this.deleterow(0)
end if
end event

event retrieveend;call super::retrieveend;//====================================================================
//$<Event>: retrieveend
//$<Arguments>:
// 	value    long    rowcount
//$<Return>:  long
//$<Description>: Add a row by default
//$<Author>: (Appeon) long.zhang 07.19.2016 (BugL070702 )
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

if rowcount = 0 then
	dw_types.insertrow(0)
end if

end event

event retrievestart;call super::retrievestart;of_set_lookup_table() //Added by Appeon long.zhang 07.19.2016 (BugL070702)
end event

event pfc_preupdate;call super::pfc_preupdate;//====================================================================
//$<Event>: pfc_preupdate
//$<Arguments>:
//$<Return>:  public
//$<Description>: Set PK
//$<Author>: (Appeon) long.zhang 07.19.2016 (BugL070701)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Int i
Long ll_cnt

ll_cnt = dw_types.rowcount()
For i = 1 to ll_cnt
	
	If IsNull(dw_types.GetitemNumber(1, "view_id")) And (Not IsNull(dw_types.GetitemNumber(1, "lookup_code"))) Then
		dw_types.setitem(1, "view_id", il_dv )
		dw_types.setitem(1, "screen_id", il_screen )
	End If
Next

Return SUCCESS
end event

event pfc_validation;call super::pfc_validation;//====================================================================
//$<Event>: pfc_validation
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Not allowed to add the same lookup_codes
//$<Author>: (Appeon) long.zhang 07.19.2016 (BugL063003)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If AncestorReturnValue = FAILURE Then Return AncestorReturnValue

Long i, ll_cnt
String ls_find
Long ll_lookup_code


ll_cnt = dw_types.RowCount()
For i = 1 to ll_cnt
	ll_lookup_code = dw_types.GetItemNumber(i, 'lookup_code')
	If Not IsNull(ll_lookup_code) and (i <ll_cnt) Then
		ls_find = 'lookup_code = ' + String(ll_lookup_code)
		If dw_types.Find(ls_find, i + 1, ll_cnt) > 0 Then
			Messagebox('Validation', 'Please select distinct Lookup Types.')
			Return FAILURE
		End If
	End If
Next

end event

type dw_req from u_dw within w_data_view_required_data_setup
integer x = 827
integer y = 112
integer width = 1856
integer height = 872
integer taborder = 20
string dataobject = "d_req_data_screen_setup"
end type

event itemchanged;call super::itemchanged;string ls_null
string ls_field
Int i

this .accepttext()

choose case dwo.name
	case "req_type_field"
		if data = "0" then
			setnull(ls_null)
			post of_post_set_data(row, "req_type_field_name", ls_null, "S")
		else
			post of_post_set_data(row, "rec_req", "1", "N")
		end if
	case "req_type_field_name"
		if data = "" then return
		
		post of_post_set_data(row, "req_type_field", "1", "N")
		
		//Clear dw_types when req_type_field_name changed, Added by Appeon long.zhang 07.19.2016 (BugL070701)
		For i = dw_types.rowcount() to 1 Step -1
			dw_types.DeleteRow(i)
		Next
		dw_types.insertrow(0)

		post of_set_lookup_table()
		
		
	case "req_fields"
		if data = "1" then
			post of_post_set_data(row, "rec_req", "1", "N")
		end if
	case "address_p", "address_m", "address_b", "address_x", "address_h", "specialty_p"
		if data = "1" then
			post of_post_set_data(row, "rec_req", "1", "N")
		end if
end choose
		
end event

event pfc_populatedddw;call super::pfc_populatedddw;//====================================================================
//$<Event>: pfc_populatedddw
//$<Arguments>:
// 	value        string             as_colname
// 	reference    datawindowchild    adwc_obj
//$<Return>:  long
//$<Description>: Populate req_type_field_name
//$<Author>: (Appeon) long.zhang 07.19.2016
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
datawindowchild dwchild
Int i

If as_colname = 'req_type_field_name' Then
	dw_req.getchild( "req_type_field_name",  dwchild )
	dwchild.settransobject(sqlca)
	i = dwchild.retrieve(il_dv,il_screen)
	If i < 0 Then
		Return FAILURE
	End If
End If

Return SUCCESS
end event

event retrieveend;call super::retrieveend;//Added by Appeon long.zhang 07.19.2016 (BugL070702 )
il_screen = this.getitemnumber(1, "screen_id")

This.inv_base.of_populatedddw('req_type_field_name')
end event

type dw_screen from u_dw within w_data_view_required_data_setup
integer x = 9
integer y = 112
integer width = 795
integer height = 1736
integer taborder = 10
string dataobject = "d_data_view_screens_list"
end type

event rowfocuschanged;call super::rowfocuschanged;//Rewrite with PFC linkage service, Comment by Appeon long.zhang 07.19.2016 (BugL070702)
//datawindowchild dwchild
//string ls_field
//string ls_lookup
//integer li_table

//if currentrow < 1 then return
//
//il_screen = this.getitemnumber(currentrow, "screen_id")
//dw_req.retrieve(il_dv, il_screen)
//dw_req.getchild( "req_type_field_name",  dwchild )
//dwchild.settransobject(sqlca)
//dwchild.retrieve(il_dv,il_screen)
//
//ls_field = dw_req.getitemstring(1,"req_type_field_name")
//li_table = dw_req.getitemnumber(1,"table_id")
//
//if dw_types.retrieve(il_dv, il_screen) = 0 then
//	dw_types.insertrow(1)
//	dw_types.setitem(1, "view_id", il_dv )
//	dw_types.setitem(1, "screen_id", il_screen )
//end if
//
//if len(ls_field) > 0 then
//	of_set_lookup_table( )
//end if

end event

event constructor;call super::constructor;this.of_setupdateable( false)
end event

event pfc_retrieve;call super::pfc_retrieve;Return This.Retrieve(il_dv) //Added by Appeon long.zhang 07.19.2016 (BugL070702)
end event

