$PBExportHeader$w_assoc_prac_select.srw
forward
global type w_assoc_prac_select from window
end type
type cb_1 from commandbutton within w_assoc_prac_select
end type
type cb_3 from commandbutton within w_assoc_prac_select
end type
type cb_populate from commandbutton within w_assoc_prac_select
end type
type dw_1 from datawindow within w_assoc_prac_select
end type
end forward

global type w_assoc_prac_select from window
integer x = 741
integer y = 96
integer width = 2720
integer height = 2376
boolean titlebar = true
string title = "Select Associated Providers"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
cb_1 cb_1
cb_3 cb_3
cb_populate cb_populate
dw_1 dw_1
end type
global w_assoc_prac_select w_assoc_prac_select

type variables
long il_addr_id[]
integer ii_close = 0
end variables

on w_assoc_prac_select.create
this.cb_1=create cb_1
this.cb_3=create cb_3
this.cb_populate=create cb_populate
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.cb_3,&
this.cb_populate,&
this.dw_1}
end on

on w_assoc_prac_select.destroy
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.cb_populate)
destroy(this.dw_1)
end on

event open;long ll_loc

ll_loc = message.doubleparm
	
dw_1.retrieve(ll_loc)
end event

event closequery;if ii_close = 0 then
	messagebox("Close","Click Cancel to close")
	return 1
end if
end event

type cb_1 from commandbutton within w_assoc_prac_select
integer x = 46
integer y = 64
integer width = 311
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select All"
end type

event clicked;integer li_count
integer r
integer li_val
string ls_label
	
li_Count = dw_1.RowCount()
if li_Count < 1 then return
		
if this.text = "Select All" then
	li_val = 1 
	ls_label = "Deselect All"
else
	li_val = 0
	ls_label = "Select All"
end if
		
for r = 1 to li_Count
	dw_1.setitem(r, "selected", li_val)
next
			
this.text = ls_label

end event

type cb_3 from commandbutton within w_assoc_prac_select
integer x = 2363
integer y = 56
integer width = 247
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;gs_pass_ids ids

message.doubleparm = 0
ids.l_ids[1] = 0
ii_close = 1
CloseWithReturn(Parent, ids)
end event

type cb_populate from commandbutton within w_assoc_prac_select
integer x = 2080
integer y = 56
integer width = 270
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Populate"
boolean default = true
end type

event clicked;Integer li_Rc
Integer i


dw_1.AcceptText()

i = dw_1.SetFilter( "selected = 1" ) 
dw_1.Filter()

li_rc = dw_1.RowCount( )

IF li_rc = 0 THEN
	MessageBox( "Nothing Selected", "You must select at least one address to populate." )
	dw_1.SetFilter( "" ) 
	dw_1.Filter()
	Return
END IF

gs_pass_ids ids

FOR i = 1 TO li_rc
	ids.l_ids[ i ]  = dw_1.GetItemNumber( i, "rec_id" )
END FOR

message.doubleparm = 1
ii_close = 1
CloseWithReturn( Parent, ids )


end event

type dw_1 from datawindow within w_assoc_prac_select
integer x = 46
integer y = 176
integer width = 2583
integer height = 2064
integer taborder = 60
string dataobject = "d_group_practitioners_select"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;Integer li_row

li_row = this.getclickedrow()

dw_1.setrow(li_row)
dw_1.selectrow(0,false)
dw_1.selectrow(li_row,true)
//
//il_addr_id = dw_1.getitemnumber(li_row,"rec_id")



end event

event doubleclicked;cb_populate.TriggerEvent( Clicked! )

end event

event constructor;this.settransobject(sqlca)

DataWindowChild dwchild


This.GetChild( "state", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("state")
dwchild.InsertRow( 1 )

This.GetChild( "mailing_address", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("address type")
dwchild.InsertRow( 1 )

This.GetChild( "county", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("county")
dwchild.InsertRow( 1 )

This.GetChild( "country", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("country")
dwchild.InsertRow( 1 )



end event

event itemchanged;//added maha 083004 for checking add/update default does not work
//
//long i
//long ic
//integer cnt
//
//this.accepttext()
//
//for i = 1 to ic
//	if this.getitemnumber(i,"selected") = 0 then //this means it will be checked
//		cnt++
//	end if
//	if cnt > 1 then //if more that one selected default to add
//		gi_temp_switch = 0
//		rb_add.checked = true
//		rb_up.checked = false
//		rb_up.enabled = false
//		exit
//	else
//		rb_up.enabled = true
//	end if
//next

end event

