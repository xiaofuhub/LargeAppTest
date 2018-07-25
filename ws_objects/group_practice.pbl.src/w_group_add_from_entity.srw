$PBExportHeader$w_group_add_from_entity.srw
forward
global type w_group_add_from_entity from window
end type
type dw_ent from datawindow within w_group_add_from_entity
end type
type cb_2 from commandbutton within w_group_add_from_entity
end type
type cb_1 from commandbutton within w_group_add_from_entity
end type
type dw_add from u_dw within w_group_add_from_entity
end type
end forward

global type w_group_add_from_entity from window
integer width = 3913
integer height = 2184
boolean titlebar = true
string title = "Add New Location"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_ent dw_ent
cb_2 cb_2
cb_1 cb_1
dw_add dw_add
end type
global w_group_add_from_entity w_group_add_from_entity

type variables
long il_parent
end variables

event open;//Start Code Change ----11.01.2016 #V153 maha - added copied from w_group_add;  called from entity painter

long ll_loc
boolean lb_add = false
string ls_name

ll_loc = message.doubleparm

if ll_loc > 0 then
	il_parent = ll_loc
	dw_add.settransobject(sqlca)
	dw_add.retrieve(ll_loc)
end if







end event

on w_group_add_from_entity.create
this.dw_ent=create dw_ent
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_add=create dw_add
this.Control[]={this.dw_ent,&
this.cb_2,&
this.cb_1,&
this.dw_add}
end on

on w_group_add_from_entity.destroy
destroy(this.dw_ent)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_add)
end on

type dw_ent from datawindow within w_group_add_from_entity
boolean visible = false
integer x = 1765
integer y = 40
integer width = 622
integer height = 96
integer taborder = 30
string title = "none"
string dataobject = "d_entity_lookup_detail"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_group_add_from_entity
integer x = 3035
integer y = 40
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent, "Cancel")
end event

type cb_1 from commandbutton within w_group_add_from_entity
integer x = 2674
integer y = 40
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;long ll_rec
long ll_id
integer i
string ls_field
string ls_val
string ls_type

dw_add.accepttext()
//debugbreak()
for i = 1 to 5
	choose case i
		case 1
			ls_field = "street"
			ls_type = "C"
		case 2
			ls_field = "street_2"
			ls_type = "C"
		case 3
			ls_field = "city"
			ls_type = "C"
		case 4
			ls_field = "state"
			ls_type = "N"
		//case 4
		case 5	//long.zhang 12.14.2011
			ls_field = "zip"
			ls_type = "C"
	end choose
	
	if ls_type = "C" then
		ls_val = dw_add.getitemstring(1,ls_field)
	else
		ls_val = string(dw_add.getitemnumber(1,ls_field))
	end if
	
	If isnull(ls_val) then
		messagebox("Group Add","Data is required in the " + ls_field + " field."  )
		return
	end if
next
debugbreak()
ll_id = dw_add.getitemnumber(1, "rec_id")

if isnull(ll_id) then
	select max(rec_id) into :ll_id from group_practice;
	if isnull(ll_id ) then ll_id = 0  //alfee 11.11.2010
	ll_id++
	dw_add.setitem(1,"rec_id",ll_id)
end if

dw_add.update()

CloseWithReturn(Parent, ll_id)

end event

type dw_add from u_dw within w_group_add_from_entity
integer x = 14
integer y = 164
integer width = 3872
integer height = 1936
integer taborder = 10
string dataobject = "d_group_data_entry"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.settransobject(sqlca)
//This.of_setdropdowncalendar( true )	//added by long.zhang 07.02.2012 v12.2 group location mini-painter
This.post of_setdropdowncalendar( true )	//long.zhang 11.06.2012 Bug 3315
DataWindowChild dwchild

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-09
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

This.GetChild( "state", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("state")
//dwchild.InsertRow( 1 )

This.GetChild( "county", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("county")
//dwchild.InsertRow( 1 )

This.GetChild( "country", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("country")
//dwchild.InsertRow( 1 )

This.GetChild( "public_transportation", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("yes/no")
//dwchild.InsertRow( 1 )

This.GetChild( "handicapped_access", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("yes/no")
//dwchild.InsertRow( 1 )

This.GetChild( "mailing_address", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("address type")
//dwchild.InsertRow( 1 )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-10
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue( )

This.GetChild( "state", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "county", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "country", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "public_transportation", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "handicapped_access", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "mailing_address", dwchild )
dwchild.InsertRow( 1 )

this.insertrow(1)
f_modify_group_detail_property(this)//added by long.zhang 07.06.2012 v12.2 group location mini-painter
end event

event buttonclicked;call super::buttonclicked;//Start Code Change ----10.30.2009 #V10 maha - copied from group practice screen

String	ls_Phone,ls_fax,ls_RetParm

if row > 0 and row <= This.RowCount() then
	if dwo.name = 'b_phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
		end if
		This.SetColumn('phone')
	elseif dwo.name = 'b_fax' then
		ls_fax = This.GetItemString(row,'fax')
		if IsNull(ls_fax) then ls_fax = ""
		OpenWithParm(w_phonedetail,"Fax:" + ls_fax)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'fax',ls_RetParm)
		end if
		This.SetColumn('fax')
	end if
end if

//End Code Change---10.30.2009

end event

event rbuttondown;call super::rbuttondown;//added by long.zhang 07.05.2012 v12.2 group location mini-painter

integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)
col = this.getclickedcolumn()
colname = dwo.name

if this.Describe( colname + ".ColType") = "datetime" THEN
	ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )
	if ret = 1 then
		this.setitem(row,col,dtn)
	end if
END IF
end event

event itemchanged;call super::itemchanged; //Start Code Change ----08.16.2016 #V15 maha - zip autofill
if dwo.name = "zip" then
	string val
	this.accepttext( )
	val = this.getitemstring(this.getrow(),"zip")
	of_zip_fill(val, "LOC", this)
end if
end event

