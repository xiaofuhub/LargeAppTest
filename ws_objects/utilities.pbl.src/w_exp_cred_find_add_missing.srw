$PBExportHeader$w_exp_cred_find_add_missing.srw
forward
global type w_exp_cred_find_add_missing from w_response
end type
type cb_close from commandbutton within w_exp_cred_find_add_missing
end type
type cb_2 from commandbutton within w_exp_cred_find_add_missing
end type
type cb_1 from commandbutton within w_exp_cred_find_add_missing
end type
type cbx_health from checkbox within w_exp_cred_find_add_missing
end type
type cbx_dea from checkbox within w_exp_cred_find_add_missing
end type
type cbx_spec from checkbox within w_exp_cred_find_add_missing
end type
type cbx_ins from checkbox within w_exp_cred_find_add_missing
end type
type cbx_other from checkbox within w_exp_cred_find_add_missing
end type
type cbx_certs from checkbox within w_exp_cred_find_add_missing
end type
type cbx_lic from checkbox within w_exp_cred_find_add_missing
end type
end forward

global type w_exp_cred_find_add_missing from w_response
integer x = 214
integer y = 221
integer width = 1111
integer height = 1320
string title = "Missing Verifications"
long backcolor = 33551856
cb_close cb_close
cb_2 cb_2
cb_1 cb_1
cbx_health cbx_health
cbx_dea cbx_dea
cbx_spec cbx_spec
cbx_ins cbx_ins
cbx_other cbx_other
cbx_certs cbx_certs
cbx_lic cbx_lic
end type
global w_exp_cred_find_add_missing w_exp_cred_find_add_missing

type variables
pfc_n_cst_ai_printletters inv_let
end variables
on w_exp_cred_find_add_missing.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cbx_health=create cbx_health
this.cbx_dea=create cbx_dea
this.cbx_spec=create cbx_spec
this.cbx_ins=create cbx_ins
this.cbx_other=create cbx_other
this.cbx_certs=create cbx_certs
this.cbx_lic=create cbx_lic
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cbx_health
this.Control[iCurrent+5]=this.cbx_dea
this.Control[iCurrent+6]=this.cbx_spec
this.Control[iCurrent+7]=this.cbx_ins
this.Control[iCurrent+8]=this.cbx_other
this.Control[iCurrent+9]=this.cbx_certs
this.Control[iCurrent+10]=this.cbx_lic
end on

on w_exp_cred_find_add_missing.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cbx_health)
destroy(this.cbx_dea)
destroy(this.cbx_spec)
destroy(this.cbx_ins)
destroy(this.cbx_other)
destroy(this.cbx_certs)
destroy(this.cbx_lic)
end on

event open;call super::open; inv_let = create pfc_n_cst_ai_printletters
end event

event close;call super::close;destroy  inv_let
end event

type cb_close from commandbutton within w_exp_cred_find_add_missing
integer x = 233
integer y = 1032
integer width = 553
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

event clicked;close(parent)
end event

type cb_2 from commandbutton within w_exp_cred_find_add_missing
integer x = 233
integer y = 912
integer width = 553
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Missing"
end type

event clicked;//Start Code Change ----11.03.2017 #V16 maha
integer r
integer li_screen[]
integer rc = 7
long cnt
string ls_mess

for r = 1 to rc
	choose case r
		case 1 //board
			if cbx_spec.checked then
				cnt = inv_let.of_exp_credentials_check_for_data(19)
				if cnt > 0 then li_screen[upperbound(li_screen[]) +1 ] = 19
			end if
		case 2 //DEA
			if cbx_spec.checked then
				cnt = inv_let.of_exp_credentials_check_for_data(5)
				if cnt > 0 then li_screen[upperbound(li_screen[]) +1 ] = 5
			end if			
		case 3 //Health
			if cbx_health.checked then
				cnt = inv_let.of_exp_credentials_check_for_data(71)
				if cnt > 0 then li_screen[upperbound(li_screen[]) +1 ] = 71
			end if		
		case 4 //Insurance
			if cbx_ins.checked then
				cnt = inv_let.of_exp_credentials_check_for_data(15)
				if cnt > 0 then li_screen[upperbound(li_screen[]) +1 ] = 15
			end if			
		case 5 //License
			if cbx_lic.checked then
				cnt = inv_let.of_exp_credentials_check_for_data(4)
				if cnt > 0 then li_screen[upperbound(li_screen[]) +1 ] = 4
			end if			
		case 6 //Other Ids
			if cbx_other.checked then
				cnt = inv_let.of_exp_credentials_check_for_data(23)
				if cnt > 0 then li_screen[upperbound(li_screen) +1 ] = 23
			end if		
		case 7 //Special Certs
			if cbx_certs.checked then
				cnt = inv_let.of_exp_credentials_check_for_data(9)
				if cnt > 0 then li_screen[upperbound(li_screen) +1 ] = 9
			end if	
	end choose
next

inv_let.of_expiring_credentials_from_data_utl("UTL", li_screen[])
			

end event

type cb_1 from commandbutton within w_exp_cred_find_add_missing
integer x = 233
integer y = 796
integer width = 553
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Check for Missing"
end type

event clicked;//Start Code Change ----11.03.2017 #V16 maha
integer r
integer rc = 7
long cnt
string ls_mess

for r = 1 to rc
	choose case r
		case 1 //board
			if cbx_spec.checked then
				cnt = inv_let.of_exp_credentials_check_for_data(19)
				ls_mess = "There are " + string(cnt) + " missing Exp Verifications for Specialties. ~r"
			end if
		case 2 //DEA
			if cbx_spec.checked then
				cnt = inv_let.of_exp_credentials_check_for_data(5)
				ls_mess+= "There are " + string(cnt) + " missing Exp Verifications for DEAs. ~r"
			end if			
		case 3 //Health
			if cbx_health.checked then
				cnt = inv_let.of_exp_credentials_check_for_data(71)
				ls_mess+= "There are " + string(cnt) + " missing Exp Verifications for Health History. ~r"
			end if		
		case 4 //Insurance
			if cbx_ins.checked then
				cnt = inv_let.of_exp_credentials_check_for_data(15)
				ls_mess+= "There are " + string(cnt) + " missing Exp Verifications for Insurance. ~r"
			end if			
		case 5 //License
			if cbx_lic.checked then
				cnt = inv_let.of_exp_credentials_check_for_data(4)
				ls_mess+= "There are " + string(cnt) + " missing Exp Verifications for License. ~r"
			end if			
		case 6 //Other Ids
			if cbx_other.checked then
				cnt = inv_let.of_exp_credentials_check_for_data(23)
				ls_mess+= "There are " + string(cnt) + " missing Exp Verifications for Other Ids. ~r"
			end if		
		case 7 //Special Certs
			if cbx_certs.checked then
				cnt = inv_let.of_exp_credentials_check_for_data(9)
				ls_mess+= "There are " + string(cnt) + " missing Exp Verifications for Specialty Certifications. ~r"
			end if	
	end choose

next

messagebox("Check Complete",ls_mess)
			

end event

type cbx_health from checkbox within w_exp_cred_find_add_missing
integer x = 197
integer y = 268
integer width = 667
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Health History"
end type

type cbx_dea from checkbox within w_exp_cred_find_add_missing
integer x = 197
integer y = 180
integer width = 667
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "DEA"
end type

type cbx_spec from checkbox within w_exp_cred_find_add_missing
integer x = 197
integer y = 92
integer width = 667
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Board Specialty"
end type

type cbx_ins from checkbox within w_exp_cred_find_add_missing
integer x = 197
integer y = 356
integer width = 667
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Insurance"
end type

type cbx_other from checkbox within w_exp_cred_find_add_missing
integer x = 197
integer y = 532
integer width = 667
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Other Ids"
end type

type cbx_certs from checkbox within w_exp_cred_find_add_missing
integer x = 197
integer y = 620
integer width = 667
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Special Certifications"
end type

type cbx_lic from checkbox within w_exp_cred_find_add_missing
integer x = 197
integer y = 444
integer width = 667
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "License"
end type

