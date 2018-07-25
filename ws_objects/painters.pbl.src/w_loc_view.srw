$PBExportHeader$w_loc_view.srw
forward
global type w_loc_view from window
end type
type cb_2 from commandbutton within w_loc_view
end type
type cb_1 from commandbutton within w_loc_view
end type
type dw_add from u_dw within w_loc_view
end type
end forward

global type w_loc_view from window
integer width = 3913
integer height = 2168
boolean titlebar = true
string title = "View Location"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_add dw_add
end type
global w_loc_view w_loc_view

type variables
long il_parent
end variables

event open;DataWindowChild dwchild
long ll_loc  //maha 08.17.2016
string ls_name  //maha 08.17.2016

//Start Code Change ----08.17.2016 #V152 maha - modified to variable
ll_loc = message.doubleparm
//-----Begin Added by alfee 11.11.2010 ------------
//V10.5 SK Group Practice - Add new location
//if message.doubleparm > 0  then 

//------End Added -------------------------------------

dw_add.retrieve(ll_loc)


end event

on w_loc_view.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_add=create dw_add
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_add}
end on

on w_loc_view.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_add)
end on

type cb_2 from commandbutton within w_loc_view
integer x = 3525
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

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_loc_view
integer x = 3163
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
dw_add.update()


Close(Parent)

end event

type dw_add from u_dw within w_loc_view
integer x = 14
integer y = 140
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

