$PBExportHeader$w_data_view_search_fields_setup.srw
forward
global type w_data_view_search_fields_setup from w_response
end type
type cb_1 from commandbutton within w_data_view_search_fields_setup
end type
type cb_save from commandbutton within w_data_view_search_fields_setup
end type
type st_1 from statictext within w_data_view_search_fields_setup
end type
type dw_select from u_dw within w_data_view_search_fields_setup
end type
type cb_close from commandbutton within w_data_view_search_fields_setup
end type
type dw_fields from u_dw within w_data_view_search_fields_setup
end type
end forward

global type w_data_view_search_fields_setup from w_response
integer x = 214
integer y = 221
integer width = 2002
integer height = 1444
string title = "Search Results Fields"
boolean controlmenu = false
long backcolor = 33551856
cb_1 cb_1
cb_save cb_save
st_1 st_1
dw_select dw_select
cb_close cb_close
dw_fields dw_fields
end type
global w_data_view_search_fields_setup w_data_view_search_fields_setup

type variables
boolean ib_only_one = false
integer il_vid
end variables

forward prototypes
public function integer of_setup_fields ()
end prototypes

public function integer of_setup_fields ();//Start Code Change ----05.11.2016 #V15 maha - called from View select and open event when no field exist
integer ll_cid
integer rc
integer c
integer nr
long ll_id


dw_fields.setredraw( false)
if ib_only_one then //if only default exists use that
	ll_cid = 1
	rc = dw_fields.retrieve(1)
else
//	messagebox("Search Results Fields","This view does not have setup fields. Please select the view from which to copy in the next screen.")
	open(w_select_view_search_fields)
	ll_cid = message.doubleparm
	if ll_cid = 0 then 
		dw_fields.setredraw( True) //Added by Appeon long.zhang 06.30.2016 (BugL063001)
		return -1
	End If
end if
	
select max(dvsf_id) into :ll_id from data_view_search_fields;
rc = dw_fields.retrieve(ll_cid)
for c = 1 to rc
	dw_fields.rowscopy( c, c, primary! , dw_fields , 1000 ,  primary!)
	nr = dw_fields.rowcount()
	ll_id++
	dw_fields.setitem(nr, "data_view_id", il_vid)
	dw_fields.setitem(nr, "dvsf_id", ll_id)
next

dw_fields.update()
dw_fields.retrieve(il_vid)
dw_fields.setredraw( true)

return 1

end function

on w_data_view_search_fields_setup.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_save=create cb_save
this.st_1=create st_1
this.dw_select=create dw_select
this.cb_close=create cb_close
this.dw_fields=create dw_fields
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_select
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.dw_fields
end on

on w_data_view_search_fields_setup.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_save)
destroy(this.st_1)
destroy(this.dw_select)
destroy(this.cb_close)
destroy(this.dw_fields)
end on

event open;call super::open;//Start Code Change ----04.12.2016 #V15 maha - added for 15.2
integer r


select count(distinct data_view_id) into :r from data_view_search_fields;

if r = 1 then ib_only_one = true

il_vid = message.doubleparm

//retrieve the view fields
if il_vid > 0 then
	r = dw_fields.retrieve(il_vid)
	dw_select.setitem(1,"data_view_id", il_vid)
	if r = 0 then 
		post of_setup_fields()
	end if
else
	r = dw_fields.retrieve(1)
end if




end event

type cb_1 from commandbutton within w_data_view_search_fields_setup
integer x = 1326
integer y = 44
integer width = 320
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "About"
end type

event clicked;messagebox("Search Field Setup","This setup will allow you to hide and rename fields that show up in the Provider search screen.  Note: Checkboxes with a gray background cannot be hidden.")
end event

type cb_save from commandbutton within w_data_view_search_fields_setup
integer x = 997
integer y = 44
integer width = 320
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_fields.update()
end event

type st_1 from statictext within w_data_view_search_fields_setup
integer x = 18
integer width = 343
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select View"
boolean focusrectangle = false
end type

type dw_select from u_dw within w_data_view_search_fields_setup
integer x = 5
integer y = 52
integer width = 937
integer height = 84
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_select_views_dddw_list"
boolean vscrollbar = false
boolean border = false
end type

event constructor;This.of_SetTransObject( SQLCA )
This.of_SetUpdateAble( False )
This.InsertRow( 0 )

This.SetItem( 1, "data_view_id", 1 )

This.SetRow( 1 )
This.ScrollToRow( 1 )






end event

event itemchanged;call super::itemchanged;integer r
integer rc
integer c
integer ll_cid
integer ll_vid
integer nr

long ll_id

ll_vid = integer(data)
il_vid = ll_vid
r = dw_fields.retrieve(integer(data))

if r < 1 then
	of_setup_fields()
end if
//if no fields exist for the view copy from another
//if r = 0 then
//	dw_fields.setredraw( false)
//	if ib_only_one then //if only default exists use that
//		ll_cid = 1
//		rc = dw_fields.retrieve(1)
//	else
//		open(w_select_view_search_fields)
//		ll_cid = message.doubleparm
//		if ll_cid = 0 then return
//	end if
//	
//	select max(dvsf_id) into :ll_id from data_view_search_fields;
//	rc = dw_fields.retrieve(ll_cid)
//	for c = 1 to rc
//		dw_fields.rowscopy( c, c, primary! , dw_fields , 1000 ,  primary!)
//		nr = dw_fields.rowcount()
//		ll_id++
//		dw_fields.setitem(nr, "data_view_id", ll_vid)
//		dw_fields.setitem(nr, "dvsf_id", ll_id)
//	next
//
//	dw_fields.update()
//	dw_fields.retrieve(ll_vid)
//		
//	dw_fields.setredraw( true)
//end if
//		
		




end event

type cb_close from commandbutton within w_data_view_search_fields_setup
integer x = 1655
integer y = 44
integer width = 320
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type dw_fields from u_dw within w_data_view_search_fields_setup
integer x = 5
integer y = 164
integer width = 1975
integer height = 1196
integer taborder = 10
string dataobject = "d_data_view_search_fields"
end type

