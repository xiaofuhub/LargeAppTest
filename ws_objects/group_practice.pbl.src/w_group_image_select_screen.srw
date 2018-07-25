$PBExportHeader$w_group_image_select_screen.srw
forward
global type w_group_image_select_screen from w_response
end type
type st_2 from statictext within w_group_image_select_screen
end type
type sle_ref from singlelineedit within w_group_image_select_screen
end type
type dw_screen from datawindow within w_group_image_select_screen
end type
type dw_browse from u_dw within w_group_image_select_screen
end type
type cb_ok from commandbutton within w_group_image_select_screen
end type
type cb_close from commandbutton within w_group_image_select_screen
end type
type st_1 from statictext within w_group_image_select_screen
end type
end forward

global type w_group_image_select_screen from w_response
integer x = 214
integer y = 221
integer width = 3401
integer height = 864
boolean controlmenu = false
long backcolor = 33551856
st_2 st_2
sle_ref sle_ref
dw_screen dw_screen
dw_browse dw_browse
cb_ok cb_ok
cb_close cb_close
st_1 st_1
end type
global w_group_image_select_screen w_group_image_select_screen

type variables
integer ii_table = 0
long il_group
long il_rec
end variables

forward prototypes
public function integer of_set_browse (integer ai_table)
public function string of_set_reference ()
end prototypes

public function integer of_set_browse (integer ai_table);//Start Code Change ----10.04.2016 #V152 maha
string ls_dwo
integer rc

choose case ai_table
	case 80 //language
		ls_dwo = "d_gp_language_browse"
	case 81//questions
		ls_dwo = "d_gp_quest_browse"
	case 82//partners covering
		ls_dwo = "d_gp_owner_covering_browse"
	case 83//ids
		ls_dwo = "d_gp_other_ids_browse"
	case 84//insurance
		ls_dwo = "d_gp_insurance_browse"
	case 85//practice info
		ls_dwo = "d_gp_practice_info_browse"
	case 86 //location
		ls_dwo = "d_group_location_browse"
end choose

dw_browse.dataobject = ls_dwo
dw_browse.settransobject(sqlca)
rc = dw_browse.retrieve( il_group )

if rc = 0 then
	il_rec = 0
else
	il_rec = dw_browse.getitemnumber(1, "rec_id")
end if

return 1
end function

public function string of_set_reference ();string ls_ref
long ll_val

choose case dw_browse.dataobject
	case "d_gp_language_browse"
		ll_val = dw_browse.getitemnumber(dw_browse.getrow(), "foreign_language")
		ls_ref = gnv_data.of_getitem( "code_lookup", "Description", "lookup_code = " + string(ll_val))
	case "d_gp_quest_browse"  //questions
		ls_ref = dw_browse. getitemstring(dw_browse.getrow(),   "question_lookup_full_quest")
	case   "d_gp_owner_covering_browse" //partners covering
		ls_ref = dw_browse. getitemstring(dw_browse.getrow(),   "last_name")
	case "d_gp_other_ids_browse"
		ll_val = dw_browse.getitemnumber(dw_browse.getrow(), "id_type")
		ls_ref = gnv_data.of_getitem( "code_lookup", "Description", "lookup_code = " + string(ll_val))
	case "d_gp_insurance_browse"   //insurance
		ls_ref = dw_browse. getitemstring(dw_browse.getrow(),   "policy_number")
	case "d_gp_practice_info_browse"   //practice info
		ls_ref = "Practice Info"
	case "d_group_location_browse"   //location
		ls_ref = dw_browse. getitemstring(dw_browse.getrow(),   "alias_name")
end choose

sle_ref.text = ls_ref

return ls_ref
		
		

end function

on w_group_image_select_screen.create
int iCurrent
call super::create
this.st_2=create st_2
this.sle_ref=create sle_ref
this.dw_screen=create dw_screen
this.dw_browse=create dw_browse
this.cb_ok=create cb_ok
this.cb_close=create cb_close
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.sle_ref
this.Control[iCurrent+3]=this.dw_screen
this.Control[iCurrent+4]=this.dw_browse
this.Control[iCurrent+5]=this.cb_ok
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.st_1
end on

on w_group_image_select_screen.destroy
call super::destroy
destroy(this.st_2)
destroy(this.sle_ref)
destroy(this.dw_screen)
destroy(this.dw_browse)
destroy(this.cb_ok)
destroy(this.cb_close)
destroy(this.st_1)
end on

event open;call super::open;//Start Code Change ----10.03.2016 #V153 maha - added for Documents

il_group = message.doubleparm

dw_screen.settransobject(sqlca)
dw_screen.retrieve()

//default to Location screen
ii_table = 86
dw_screen.setitem(1,"table_id", ii_table)
of_set_browse( ii_table)




end event

type st_2 from statictext within w_group_image_select_screen
integer x = 1376
integer y = 28
integer width = 329
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Reference:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_ref from singlelineedit within w_group_image_select_screen
integer x = 1719
integer y = 16
integer width = 896
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type dw_screen from datawindow within w_group_image_select_screen
integer x = 370
integer y = 16
integer width = 1019
integer height = 80
integer taborder = 20
string title = "none"
string dataobject = "d_table_list_groups"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_table = integer(data)

of_set_browse(ii_table)
end event

type dw_browse from u_dw within w_group_image_select_screen
integer x = 18
integer y = 120
integer width = 3365
integer height = 636
integer taborder = 20
string title = "none"
string dataobject = "d_group_prac_search"
boolean hscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;if currentrow > 0 then
	il_rec = this.getitemnumber(currentrow, "rec_id")
	of_set_reference()
end if


end event

event constructor;call super::constructor;This.of_SetRowSelect(True) //Added by Appeon long.zhang 02.22.2017 (BugL022201)
end event

type cb_ok from commandbutton within w_group_image_select_screen
integer x = 2629
integer y = 16
integer width = 370
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

event clicked;gs_pass_ids lst_ids
string s

if ii_table < 1 then
	messagebox("Select Error", "You have not selected a data screen.")
	return
end if

if il_rec < 1 then
	messagebox("Select Error", "There are no records for the Selected screen.")
	return
end if

s = sle_ref.text

lst_ids.l_app_id = ii_table
lst_ids.prac_id = il_rec
lst_ids.s_stringval = s

closewithreturn(parent, lst_ids)
end event

type cb_close from commandbutton within w_group_image_select_screen
integer x = 3003
integer y = 16
integer width = 370
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

event clicked;closewithreturn(parent,"Cancel")
end event

type st_1 from statictext within w_group_image_select_screen
integer x = 46
integer y = 28
integer width = 366
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Screen:"
boolean focusrectangle = false
end type

