$PBExportHeader$w_batch_texting.srw
forward
global type w_batch_texting from w_popup
end type
type st_2 from statictext within w_batch_texting
end type
type st_cnt from statictext within w_batch_texting
end type
type st_1 from statictext within w_batch_texting
end type
type cb_close from commandbutton within w_batch_texting
end type
type cb_send from commandbutton within w_batch_texting
end type
type mle_1 from multilineedit within w_batch_texting
end type
type dw_pracs from datawindow within w_batch_texting
end type
type cb_batch from commandbutton within w_batch_texting
end type
type cb_search from commandbutton within w_batch_texting
end type
end forward

global type w_batch_texting from w_popup
integer x = 214
integer y = 221
integer width = 3378
string title = "Batch Provider Texting"
boolean controlmenu = false
long backcolor = 33551856
st_2 st_2
st_cnt st_cnt
st_1 st_1
cb_close cb_close
cb_send cb_send
mle_1 mle_1
dw_pracs dw_pracs
cb_batch cb_batch
cb_search cb_search
end type
global w_batch_texting w_batch_texting

type variables
long il_pracid
long ii_facid
long il_pracs[]
end variables

on w_batch_texting.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_cnt=create st_cnt
this.st_1=create st_1
this.cb_close=create cb_close
this.cb_send=create cb_send
this.mle_1=create mle_1
this.dw_pracs=create dw_pracs
this.cb_batch=create cb_batch
this.cb_search=create cb_search
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_cnt
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.cb_send
this.Control[iCurrent+6]=this.mle_1
this.Control[iCurrent+7]=this.dw_pracs
this.Control[iCurrent+8]=this.cb_batch
this.Control[iCurrent+9]=this.cb_search
end on

on w_batch_texting.destroy
call super::destroy
destroy(this.st_2)
destroy(this.st_cnt)
destroy(this.st_1)
destroy(this.cb_close)
destroy(this.cb_send)
destroy(this.mle_1)
destroy(this.dw_pracs)
destroy(this.cb_batch)
destroy(this.cb_search)
end on

type st_2 from statictext within w_batch_texting
integer x = 2135
integer y = 836
integer width = 1189
integer height = 536
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "In order to send a text to a provider, you must have the mobile number (car_phone_1) as well as the Mobile Carrier.  These fields are normally found on the Personal Data screen."
boolean border = true
boolean focusrectangle = false
end type

type st_cnt from statictext within w_batch_texting
integer x = 2418
integer y = 776
integer width = 288
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "0"
boolean focusrectangle = false
end type

type st_1 from statictext within w_batch_texting
integer x = 2135
integer y = 772
integer width = 288
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Characters:"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_batch_texting
integer x = 2921
integer y = 20
integer width = 402
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_send from commandbutton within w_batch_texting
integer x = 2144
integer y = 20
integer width = 402
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Send Text"
end type

event clicked; //Start Code Change ----05.01.2017 #V154 maha
string ls_mobile
string ls_carrier
string ls_carrier_name
string ls_text
string ls_stat
integer r
integer rc
integer res
long ll_prac

rc = dw_pracs.rowcount()

if rc < 1 then return

ls_text = mle_1.text

if len(ls_text) < 1 then
	messageBox("Texting", "Please enter a text message.")
	return
end if

for r = 1 to rc
	ls_mobile = dw_pracs.getitemstring(r, "car_phone_1")
	ls_carrier = dw_pracs.getitemstring(r, "custom_1")
	ls_carrier_name = dw_pracs.getitemstring(r, "description")
	ll_prac = dw_pracs.getitemnumber(r, "prac_id")
	
	if isnull(ls_mobile) or len(ls_mobile) = 0 then
		//messageBox("Texting", "This provider does not have a Mobile Number.")
		continue
	end if
	
	if isnull(ls_carrier) or len(ls_carrier) = 0 then
		//MessageBox("Texting", "This provider does not have a Mobile Carrier.")
		continue
	end if
	
	res = of_send_text(ls_mobile, ls_carrier, ls_text)  //application function
	
	if res = 1 then
		dw_pracs.setitem(r, "issent", 1)
		of_log_text(ll_prac, ls_mobile + "@" + ls_carrier , ls_carrier_name, ls_text, 1 , "B")  //application function
	else
		of_log_text(ll_prac, ls_mobile + "@" + ls_carrier, ls_carrier_name, ls_text, 0 ,  "B") //application function
	end if
next



end event

type mle_1 from multilineedit within w_batch_texting
integer x = 2135
integer y = 132
integer width = 1189
integer height = 616
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event modified;integer c
string s

s = this.text

c = lenA(s)

st_cnt.text = string(c)
end event

type dw_pracs from datawindow within w_batch_texting
integer x = 14
integer y = 136
integer width = 2103
integer height = 1236
integer taborder = 30
boolean bringtotop = true
string title = "Providers"
string dataobject = "d_practitioner_list_text_batch"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;integer r

r  = this.getclickedrow()
if r < 1 then return

this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)

il_pracid = this.getitemnumber(r,"prac_id")
//messagebox("il_pracid",il_pracid)
//dw_browse.settransobject(sqlca)
//dw_browse.retrieve(il_prac,ii_facil)
//of_retrieve_data(is_ret_type)
end event

type cb_batch from commandbutton within w_batch_texting
integer x = 539
integer y = 20
integer width = 507
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Batch Search"
end type

event clicked;
gs_batch_search lst_search
long i
long ic
long p
long pc
long ll_prac_id
long pracids[]
long li_find
string names[]
string ls_openstring


//ib_fax_num_email_search = False

if ii_facid > 0 then
	ls_openstring = "R*" + string(ii_facid)
elseif ii_facid = 0 then 
	ls_openstring = "R*ALL" 
else 
	ls_openstring = "R"
end if
	
openwithparm(w_batch_prac_select_new,ls_openstring)

if message.stringparm = "Cancel" then return
//names[] = lst 
lst_search = message.powerobjectparm
pracids[] = lst_search.li_prac_id[]
names[] = lst_search.ls_name[]
 ic = upperbound(pracids[]) 

pc = upperbound(il_pracs[])

for i = 1 to ic
	li_find = 0
	ll_prac_id = lst_search.li_prac_id[i] 
	
	//find prac in array
	for p = 1 to pc
		if il_pracid = il_pracs[p] then
			li_find = 1
			exit
		end if
	next
	
	//add is not found
	if li_find = 0 then
		il_pracs[pc + 1] = ll_prac_id
		pc = pc + 1
	end if

next

dw_pracs.settransobject(sqlca)
dw_pracs.retrieve(il_pracs) 	
end event

type cb_search from commandbutton within w_batch_texting
integer x = 23
integer y = 20
integer width = 507
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Provider Search"
end type

event clicked; //Start Code Change ----09.18.2015 #V15 maha - copied from correspondence
Integer li_nr
Integer li_find
integer i
integer ic
integer p
integer pc
Long ll_prac_id
String ls_full_name
gs_search lstr_search
gs_batch_search ist_search

//ib_fax_num_email_search = False

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "REPORTS" + String( ii_facid ) 

//Start Code Change ----12.13.2010 #V10 maha - for sk
if gb_sk_ver then
	lstr_search.ls_open_for = "SKS"
	OpenWithParm( w_extended_search_app , lstr_search )
else
	OpenWithParm( w_extended_search_new , lstr_search )
end if
//Start Code Change ----12.13.2010


IF Message.DoubleParm = -1 THEN
	Return -1
END IF

ist_search = message.powerobjectparm
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.13.2006 By: Cao YongWang
//$<reason> Fix a defect.
If not isvalid(ist_search) Then return 
//---------------------------- APPEON END ----------------------------

//maha 091605 allowing for multi selection

// mskinner 20 dec 2005 -- begin 
if not isvalid(message.powerobjectparm) then return 0
// mskinner 20 dec 2005 -- end 

ic = upperbound(ist_search.li_prac_id[])


pc = upperbound(il_pracs[])

for i = 1 to ic
	li_find = 0
	ll_prac_id = ist_search.li_prac_id[i] 
	
	//find prac in array
	for p = 1 to pc
		if il_pracid = il_pracs[p] then
			li_find = 1
			exit
		end if
	next
	
	//add is not found
	if li_find = 0 then
		il_pracs[pc + 1] = ll_prac_id
		pc = pc + 1
	end if

next

dw_pracs.settransobject(sqlca)
dw_pracs.retrieve(il_pracs) 	



//dw_pracs.SetFocus( )
//dw_pracs.SelectRow( 0 , False )
//dw_pracs.ScrollToRow( li_nr )
//dw_pracs.SetRow ( li_nr )
//dw_pracs.SelectRow( li_nr , True )



end event

