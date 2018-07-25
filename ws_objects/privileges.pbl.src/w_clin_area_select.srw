$PBExportHeader$w_clin_area_select.srw
forward
global type w_clin_area_select from pfc_w_response
end type
type dw_clin from datawindow within w_clin_area_select
end type
type cb_ok from commandbutton within w_clin_area_select
end type
type cb_cancel from commandbutton within w_clin_area_select
end type
type st_1 from statictext within w_clin_area_select
end type
type dw_priv from datawindow within w_clin_area_select
end type
type cb_all from commandbutton within w_clin_area_select
end type
type rb_ini from radiobutton within w_clin_area_select
end type
type rb_reap from radiobutton within w_clin_area_select
end type
type dw_status from datawindow within w_clin_area_select
end type
type st_3 from statictext within w_clin_area_select
end type
type em_s from editmask within w_clin_area_select
end type
type em_e from editmask within w_clin_area_select
end type
type st_4 from statictext within w_clin_area_select
end type
type st_5 from statictext within w_clin_area_select
end type
type gb_1 from groupbox within w_clin_area_select
end type
end forward

global type w_clin_area_select from pfc_w_response
integer x = 91
integer y = 96
integer width = 3305
integer height = 2156
string title = "Select Privileges"
long backcolor = 33551856
dw_clin dw_clin
cb_ok cb_ok
cb_cancel cb_cancel
st_1 st_1
dw_priv dw_priv
cb_all cb_all
rb_ini rb_ini
rb_reap rb_reap
dw_status dw_status
st_3 st_3
em_s em_s
em_e em_e
st_4 st_4
st_5 st_5
gb_1 gb_1
end type
global w_clin_area_select w_clin_area_select

type variables
long il_clin_id
integer ii_appstat
string is_appstat
long il_stat
integer ii_close = 0
long ii_facil
long ii_template_id //evan 03.07.2011
long il_prac //maha022708
boolean ib_rollover = false //maha 09.26.2011
datastore ids_prac_privs
end variables

forward prototypes
public function integer of_get_rollover_privs ()
end prototypes

public function integer of_get_rollover_privs ();//Start Code Change ----09.26.2011 #V12 maha - added for rollover privs

long ll_cid[]
long ll_clin
long ll_proced
integer pc
integer rc
integer p
integer r
integer a
integer f
integer li_skip = 0

debugbreak()
ids_prac_privs.dataobject = "d_prac_priv_granted_all_area"
ids_prac_privs.settransobject( sqlca)
pc = ids_prac_privs.retrieve( il_prac, ii_facil )

if pc < 1 then
	messagebox("Privilege Rollover","There are no Granted privileges to rollover for this practitioner.~rIf there are no Privilege Status lookup items set to G in the granted column, please set this value for Granted statuses.")
	return -1
end if

for r = 1 to pc
	li_skip = 0
	ll_clin = ids_prac_privs.getitemnumber( r , "pd_priv_list_clinical_area_id")
	if r > 1 then
		for a = 1 to upperbound(ll_cid)
			if ll_clin = ll_cid[a] then
				li_skip = 1
				exit
			end if
		next
		if li_skip = 0 then ll_cid[upperbound(ll_cid) + 1] = ll_clin
	else
		ll_cid[1] = ll_clin
		il_clin_id = ll_clin  //trap for the ok event
	end if
next

rc = dw_priv.retrieve(ii_template_id, ll_cid)  //get all privileges for the clinical areas

if rc > 0 and pc > 0 then
	for r = 1 to rc //for each procedure see if the prac has granted priv and  
		ll_proced = dw_priv.getitemnumber(r,"priv_core_procd_procd_id")
		p = ids_prac_privs.find("pd_priv_list_procd_id = " + string(ll_proced),1,pc)
		if p > 0 then
			dw_priv.setitem(r,"selected",1)
		end if
	next
end if

return 1
end function

on w_clin_area_select.create
int iCurrent
call super::create
this.dw_clin=create dw_clin
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.st_1=create st_1
this.dw_priv=create dw_priv
this.cb_all=create cb_all
this.rb_ini=create rb_ini
this.rb_reap=create rb_reap
this.dw_status=create dw_status
this.st_3=create st_3
this.em_s=create em_s
this.em_e=create em_e
this.st_4=create st_4
this.st_5=create st_5
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_clin
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.dw_priv
this.Control[iCurrent+6]=this.cb_all
this.Control[iCurrent+7]=this.rb_ini
this.Control[iCurrent+8]=this.rb_reap
this.Control[iCurrent+9]=this.dw_status
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.em_s
this.Control[iCurrent+12]=this.em_e
this.Control[iCurrent+13]=this.st_4
this.Control[iCurrent+14]=this.st_5
this.Control[iCurrent+15]=this.gb_1
end on

on w_clin_area_select.destroy
call super::destroy
destroy(this.dw_clin)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.st_1)
destroy(this.dw_priv)
destroy(this.cb_all)
destroy(this.rb_ini)
destroy(this.rb_reap)
destroy(this.dw_status)
destroy(this.st_3)
destroy(this.em_s)
destroy(this.em_e)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.gb_1)
end on

event open;call super::open;string ls_from
string ls_val //maha 022708
integer f
long req

debugbreak()
ls_val = message.stringparm
//format P*1@234
ls_from = MidA(ls_val,1,1)

//Start Code Change ----02.27.2008 #V8 maha - added code for pre checking granted privileges
ii_facil = long(MidA(ls_val,3,PosA(ls_val,"@") - 3))
il_prac = long(MidA(ls_val,PosA(ls_val,"@") + 1))
select priv_template into :ii_template_id from facility where facility_id = :ii_facil; //Add by Evan 03.07.2011

ids_prac_privs = create datastore

ids_prac_privs.dataobject = "d_prac_priv_granted_4_area"
ids_prac_privs.settransobject(sqlca)
//ids_prac_privs.retrieve( ll_prac)
//End Code Change---02.27.2008

dw_clin.settransobject(sqlca)
DataWindowChild dwchild
//--------Begin Modified by  Nova 04.12.2010------------------------
//dw_clin.GetChild( "clinical_area_description", dwchild )
dw_clin.GetChild( "clinical_area_id", dwchild )
//--------End Modified --------------------------------------------
dwchild.settransobject(sqlca)
dw_status.settransobject(sqlca)
ii_appstat = 2 //"Recred"
debugbreak()
gnv_appeondb.of_startqueue()
	dw_clin.retrieve() 
	dwchild.retrieve(ii_template_id/*ii_facil*/) //Modify by Evan 03.07.2011
	dw_status.retrieve()
gnv_appeondb.of_commitqueue()

dw_clin.insertrow(1)
dw_status.insertrow(1)

dw_status.GetChild( "status_code", dwchild )
f = dwchild.find("code = 'REQST'",1,dwchild.rowcount())

req = dwchild.getitemnumber(f,"lookup_code")

dw_status.setitem(1,"status_code",req)

//Start Code Change ----09.26.2011 #V12 maha - for rollover functionality
if ls_from = "R" then
	ls_from = "B"
	ib_rollover = true
end if

	
if ls_from = "B" then	//Start Code Change ----03.25.2008 #V8 maha - moved down from the set child
	em_e.Visible = false
	em_s.Visible = false
	st_3.Visible = false
	st_4.Visible = false
	st_5.Visible = false
	dw_status.enabled = false
end if

if ib_rollover = true then
	dw_clin.visible = false
	st_1.visible = false
	rb_ini.visible = false
	f = of_get_rollover_privs( ) //if no privileges to rollover close window
	if f = -1 then
		close(this)
	end if
end if

//End Code Change ----09.26.2011
end event

event closequery;//ancestor override
if ii_close = 0 then
	cb_cancel.triggerevent(clicked!)
end if
end event

event close;call super::close;//Start Code Change ----02.27.2008 #V8 maha
destroy ids_prac_privs
//End Code Change---02.27.2008
end event

type dw_clin from datawindow within w_clin_area_select
integer x = 50
integer y = 124
integer width = 992
integer height = 80
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dddw_clin_area"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//Start Code Change ----02.27.2008 #V8 maha
integer pc
integer rc
integer r
integer p
long ll_proced
long ll_cid[]  //maha 09.26.2011

il_clin_id = long(data)
ll_cid[1] = il_clin_id  //Start Code Change ----09.26.2011 #V12 maha
dw_priv.settransobject(sqlca)

//------------------- APPEON BEGIN -------------------
//$<modify> Evan 03.07.2010
//$<reason> Facility id change into Template id.
//rc = dw_priv.retrieve(ii_facil,il_clin_id ) //corrected variable 01-09-01 maha
//rc = dw_priv.retrieve(ii_template_id, il_clin_id)
rc = dw_priv.retrieve(ii_template_id, ll_cid)   //Start Code Change ----09.26.2011 #V12 maha - changed to array variable
//------------------- APPEON END ---------------------

pc = ids_prac_privs.retrieve( il_prac,il_clin_id,ii_facil )
//st_2.visible = true

if rc > 0 and pc > 0 then
	for r = 1 to rc //for each procedure see if the prac has granted priv and  
		ll_proced = dw_priv.getitemnumber(r,"priv_core_procd_procd_id")
		p = ids_prac_privs.find("pd_priv_list_procd_id = " + string(ll_proced),1,pc)
		if p > 0 then
			dw_priv.setitem(r,"selected",1)
		end if
	next
end if

//End Code Change---02.27.2008
end event

event constructor;//integer li_row
//dw_clin.settransobject(sqlca)
//dw_clin.retrieve(gi_facil_change)
//dw_clin.InsertRow( 0 )
//
//
//DataWindowChild dwchild
//
//This.GetChild( "clinical_area_description", dwchild )
//
//
//li_row = dwchild.InsertRow( 1 )
//dwchild.scrolltorow(1)
//dwchild.SetItem( 1, "clinical_area_description", "All" )
//dwchild.SetItem( 1, "clinical_area_id", 0 )
il_clin_id = 0
end event

type cb_ok from commandbutton within w_clin_area_select
integer x = 2615
integer y = 1924
integer width = 306
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;g_str_clin_info lstr_priv
integer li_left
integer li_filtered
integer li_count
integer li_prac_count
integer li_checked
integer i
integer f
integer nr //maha 03.04.2015
datetime ldt_null
long ll_procdid
long ll_recno
long ll_apptid
string f_filter

//Start Code Change ----09.26.2011 #V12 maha
if il_stat = 0 then
	il_stat = long(gnv_data.of_getitem('code_lookup','lookup_code',"upper(lookup_name) = 'PRIVILEGE STATUS' and upper(code) = 'REQST'"))
end if

IF il_stat = 0 THEN
	MessageBox("Select Error", "Select a Status." )
	dw_clin.enabled = true
	dw_clin.SetFocus( )
	Return 0
END IF

IF il_clin_id = 0 THEN
	MessageBox("Select Error", "You must first select a Clinical Area." )
	dw_clin.SetFocus( )
	Return 0
END IF
debugbreak()
f_filter = "selected = 1"

dw_priv.setfilter(f_filter)  
dw_priv.filter ()
li_count = dw_priv.rowcount()
lstr_priv.row_count = li_count

if ib_rollover = true then
	setnull(ldt_null)
	li_prac_count = ids_prac_privs.rowcount()
	for i  = 1 to li_count  //copy the selected privileges
		ll_procdid = dw_priv.getitemnumber(i,"priv_core_procd_procd_id")
		f = ids_prac_privs.find( "pd_priv_list_procd_id = " + string(ll_procdid), 1, li_prac_count)
		//Start Code Change ----03.04.2015 #V15 maha - modified to pick up new privileges
		if f = 0 then 
			nr = ids_prac_privs.insertrow(0)
			//set values for not copied records
			ids_prac_privs.setitem(nr,"pd_priv_list_facility_id",ii_facil)
			ids_prac_privs.setitem(nr,"pd_priv_list_prac_id",il_prac) //Start Code Change ----03.22.2010 #V10 maha - changed prac_variable
			ids_prac_privs.setitem(nr,"pd_priv_list_clinical_area_id",il_clin_id)
			ids_prac_privs.setitem(nr,"pd_priv_list_priv_core_id",dw_priv.GetItemnumber(i , 'priv_core_priv_core_id'))
			ids_prac_privs.setitem(nr,"pd_priv_list_procd_id",ll_procdid)
			ids_prac_privs.setitem(nr,"pd_priv_list_active_status",1)
			ids_prac_privs.setitem(nr,"pd_priv_list_priv_text", dw_priv.GetItemString(i , 'priv_core_procd_core_procd_description'))
			ids_prac_privs.setitem(nr,"pd_priv_list_enter_date",datetime(today(),now()))
			ids_prac_privs.setitem(nr,"pd_priv_list_procd_lookup_id", dw_priv.GetItemnumber(i , 'procd_lookup_id'))
		else
			ids_prac_privs.rowscopy( f, f , primary!,  ids_prac_privs, 10000,primary!)
		end if
		 //Start Code Change ----03.04.2015
	next
	
	gnv_appeondb.of_startqueue()
	SELECT Max( pd_priv_list.rec_id ) 	INTO :ll_recno  FROM pd_priv_list;
	Select rec_id into :ll_apptid  from pd_affil_stat where prac_id = :il_prac  and parent_facility_id = :ii_facil  and active_status in (1,4);
	gnv_appeondb.of_commitqueue()
	
	for i = li_prac_count + 1 to ids_prac_privs.rowcount() //for the newlyadded/copied rows
		ll_recno++
		ids_prac_privs.setitem( i,"pd_priv_list_rec_id", ll_recno )
		ids_prac_privs.setitem( i,"pd_priv_list_start_date", ldt_null )
		ids_prac_privs.setitem( i,"pd_priv_list_end_date", ldt_null )
		ids_prac_privs.setitem( i,"pd_priv_list_status_code", il_stat )
		ids_prac_privs.setitem( i,"pd_priv_list_ir_code", 2 )  //Start Code Change ----03.02.2012 #V12 maha - corrected from R
		ids_prac_privs.setitem( i,"pd_priv_list_appt_stat_id", ll_apptid )  //Start Code Change ----03.02.2012 #V12 maha - corrected from ir_code field
	next
	
	ids_prac_privs.update()
	ii_close = 1
	close (parent)
else  //from prac privileges add
 
	for i  = 1 to li_count
		lstr_priv.priv_ids[i] = dw_priv.getitemnumber(i,"priv_core_procd_procd_id")
		lstr_priv.clin_id = dw_priv.getitemnumber(i,"priv_core_clinical_area_id")
	next
	lstr_priv.appnt = ii_appstat
	lstr_priv.stat = il_stat
	//messagebox("end",em_e.text)
	if em_s.text <> "" then
		lstr_priv.dstart = date(em_s.text)
	end if
	if em_e.text <> "" then
		lstr_priv.dend = date(em_e.text)
	end if
	//messagebox("stat",lstr_priv.appnt)
	ii_close = 1
	CloseWithReturn( Parent, lstr_priv )
end if

end event

type cb_cancel from commandbutton within w_clin_area_select
integer x = 2939
integer y = 1924
integer width = 306
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;g_str_clin_info lstr_priv
ii_close = 1
Closewithreturn(parent,lstr_priv)
//Close(parent)
end event

type st_1 from statictext within w_clin_area_select
integer x = 46
integer y = 64
integer width = 699
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Select a Clinical Area to add."
boolean focusrectangle = false
end type

type dw_priv from datawindow within w_clin_area_select
integer x = 18
integer y = 272
integer width = 3223
integer height = 1632
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_priv_add_select"
boolean vscrollbar = true
end type

event constructor;this.settransobject( sqlca)
end event

type cb_all from commandbutton within w_clin_area_select
integer x = 23
integer y = 1924
integer width = 306
integer height = 84
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select All"
end type

event clicked;//Start Code Change ---- 10.03.2006 #661 maha added unselect all code
long li_rowcnt
long li_row
integer li_val

if dw_priv.rowcount() = 0 then return

 li_rowcnt = dw_priv.rowcount()
 
if this.text = "&Select All" then
	li_val = 1
	this.text = "&Unselect All"
else //deselect
	li_val = 0
	this.text = "&Select All"
end if

//Start Code Change ----09.26.2011 #V12 maha - modified code for additional condition
for li_row = 1 to li_rowcnt
	choose case li_val
		case 1
			if dw_priv.getitemnumber(li_row,"opt_out") = 1 then //if an opt out record do not select.
				dw_priv.setitem(li_row, "selected" ,0)
			else
				dw_priv.setitem(li_row, "selected" ,li_val)
			end if
			
		case else //0
			dw_priv.setitem(li_row, "selected" ,li_val)
	end choose
	
next

////--------------------------- APPEON BEGIN ---------------------------
////$<modify> 01/11/2008 By: Ken.Guo
////$<reason> For Performance
///*
//for li_row = 1 to li_rowcnt
//	dw_priv.setitem(li_row, "selected" ,li_val)
//next
//*/
//Integer li_value0[],li_value1[]
//For li_row = 1 To li_rowcnt
//	li_value0[li_row] = 0
//	li_value1[li_row] = 1
//Next
//If li_val = 1 Then
//	dw_priv.object.selected[1,li_rowcnt] = li_value1
//Else 
//	dw_priv.object.selected[1,li_rowcnt] = li_value0	
//End If
////---------------------------- APPEON END ----------------------------
//Start Code Change ----09.26.2011 

end event

type rb_ini from radiobutton within w_clin_area_select
integer x = 1134
integer y = 128
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Initial"
end type

event clicked;ii_appstat = 1//"Inital"
end event

type rb_reap from radiobutton within w_clin_area_select
integer x = 1408
integer y = 128
integer width = 297
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Reapply"
boolean checked = true
end type

event clicked;ii_appstat = 2  //"Renew"
end event

type dw_status from datawindow within w_clin_area_select
integer x = 1797
integer y = 124
integer width = 663
integer height = 76
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_dddw_priv_status"
boolean border = false
boolean livescroll = true
end type

event itemchanged;il_stat = long(data)
end event

type st_3 from statictext within w_clin_area_select
integer x = 1797
integer y = 68
integer width = 352
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Select Status:"
boolean focusrectangle = false
end type

type em_s from editmask within w_clin_area_select
integer x = 2496
integer y = 124
integer width = 325
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
end type

type em_e from editmask within w_clin_area_select
integer x = 2853
integer y = 124
integer width = 325
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
end type

type st_4 from statictext within w_clin_area_select
integer x = 2491
integer y = 68
integer width = 133
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Start:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_clin_area_select
integer x = 2848
integer y = 68
integer width = 114
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "End:"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_clin_area_select
integer x = 23
integer y = 4
integer width = 3223
integer height = 252
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
end type

