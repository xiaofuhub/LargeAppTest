$PBExportHeader$w_overwrite_msg.srw
forward
global type w_overwrite_msg from window
end type
type cb_addon from commandbutton within w_overwrite_msg
end type
type dw_1 from datawindow within w_overwrite_msg
end type
type cb_1 from commandbutton within w_overwrite_msg
end type
type cb_cancel from commandbutton within w_overwrite_msg
end type
type st_1 from statictext within w_overwrite_msg
end type
type cb_append from commandbutton within w_overwrite_msg
end type
type cb_overwrite from commandbutton within w_overwrite_msg
end type
end forward

global type w_overwrite_msg from window
integer x = 663
integer y = 540
integer width = 2267
integer height = 1972
boolean titlebar = true
string title = "Scan Image"
windowtype windowtype = response!
long backcolor = 33551856
cb_addon cb_addon
dw_1 dw_1
cb_1 cb_1
cb_cancel cb_cancel
st_1 st_1
cb_append cb_append
cb_overwrite cb_overwrite
end type
global w_overwrite_msg w_overwrite_msg

type variables
long il_facility[]
end variables

on w_overwrite_msg.create
this.cb_addon=create cb_addon
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_cancel=create cb_cancel
this.st_1=create st_1
this.cb_append=create cb_append
this.cb_overwrite=create cb_overwrite
this.Control[]={this.cb_addon,&
this.dw_1,&
this.cb_1,&
this.cb_cancel,&
this.st_1,&
this.cb_append,&
this.cb_overwrite}
end on

on w_overwrite_msg.destroy
destroy(this.cb_addon)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_cancel)
destroy(this.st_1)
destroy(this.cb_append)
destroy(this.cb_overwrite)
end on

event open;//Start Code Change ----03.28.2011 #V11 maha  - passing facility variables
gs_variable_array ls_array
integer r
string ls_facility
datawindowchild dwchild


ls_array = message.powerobjectparm

il_facility[] = ls_array.as_number

 //Start Code Change ----06.05.2017 #V154 maha - oveerride security
 if w_mdi.of_security_access(7859)=  0 then
	cb_overwrite.enabled = false
end if
 //End Code Change ----06.05.2017 

dw_1.settransobject(sqlca)
r = dw_1.retrieve(il_facility[])

dw_1.getchild( "facility_id", dwchild)
dwchild.insertrow(1)
dwchild.setitem( 1,"facility_id",0)
dwchild.setitem( 1,"facility_name", "All")

if r > 1 then
	dw_1.setrow(1)
end if

end event

type cb_addon from commandbutton within w_overwrite_msg
integer x = 393
integer y = 1392
integer width = 1467
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Append to &existing Image (Get From File)"
boolean cancel = true
end type

event clicked;if dw_1.getrow( ) < 1 then return //added by long.zhang 07.11.2012 Invalid DataWindow row/column
CloseWithReturn( Parent, "P"  + string(dw_1.getitemnumber(dw_1.getrow(),"image_pk")) )	//added by long.zhang 10.13.2011	append Existing image
end event

type dw_1 from datawindow within w_overwrite_msg
integer x = 219
integer y = 340
integer width = 1824
integer height = 580
integer taborder = 10
string title = "none"
string dataobject = "d_image_found_records"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;this.selectrow(0,false)
this.selectrow(currentrow,true)
end event

event clicked;integer r
r = this.getclickedrow()

this.setrow(r)
end event

type cb_1 from commandbutton within w_overwrite_msg
integer x = 393
integer y = 1128
integer width = 1467
integer height = 116
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Image connected to another Group/Facility"
end type

event clicked;CloseWithReturn( Parent, "F" )
end event

type cb_cancel from commandbutton within w_overwrite_msg
integer x = 398
integer y = 1520
integer width = 1467
integer height = 116
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn( Parent, "C" )
end event

type st_1 from statictext within w_overwrite_msg
integer x = 146
integer y = 72
integer width = 2002
integer height = 172
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "One or more previously added images exist for this record for the following Groups/Facilities.  "
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_append from commandbutton within w_overwrite_msg
integer x = 393
integer y = 996
integer width = 1467
integer height = 116
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add and make current image a History image."
end type

event clicked;if dw_1.getrow( ) < 1 then return //added by long.zhang 07.11.2012 Invalid DataWindow row/column
CloseWithReturn( Parent, "A"  + string(dw_1.getitemnumber(dw_1.getrow(),"image_pk")) )
end event

type cb_overwrite from commandbutton within w_overwrite_msg
integer x = 393
integer y = 1260
integer width = 1467
integer height = 116
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Overwrite existing Image, deleting the Original"
end type

event clicked;integer a
if dw_1.getrow() < 1 then return //Add Michael 02.06.2011 Invalid DataWindow row/column specified
a = messagebox("Overwrite Image","Are you sure you wish to DELETE the image and replace it with another?",question!,yesno!,2)

if a = 2 then return

CloseWithReturn( Parent, "O" + string(dw_1.getitemnumber(dw_1.getrow(),"image_pk")) )
end event

