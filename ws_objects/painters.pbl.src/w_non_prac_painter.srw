$PBExportHeader$w_non_prac_painter.srw
forward
global type w_non_prac_painter from window
end type
type cb_about from commandbutton within w_non_prac_painter
end type
type dw_detail from datawindow within w_non_prac_painter
end type
type cb_close from commandbutton within w_non_prac_painter
end type
type cb_add from commandbutton within w_non_prac_painter
end type
type cb_del from commandbutton within w_non_prac_painter
end type
type cb_sel from commandbutton within w_non_prac_painter
end type
type dw_1 from u_dw within w_non_prac_painter
end type
type cb_save from commandbutton within w_non_prac_painter
end type
end forward

global type w_non_prac_painter from window
integer width = 4613
integer height = 2016
boolean titlebar = true
string title = "Non-Practitioners"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_about cb_about
dw_detail dw_detail
cb_close cb_close
cb_add cb_add
cb_del cb_del
cb_sel cb_sel
dw_1 dw_1
cb_save cb_save
end type
global w_non_prac_painter w_non_prac_painter

type variables
long il_prac
end variables

forward prototypes
public function integer of_setup_dw ()
public function string of_create_name (long al_row)
public function integer of_save ()
end prototypes

public function integer of_setup_dw ();
DataWindowChild dwchild

dw_detail.GetChild( "title", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve("Title")
dwchild.insertrow(1)
dw_detail.GetChild( "prof_suffix", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve("Professional Suffix")
dwchild.insertrow(1)
dw_detail.GetChild( "cust_6", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve("Department")
dwchild.insertrow(1)





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

public function integer of_save ();//Start Code Change ----01.03.2008 #V8 maha; function added ;called from save and add buttons
long pid
long f

if dw_detail.rowcount( ) < 1 then return 1

dw_detail.accepttext()

//validation
if isnull(dw_detail.getitemstring(1,"last_name")) then
	messagebox("Data Error","Last Name is required.")
	return -1
end if

if isnull(dw_detail.getitemstring(1,"first_name")) then
	messagebox("Data Error","First Name is required.")
	return -1
end if

//set prac id
if isnull(dw_detail.getitemnumber(1,"prac_id")) then
	select min(prac_id) into :pid from pd_basic;
	if isnull(pid) then pid = 0
	if pid > 0 then pid = 0
	pid = pid - 1
	il_prac = pid
	
	dw_detail.setitem(1,"prac_id",pid)
	dw_detail.setitem(1,"rec_id",pid)
end if

dw_detail.update( )
dw_1.retrieve( )

f = dw_1.find("prac_id = " + string(il_prac),1,dw_1.rowcount())
if f > 0 then
	dw_1.scrolltorow(f)
	dw_1.setrow(f)
	dw_1.selectrow(0,false)
	dw_1.selectrow(f,true)
end if

return 1
end function

on w_non_prac_painter.create
this.cb_about=create cb_about
this.dw_detail=create dw_detail
this.cb_close=create cb_close
this.cb_add=create cb_add
this.cb_del=create cb_del
this.cb_sel=create cb_sel
this.dw_1=create dw_1
this.cb_save=create cb_save
this.Control[]={this.cb_about,&
this.dw_detail,&
this.cb_close,&
this.cb_add,&
this.cb_del,&
this.cb_sel,&
this.dw_1,&
this.cb_save}
end on

on w_non_prac_painter.destroy
destroy(this.cb_about)
destroy(this.dw_detail)
destroy(this.cb_close)
destroy(this.cb_add)
destroy(this.cb_del)
destroy(this.cb_sel)
destroy(this.dw_1)
destroy(this.cb_save)
end on

event open;//Start Code Change ---- 10.04.2006 #659 maha
//window created 10.04.06
string ls_for

ls_for = message.stringparm

choose case ls_for
	case "A"
		cb_sel.enabled = false
		dw_1.modify( "selected_t.visible='0'")//long.zhang 12.05.2013 should be invisibleBugL120201 
		dw_1.modify( "selected.visible='0'")//long.zhang 12.05.2013 should be invisibleBugL120201 
	case "S"
		//dw_detail.visible = false
end choose

dw_1.settransobject(sqlca)
dw_1.retrieve()
dw_detail.settransobject(sqlca)
of_setup_dw()
end event

type cb_about from commandbutton within w_non_prac_painter
integer x = 4027
integer y = 36
integer width = 265
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "About"
end type

event clicked;messagebox("About","This utility is for creating non- practitioner records available for inclusion in meeting attendance. ")
end event

type dw_detail from datawindow within w_non_prac_painter
integer y = 1728
integer width = 4594
integer height = 200
integer taborder = 20
string title = "none"
string dataobject = "d_non_prac_detail"
boolean livescroll = true
end type

type cb_close from commandbutton within w_non_prac_painter
integer x = 4302
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

type cb_add from commandbutton within w_non_prac_painter
integer x = 315
integer y = 36
integer width = 265
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;long pid

if of_save() < 1 then return

dw_detail.reset()
dw_detail.insertrow(1)

dw_detail.setfocus()  //Start Code Change ----05.04.2011 #V11 maha 



end event

type cb_del from commandbutton within w_non_prac_painter
integer x = 590
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
string text = "&Delete"
end type

event clicked;//Start Code Change ----01.03.2008 #V8 maha -- coded button  -- does not test for existing records
integer res

if dw_detail.rowcount()< 1 then return

res = messagebox("Delete","Do you want to delete this record?",question!,yesno!,2)

if res = 2 then return

dw_detail.deleterow(0)

dw_detail.update()
dw_1.retrieve()


end event

type cb_sel from commandbutton within w_non_prac_painter
integer x = 1797
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

event clicked;long i
long ic
long ll_prac
long c = 0
string ls_name
gs_batch_search lst_search

for i = 1 to dw_1.rowcount()
	if dw_1.getitemnumber(i,"selected") = 1 then
		c++
		lst_search.li_prac_id[c] = dw_1.getitemnumber(i,"prac_id")
		lst_search.ls_name[c] = of_create_name(i)
	end if
next

if c = 0 then
	messagebox("Non-Practitioners","No Practitioners Selected")
else
	closewithreturn(parent,lst_search)
end if

end event

type dw_1 from u_dw within w_non_prac_painter
integer y = 156
integer width = 4594
integer height = 1568
integer taborder = 10
string dataobject = "d_non_prac_browse"
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;long r
long pid

r = this.getclickedrow()
if r < 1 then return 

this.selectrow( 0, false)
this.selectrow( r, true)
this.setrow(r)

pid = this.getitemnumber(r,"prac_id")
il_prac = pid
dw_detail.retrieve(pid)
end event

type cb_save from commandbutton within w_non_prac_painter
integer x = 41
integer y = 36
integer width = 265
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;long pid

if dw_detail.rowcount() < 1 then return

of_save()

//if isnull(dw_detail.getitemnumber(1,"prac_id")) then
//	select min(prac_id) into :pid from pd_basic;
//	if isnull(pid) then pid = 0
//	if pid > 0 then pid = 0
//	pid = pid - 1
//	
//	dw_detail.setitem(1,"prac_id",pid)
//	dw_detail.setitem(1,"rec_id",pid)
//end if
//
//
//
//dw_detail.update( )
//dw_1.retrieve( )
end event

