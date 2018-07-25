$PBExportHeader$w_committee_member_sele.srw
forward
global type w_committee_member_sele from window
end type
type cb_close from commandbutton within w_committee_member_sele
end type
type cb_sel from commandbutton within w_committee_member_sele
end type
type dw_1 from u_dw within w_committee_member_sele
end type
end forward

global type w_committee_member_sele from window
integer width = 3493
integer height = 1852
boolean titlebar = true
string title = "Committee members "
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
cb_sel cb_sel
dw_1 dw_1
end type
global w_committee_member_sele w_committee_member_sele

type variables

end variables

forward prototypes
public function integer of_setup_dw ()
public function string of_create_name (long al_row)
public function integer of_save ()
end prototypes

public function integer of_setup_dw ();
DataWindowChild dwchild

//dw_detail.GetChild( "title", dwchild )
//dwchild.settransobject(sqlca)
//dwchild.retrieve("Title")
//dwchild.insertrow(1)
//dw_detail.GetChild( "prof_suffix", dwchild )
//dwchild.settransobject(sqlca)
//dwchild.retrieve("Professional Suffix")
//dwchild.insertrow(1)
//dw_detail.GetChild( "cust_6", dwchild )
//dwchild.settransobject(sqlca)
//dwchild.retrieve("Department")
//dwchild.insertrow(1)
//




return 1
end function

public function string of_create_name (long al_row);string ls_ret
string ls_val
string ls_trail = ""
string ls_pre = ""
integer i
integer li_find
long ll_num
DataWindowChild dwchild



ls_val = dw_1.getitemstring(al_row,"last_name") 
ls_ret = ls_val + ", "

for i = 1 to 3 //other fields
	ls_trail = ""
	choose case i
		case 1
			ls_val = dw_1.getitemstring(al_row,"first_name")
			if isnull(ls_val) then 
				ls_val = ""
			else
				ls_trail = " "
			end if
		case 2
			ls_val = dw_1.getitemstring(al_row,"middle_name")
			if isnull(ls_val) then 
				ls_val = ""
			else
				ls_val = MidA(ls_val,1,1)
				ls_trail = ". "
			end if
			
		case 3
			ll_num = dw_1.getitemnumber(al_row,"prof_suffix")
			if isnull(ll_num) then
				ls_val = ""
			else
				dw_1.GetChild( "prof_suffix", dwchild )
				li_find = dwchild.find("lookup_code = " + string(ll_num),1,dwchild.rowcount())
				if li_find > 0 then
					ls_val = dwchild.getitemstring(li_find,"code")
				else
					ls_val = string(ll_num) //get the dwchild value
				end if
				ls_pre = "," //only add comma is a value exists
			end if
	end choose
		
	ls_ret = ls_ret + ls_pre + ls_val + ls_trail

next

//messagebox("",ls_ret)

return ls_ret











return ls_ret
end function

public function integer of_save ();

return 1
end function

on w_committee_member_sele.create
this.cb_close=create cb_close
this.cb_sel=create cb_sel
this.dw_1=create dw_1
this.Control[]={this.cb_close,&
this.cb_sel,&
this.dw_1}
end on

on w_committee_member_sele.destroy
destroy(this.cb_close)
destroy(this.cb_sel)
destroy(this.dw_1)
end on

event open;//////////////////////////////////////////////////////////////////////
// $<event> open
// $<arguments>
// $<returns> long
// $<description>Add Committee members (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 07.08.2011 by Stephen
//////////////////////////////////////////////////////////////////////

str_folder  lstr_1
datawindowchild  ldwc_1

lstr_1 = message.powerobjectparm

if isnull(lstr_1) then close(this)
dw_1.settransobject(sqlca)
dw_1.retrieve(lstr_1.al_category)
dw_1.getchild("committee_id", ldwc_1)
ldwc_1.settransobject(sqlca)
ldwc_1.retrieve(lstr_1.al_folder_id)


end event

type cb_close from commandbutton within w_committee_member_sele
integer x = 3159
integer y = 36
integer width = 265
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(parent)
end event

type cb_sel from commandbutton within w_committee_member_sele
integer x = 2894
integer y = 36
integer width = 265
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "S&elect"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> integer
// $<description>Add Committee members (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 07.08.2011 by Stephen
//////////////////////////////////////////////////////////////////////

long i
long ic
long ll_prac
long c = 0
string ls_name
gs_batch_search lst_search

for i = 1 to dw_1.rowcount()
	if dw_1.getitemnumber(i,"selected") = 1 then
		c++
		lst_search.li_prac_id[c] = dw_1.getitemnumber(i,"prac_id")
		lst_search.ls_name[c] = dw_1.getitemstring(i,"v_full_name_full_name")
	end if
next

if c = 0 then
	messagebox("Committee members","No Committee members Selected")
else
	closewithreturn(parent,lst_search)
end if

end event

type dw_1 from u_dw within w_committee_member_sele
integer x = 37
integer y = 156
integer width = 3397
integer height = 1568
integer taborder = 10
string dataobject = "d_committee_members_sele"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> integer
// $<description>Add Committee members (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 07.08.2011 by Stephen
//////////////////////////////////////////////////////////////////////

long r
long pid

r = this.getclickedrow()
if r < 1 then return 

this.selectrow( 0, false)
this.selectrow( r, true)
this.setrow(r)



end event

