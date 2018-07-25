$PBExportHeader$w_app_template_setup.srw
forward
global type w_app_template_setup from w_master
end type
type cb_5 from commandbutton within w_app_template_setup
end type
type sle_filter from singlelineedit within w_app_template_setup
end type
type cb_filter from commandbutton within w_app_template_setup
end type
type cb_del_loc from commandbutton within w_app_template_setup
end type
type cb_add_loc from commandbutton within w_app_template_setup
end type
type dw_loc from datawindow within w_app_template_setup
end type
type dw_browse from u_dw within w_app_template_setup
end type
type cb_add from commandbutton within w_app_template_setup
end type
type cb_delete from commandbutton within w_app_template_setup
end type
type cb_save from commandbutton within w_app_template_setup
end type
type cb_copy from commandbutton within w_app_template_setup
end type
type cb_close from commandbutton within w_app_template_setup
end type
type cb_1 from commandbutton within w_app_template_setup
end type
type cb_2 from commandbutton within w_app_template_setup
end type
type dw_items from u_dw within w_app_template_setup
end type
type dw_detail from u_dw within w_app_template_setup
end type
end forward

global type w_app_template_setup from w_master
integer width = 3785
integer height = 2520
string title = "Application Templates Setup"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
long backcolor = 33551856
cb_5 cb_5
sle_filter sle_filter
cb_filter cb_filter
cb_del_loc cb_del_loc
cb_add_loc cb_add_loc
dw_loc dw_loc
dw_browse dw_browse
cb_add cb_add
cb_delete cb_delete
cb_save cb_save
cb_copy cb_copy
cb_close cb_close
cb_1 cb_1
cb_2 cb_2
dw_items dw_items
dw_detail dw_detail
end type
global w_app_template_setup w_app_template_setup

type variables
long il_temp_id
boolean ib_ret_browse
end variables

forward prototypes
public function integer of_set_temp_id ()
end prototypes

public function integer of_set_temp_id ();if isnull(dw_detail.getitemnumber(1, "temp_id")) then
	select max(temp_id) into :il_temp_id from app_templates;
	if isnull(il_temp_id) then il_temp_id = 0
	il_temp_id++
	dw_detail.setitem(1, "temp_id", il_temp_id)
end if

return 1
end function

event open;call super::open;//Start Code Change ----03.13.2013 #V12 maha - screen created

dw_browse.retrieve()

//Start Code Change ----01.06.2015 #V14.2 maha
choose case gi_intelliapp_type
	case 3,0
		cb_add_loc.visible = false
		cb_del_loc.visible = false
		dw_loc.visible = false
		dw_detail.y = 1440
		dw_browse.height = 1300
end choose
//Start Code Change ----01.06.2015		
		
end event

on w_app_template_setup.create
int iCurrent
call super::create
this.cb_5=create cb_5
this.sle_filter=create sle_filter
this.cb_filter=create cb_filter
this.cb_del_loc=create cb_del_loc
this.cb_add_loc=create cb_add_loc
this.dw_loc=create dw_loc
this.dw_browse=create dw_browse
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_copy=create cb_copy
this.cb_close=create cb_close
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_items=create dw_items
this.dw_detail=create dw_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_5
this.Control[iCurrent+2]=this.sle_filter
this.Control[iCurrent+3]=this.cb_filter
this.Control[iCurrent+4]=this.cb_del_loc
this.Control[iCurrent+5]=this.cb_add_loc
this.Control[iCurrent+6]=this.dw_loc
this.Control[iCurrent+7]=this.dw_browse
this.Control[iCurrent+8]=this.cb_add
this.Control[iCurrent+9]=this.cb_delete
this.Control[iCurrent+10]=this.cb_save
this.Control[iCurrent+11]=this.cb_copy
this.Control[iCurrent+12]=this.cb_close
this.Control[iCurrent+13]=this.cb_1
this.Control[iCurrent+14]=this.cb_2
this.Control[iCurrent+15]=this.dw_items
this.Control[iCurrent+16]=this.dw_detail
end on

on w_app_template_setup.destroy
call super::destroy
destroy(this.cb_5)
destroy(this.sle_filter)
destroy(this.cb_filter)
destroy(this.cb_del_loc)
destroy(this.cb_add_loc)
destroy(this.dw_loc)
destroy(this.dw_browse)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_copy)
destroy(this.cb_close)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_items)
destroy(this.dw_detail)
end on

type cb_5 from commandbutton within w_app_template_setup
integer x = 2729
integer y = 28
integer width = 178
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear"
end type

event clicked;dw_browse.setfilter("")
dw_browse.filter()
end event

type sle_filter from singlelineedit within w_app_template_setup
integer x = 1577
integer y = 28
integer width = 864
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_filter from commandbutton within w_app_template_setup
integer x = 2455
integer y = 28
integer width = 274
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;//Start Code Change ----04.23.2014 #V14.2 maha - added
string s

s = sle_filter.text
s = upper(s)

if len(s) = 0 then
	dw_browse.setfilter("")
else
	dw_browse.setfilter("posA(  upper(temp_name) , '" + s + "', 1 ) > 0")
end if

dw_browse.filter()

end event

type cb_del_loc from commandbutton within w_app_template_setup
integer x = 9
integer y = 1420
integer width = 421
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete Location"
end type

event clicked;integer li_ans

if dw_loc.rowcount() < 1 then return

li_ans = messagebox("Delete Item","Are you sure you wish to delete the Location?", question!, yesno!, 2)

if li_ans = 1 then
	dw_loc.deleterow(0)
	dw_loc.update()
end if
end event

type cb_add_loc from commandbutton within w_app_template_setup
integer x = 9
integer y = 1324
integer width = 421
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Locations"
end type

event clicked;//Start Code Change ----04.28.2014 #V14.2 maha
integer nr
integer r
integer rc
integer li_find
long li_item
long ll_loc
gs_pass_ids ids

of_set_temp_id()  //Start Code Change ----05.19.2014 #V14.2 maha

openwithparm(w_practice_to_addr_find_new,"TEMPLATE")

ids = message.powerobjectparm

rc = upperbound(ids.l_ids[ ])

if rc < 1 then return  //test for cancel
debugbreak()


//if il_temp_id = -1 then
//	dw_detail.update()
//	select max(temp_id) into :il_temp_id from app_templates;
//end if

select max(item_id) into :li_item from app_template_loc;
if isnull(li_item) then li_item = 0

FOR r = 1 TO rc
	ll_loc = ids.l_ids[ r ]
	li_find = dw_loc.find( "loc_id = " + string(ll_loc),1, 10000) //trap for existing
	if li_find = 0 then
		nr = dw_loc.insertrow(0)
		li_item++
		dw_loc.setitem( nr, "temp_id", il_temp_id)
		dw_loc.setitem( nr, "item_id", li_item)
		dw_loc.setitem( nr, "loc_id", ll_loc )
	end if
END FOR

dw_loc.update()
dw_loc.retrieve(il_temp_id)

end event

type dw_loc from datawindow within w_app_template_setup
integer x = 439
integer y = 1320
integer width = 3328
integer height = 328
integer taborder = 40
string title = "none"
string dataobject = "d_app_template_locations"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

type dw_browse from u_dw within w_app_template_setup
integer y = 132
integer width = 3767
integer height = 976
integer taborder = 30
string dataobject = "d_app_template_browse"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;long r

r = this.getclickedrow( )
this.setrow(r)

end event

event rowfocuschanged;call super::rowfocuschanged;if this.getrow() > 0 then //Start Code Change ----03.13.2014 #V14.2 maha //added if statements by long appeon 12.05.2013 system error BugL112901 
	il_temp_id = this.getitemnumber( this.getrow() , "temp_id" )
	dw_detail.retrieve(il_temp_id)
	dw_items.retrieve(il_temp_id)
	dw_loc.retrieve(il_temp_id)

	this.selectrow(0, false)
	this.selectrow(currentrow, true)
else
	dw_detail.reset()
	dw_items.reset( )
	dw_loc.reset( )
end if	
end event

type cb_add from commandbutton within w_app_template_setup
integer x = 384
integer y = 28
integer width = 370
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Template"
end type

event clicked;//Start Code Change ----05.019.2014 #V14.2 maha - rewritten
dw_detail.reset()
dw_loc.reset()  
dw_items.reset()
dw_detail.insertrow(1)
il_temp_id = -1 

dw_detail.setfocus()
dw_detail.setrow(1)

end event

type cb_delete from commandbutton within w_app_template_setup
integer x = 1134
integer y = 28
integer width = 416
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete Template"
end type

event clicked;integer li_ans
integer r

li_ans = messagebox("Delete Template","Are you sure you wish to delete the current Template?", question!, yesno!, 2)

if li_ans = 1 then
	dw_detail.deleterow(1)
	
	for r =  dw_items.rowcount( ) to 1 step -1
		dw_items.deleterow(r)
	next
	//Start Code Change ----05.01.2014 #V14.2 maha
	for r = dw_loc.rowcount( ) to 1 step -1
		dw_loc.deleterow(r)
	next
	
	dw_detail.update()
	dw_items.update()
	dw_loc.update()
	//End Code Change ----05.01.2014
	dw_browse.retrieve()
	//---------Begin Added by (Appeon)Harry 10.22.2014 for BugH100902--------
	r = dw_browse.getrow( )
	if r > 0 then dw_browse.event rowfocuschanged(r)
	//---------End Added ------------------------------------------------------
end if
end event

type cb_save from commandbutton within w_app_template_setup
integer x = 41
integer y = 28
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;long f
long ll_temp

//Start Code Change ----05.21.2014 #V14.2 maha - corrected retrieve issues
ll_temp = il_temp_id
dw_detail.of_update(true,true)

////Start Code Change ----10.01.2014 #V14.2 maha
//for f = dw_items.rowcount() to 1 step -1
//	if isnull(dw_items.getitemnumber(f,"app_id")) then
//		dw_items.deleterow(f)
//	end if
//next
////End Code Change ----10.01.2014 
	
dw_items.of_update(true,true)

if ib_ret_browse = true then
	dw_browse.retrieve()
	f = dw_browse.find("temp_id = " + string(ll_temp) , 1, dw_browse.rowcount())
	if f > 0 then
		dw_browse.scrolltorow( f )
		dw_browse.setrow( f )
		dw_browse.selectrow( f, true)
		
	end if
	 ib_ret_browse = false
end if
//Start Code Change ----05.21.2014
end event

type cb_copy from commandbutton within w_app_template_setup
integer x = 754
integer y = 28
integer width = 384
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Copy Template"
end type

event clicked;long ic
long i
long ll_locid //maha 05.01.2014
integer cr
long ll_temp
long ll_null
string ls_name


if dw_detail.getrow() < 1 then return
//---------Begin Added by (Appeon)Harry 11.19.2014 for BugH102401--------
if dw_items.modifiedcount( ) > 0 or dw_items.deletedcount( ) > 0 or dw_loc.modifiedcount( ) > 0 or dw_loc.modifiedcount( ) > 0 then
	if messagebox("Save","The data has been modified, save it first?",Question!,YesNo!) = 1 then
		cb_save.triggerevent(clicked!)
	else
		return
	end if
end if
//---------End Added ------------------------------------------------------
setnull(ll_null)

debugbreak()
//copy to first row
ls_name = dw_detail.getitemstring( 1, "temp_name")
dw_detail.rowscopy( 1, 1,Primary!, dw_detail, 1, Primary!)

dw_detail.setitem( 1 , "temp_name",  "Copy of " + ls_name )
select max(temp_id) into :ll_temp from app_templates;
ll_temp++
dw_detail.setitem(1, "temp_id", ll_temp)

cr = dw_items.rowcount()
if cr > 0 then
	dw_items.rowscopy( 1, cr, Primary!, dw_items, 1000, Primary!)
	select Max(item_id) into :ll_locid from app_template_items;
	
	for i = cr + 1 to dw_items.rowcount()
		ll_locid++
		dw_items.setitem(i , "temp_id" , ll_temp)
		//dw_items.setitem(i , "item_id" , ll_null)
		dw_items.setitem(i , "item_id" , ll_locid)
	next
end if

//Start Code Change ----05.01.2014 #V14.2 maha - copy locations
if dw_loc.rowcount() > 0 then
	select Max(item_id) into :ll_locid from app_template_loc;
	cr = dw_loc.rowcount()
	dw_loc.rowscopy( 1, cr, Primary!, dw_loc, 1000, Primary!)

	for i = cr + 1 to dw_loc.rowcount()
		ll_locid++
		dw_loc.setitem(i , "temp_id" , ll_temp)
		dw_loc.setitem(i , "item_id" , ll_locid)
	next
end if
	
dw_detail.update()
cr = dw_items.update()
if cr < 0 then MessageBox("Items failed to update", cr)
dw_loc.update()
dw_browse.retrieve()

//Start Code Change ----05.01.2014 #V14.2 maha
//cr = dw_browse.rowcount()
cr = dw_browse.find("temp_id =" + string(ll_temp), 1,10000)
debugbreak()
if cr = 1 then
	dw_browse.setrow(1)
	dw_browse.triggerevent(rowfocuschanged!)
elseif cr > 0 then
	dw_browse.scrolltorow(cr)
	dw_browse.setrow(cr)
//	dw_browse.selectrow(0, false)
//	dw_browse.selectrow(cr, true)
end if

end event

type cb_close from commandbutton within w_app_template_setup
integer x = 3045
integer y = 28
integer width = 343
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

type cb_1 from commandbutton within w_app_template_setup
integer x = 9
integer y = 1672
integer width = 421
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Application"
end type

event clicked;integer nr


of_set_temp_id()  //Start Code Change ----05.19.2014 #V14.2 maha
//if il_temp_id = -1 then
//	dw_detail.update()
//	select max(temp_id) into :il_temp_id from app_templates;
//end if


nr = dw_items.insertrow(0)
dw_items.setitem( nr, "temp_id", il_temp_id)

dw_items.scrolltorow(nr)
dw_items.setrow(nr)
end event

type cb_2 from commandbutton within w_app_template_setup
integer x = 9
integer y = 1772
integer width = 421
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete Appl"
end type

event clicked;integer li_ans

if dw_items.rowcount() < 1 then return

li_ans = messagebox("Delete Item","Are you sure you wish to delete the item?", question!, yesno!, 2)

if li_ans = 1 then
	dw_items.deleterow(0)
	dw_items.update()
end if
end event

type dw_items from u_dw within w_app_template_setup
integer x = 439
integer y = 1664
integer width = 3323
integer height = 760
integer taborder = 20
string dataobject = "d_app_temp_items"
borderstyle borderstyle = stylebox!
end type

event pfc_preupdate;call super::pfc_preupdate;//Start Code Change ----04.11.2013 #V12 maha - to correct save issue rlated to removal of identity field
integer r
long ll_item

//Start Code Change ----10.23.2014 #V14.2 maha
for r = dw_items.rowcount() to 1 step -1
	if isnull(dw_items.getitemnumber(r,"app_id")) then
		dw_items.deleterow(r)
	end if
next
//End Code Change ----10.23.2014 

debugbreak()
select max(item_id) into :ll_item from app_template_items;
if isnull(ll_item) then ll_item = 0

for r = 1 to this.rowcount()
	if isnull(this.getitemnumber(r, "item_id")) then
		ll_item++
		this.setitem(r, "item_id", ll_item)
	end if
next


return 1
end event

event itemchanged;call super::itemchanged; //Start Code Change ----09.02.2015 #V15 maha
if dwo.name =  "app_id" then
	datawindowchild dwchild
	long z
	long r
	this.getchild( "app_id", dwchild)
	r = dwchild.find( "app_hdr_app_id = " + data, 1, dwchild.rowcount())
	if r > 0 then
		if dwchild.getitemnumber(r,"app_hdr_active_status") = 0 then
			messagebox("Inactive Application","The chosen application is Inactive and cannot be selected.")
			z = this.getitemnumber(row,"app_id",primary!,true )
			this.setitem(row, "app_id", z)
			return 2
		end if
	end if
end if
 //End Code Change ----09.02.2015
end event

type dw_detail from u_dw within w_app_template_setup
integer y = 1116
integer width = 3767
integer height = 192
integer taborder = 30
string dataobject = "d_app_temp_detail"
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
end type

event pfc_preupdate;call super::pfc_preupdate;//set template id on new record
//debugbreak()
this.accepttext()
if this.getrow( ) < 1 then return 0 //(Appeon)Harry 10.22.2014 - BugH100902
if isnull(this.getitemnumber(1, "temp_id")) then
	select max(temp_id) into :il_temp_id from app_templates;
	if isnull(il_temp_id) then il_temp_id = 0
	il_temp_id++
	this.setitem(1, "temp_id", il_temp_id)
end if

if this.getitemstatus( this.getrow(), 0, Primary!) = Newmodified! then ib_ret_browse = true
If this.getitemstatus( this.getrow(), 0, Primary!) = Datamodified! then ib_ret_browse = true

return 1
end event

