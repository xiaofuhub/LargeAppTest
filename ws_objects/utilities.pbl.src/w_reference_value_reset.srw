$PBExportHeader$w_reference_value_reset.srw
forward
global type w_reference_value_reset from window
end type
type cb_close from commandbutton within w_reference_value_reset
end type
type cb_run from commandbutton within w_reference_value_reset
end type
type dw_verif from datawindow within w_reference_value_reset
end type
type dw_data from datawindow within w_reference_value_reset
end type
type dw_screen from datawindow within w_reference_value_reset
end type
end forward

global type w_reference_value_reset from window
integer width = 4059
integer height = 2372
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
cb_run cb_run
dw_verif dw_verif
dw_data dw_data
dw_screen dw_screen
end type
global w_reference_value_reset w_reference_value_reset

type variables
integer ii_screen

end variables

on w_reference_value_reset.create
this.cb_close=create cb_close
this.cb_run=create cb_run
this.dw_verif=create dw_verif
this.dw_data=create dw_data
this.dw_screen=create dw_screen
this.Control[]={this.cb_close,&
this.cb_run,&
this.dw_verif,&
this.dw_data,&
this.dw_screen}
end on

on w_reference_value_reset.destroy
destroy(this.cb_close)
destroy(this.cb_run)
destroy(this.dw_verif)
destroy(this.dw_data)
destroy(this.dw_screen)
end on

event open;dw_screen.settransobject(sqlca)
dw_screen.retrieve()
end event

type cb_close from commandbutton within w_reference_value_reset
integer x = 2254
integer y = 84
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

type cb_run from commandbutton within w_reference_value_reset
integer x = 1847
integer y = 92
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;string ls_field1
string ls_field2
string ls_type1
string ls_type2
string ls_table
string ls_data_table
string ls_val1
string ls_val2
string ls_reference
string ls_sql
string ls_fields
string ls_lookup_field1
string ls_lookup_field2
string ls_lookup_type1
string ls_lookup_type2
string ls_where
long r
long d
long dc
long ll_recid


ls_sql = "Select "
ls_data_table = ""
ls_table = ls_data_table + " , ids "

//retrieve the verifications
dw_verif.settransobject(sqlca)
r = dw_verif.retrieve(ii_screen)

if r < 1 then
	messagebox("Utility","There are active verification records for this data screen.  Unable to continue")
	return
end if



// get the reference value fields
ls_field1 = ""



if isnull(ls_field1) or ls_field1 = '' then 
	messagebox("","There are no reference fields set in the system for this screen.  Unable to continue")
	return
end if

//ls_field1 = dw_screen.getitemnumber(1,"ref_field_1")
//ls_field2 = dw_screen.getitemnumber(1,"ref_field_2")

if ls_field1 <> "" then
	ls_fields = ls_field1
end if

if ls_field2 <> "" then
	ls_fields = ls_fields + " , " + ls_field2
end if





//get the lookup type
if ls_lookup_field1 = "Y" then
	choose case ls_lookup_type1
		case "A"
			ls_fields = ls_fields + " , " + "luf1.entity_name"
			ls_table = ls_table + " , address_lookup luf1 "
			ls_where = ls_where + " " + ls_data_table + "." + ls_field1 + " = address_lookup.lookup_code "
		case "C"
			ls_fields = ls_fields + " , " + "luf1.description"
			ls_table = ls_table + " , code_lookup luf1 "
			ls_where = ls_where + " " + ls_data_table + "." + ls_field1 + " = code_lookup.lookup_code "
	end choose
	
end if

if ls_lookup_field2 = "Y" then
	choose case ls_lookup_type2
		case "A"
			ls_fields = ls_fields + " , " + "luf2.entity_name"
			ls_table = ls_table + " , address_lookup luf2 "
		case "C"
			ls_fields = ls_fields + " , " + "luf2.description"
			ls_table = ls_table + " , code_lookup luf2 "
	end choose
	
end if


//finish the sql and retrieve the data records
///where...

//get the pracids


dc = dw_data.rowcount()

for d = 1 to dc
	ll_recid = dw_data.getitemnumber(d,"rec_id")
	// filter the verification records
	dw_verif.setfilter("rec_id = " + string(ll_recid))
	dw_verif.filter()
	
	//assemble the reference value
//	ls_val1 = ...
	
	
	
//	ls_val2 = ...

	ls_reference = ls_val1 + " - " + ls_val2
	for r = 1 to dw_verif.rowcount()
		dw_verif.setitem(r,"reference_value", ls_reference)
	next
	
	//update every 100 data records
	
next
 



//

end event

type dw_verif from datawindow within w_reference_value_reset
integer x = 1102
integer y = 384
integer width = 686
integer height = 400
integer taborder = 30
string title = "none"
string dataobject = "d_verif_reference_update"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_data from datawindow within w_reference_value_reset
integer x = 123
integer y = 360
integer width = 686
integer height = 400
integer taborder = 20
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_screen from datawindow within w_reference_value_reset
integer x = 50
integer y = 44
integer width = 1234
integer height = 104
integer taborder = 10
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;ii_screen = integer(data)
end event

