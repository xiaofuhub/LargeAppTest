$PBExportHeader$w_practitioner_filter_choice_new.srw
forward
global type w_practitioner_filter_choice_new from window
end type
type cbx_select from checkbox within w_practitioner_filter_choice_new
end type
type st_4 from statictext within w_practitioner_filter_choice_new
end type
type st_3 from statictext within w_practitioner_filter_choice_new
end type
type cb_batch from commandbutton within w_practitioner_filter_choice_new
end type
type st_1 from statictext within w_practitioner_filter_choice_new
end type
type cb_2 from commandbutton within w_practitioner_filter_choice_new
end type
type cb_single from commandbutton within w_practitioner_filter_choice_new
end type
type dw_1 from datawindow within w_practitioner_filter_choice_new
end type
type ln_1 from line within w_practitioner_filter_choice_new
end type
type ln_2 from line within w_practitioner_filter_choice_new
end type
type ln_3 from line within w_practitioner_filter_choice_new
end type
end forward

global type w_practitioner_filter_choice_new from window
integer x = 585
integer y = 932
integer width = 2949
integer height = 596
windowtype windowtype = response!
long backcolor = 33551856
cbx_select cbx_select
st_4 st_4
st_3 st_3
cb_batch cb_batch
st_1 st_1
cb_2 cb_2
cb_single cb_single
dw_1 dw_1
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
end type
global w_practitioner_filter_choice_new w_practitioner_filter_choice_new

type variables
integer ii_screen
end variables

on w_practitioner_filter_choice_new.create
this.cbx_select=create cbx_select
this.st_4=create st_4
this.st_3=create st_3
this.cb_batch=create cb_batch
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_single=create cb_single
this.dw_1=create dw_1
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
this.Control[]={this.cbx_select,&
this.st_4,&
this.st_3,&
this.cb_batch,&
this.st_1,&
this.cb_2,&
this.cb_single,&
this.dw_1,&
this.ln_1,&
this.ln_2,&
this.ln_3}
end on

on w_practitioner_filter_choice_new.destroy
destroy(this.cbx_select)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.cb_batch)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_single)
destroy(this.dw_1)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
end on

event open;//Start Code Change ----01.28.2015 #V14.2 maha - rebuilt for subselect in new window

IF gb_sk_ver = True THEN  //Start Code Change ----11.19.2010 #V10 maha - hide for SK
	cb_single.triggerevent(clicked!)
	return
end if

dw_1.settransobject(sqlca)
dw_1.retrieve()
//--------------------------- APPEON BEGIN ---------------------------
//$<Modified> 01.13.2006 By: Liuhongxin
//$<reason> Fix a defect.
/* 
dw_1.insertrow(1)
*/
datawindowchild dwchild
dw_1.GetChild("batch_id", dwchild)
dwchild.SetTransObject(Sqlca)
dwchild.InsertRow(1)
dwchild.SetItem(1, "batch_id", -999)
dwchild.SetItem(1, "batch_name", "")

dw_1.SetItem(1, "batch_id", -999)
//---------------------------- APPEON END ----------------------------

end event

type cbx_select from checkbox within w_practitioner_filter_choice_new
integer x = 1527
integer y = 312
integer width = 434
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Sub-select"
end type

type st_4 from statictext within w_practitioner_filter_choice_new
integer x = 46
integer y = 188
integer width = 1605
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
boolean enabled = false
string text = "The BATCH SEARCH button to create an IntelliBatch list,"
boolean focusrectangle = false
end type

type st_3 from statictext within w_practitioner_filter_choice_new
integer x = 41
integer y = 316
integer width = 1033
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
boolean enabled = false
string text = "Or select an existing IntelliBatch list."
boolean focusrectangle = false
end type

type cb_batch from commandbutton within w_practitioner_filter_choice_new
integer x = 2016
integer y = 176
integer width = 841
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Batch Search"
end type

event clicked;gs_batch_search lst_search

OpenWithParm( w_batch_prac_select_new , "R" )
if message.stringparm = "Cancel" then 
	//ll_pracs[1] = 0
	closewithreturn(parent,"C")
else
	lst_search = message.powerobjectparm
	if IsValid(lst_search) then // Add by Evan 05.04.2010 --- trap object if null
			//messagebox("",p
		closewithreturn(parent,lst_search)
	end if 
end if








end event

type st_1 from statictext within w_practitioner_filter_choice_new
integer x = 41
integer y = 60
integer width = 1925
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
boolean enabled = false
string text = "Click the INDIVIDUAL PRACTITIONER button for specific practitioners, "
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_practitioner_filter_choice_new
integer x = 2016
integer y = 432
integer width = 841
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,"C")
end event

type cb_single from commandbutton within w_practitioner_filter_choice_new
integer x = 2016
integer y = 44
integer width = 841
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Individual Practitioner"
end type

event clicked;gs_search lstr_search
gs_batch_search lst_blist
long ll_pracs[]

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "ACTIONITEMS"

OpenWithParm( w_extended_search_new , lstr_search )
IF Message.DoubleParm = -1 THEN 
	Return -1
else
ll_pracs[1] = long(Message.stringParm)
	//messagebox("",ls_pracids)
end if

lst_blist.li_prac_id = ll_pracs

closewithreturn(parent, lst_blist)
end event

type dw_1 from datawindow within w_practitioner_filter_choice_new
integer x = 2016
integer y = 304
integer width = 841
integer height = 84
integer taborder = 30
string dataobject = "d_d_batch_list"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//ii_screen = integer(data)
//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 01.13.2006 By: Liuhongxin
//$<reason> Fix a defect.
if Long(data) = -999 then return 0
//---------------------------- APPEON END ----------------------------


//Start Code Change ----01.28.2015 #V14.2 maha - rebuilt for subselect in new window
string v
gs_batch_search lst_search
gs_batch_search lst_blist
long ll_pracs[]
long ll_batch_id
long ic
long i

ll_batch_id  = long(data)
n_ds lds_batch
lds_batch = CREATE n_ds
lds_batch.DataObject = "d_batch_items_list"
lds_batch.of_SetTransObject( SQLCA )
ic = lds_batch.retrieve(ll_batch_id) 

for i = 1 to ic
	ll_pracs[i] = long(lds_batch.getitemnumber(i,"prac_id"))
next
destroy lds_batch


if cbx_select.checked then
	lst_search.li_prac_id = ll_pracs
	openwithparm(w_batch_sub_select,lst_search )
	if message.stringparm = "Cancel" then
		ll_pracs[1] = 0
	else
		lst_search = message.powerobjectparm
		ll_pracs[] = lst_search.li_prac_id
	end if
end if


lst_blist.li_prac_id = ll_pracs

closewithreturn(parent, lst_blist)




end event

type ln_1 from line within w_practitioner_filter_choice_new
integer linethickness = 4
integer beginx = 32
integer beginy = 280
integer endx = 2889
integer endy = 280
end type

type ln_2 from line within w_practitioner_filter_choice_new
integer linethickness = 4
integer beginx = 32
integer beginy = 144
integer endx = 2889
integer endy = 144
end type

type ln_3 from line within w_practitioner_filter_choice_new
integer linethickness = 4
integer beginx = 32
integer beginy = 416
integer endx = 2889
integer endy = 416
end type

