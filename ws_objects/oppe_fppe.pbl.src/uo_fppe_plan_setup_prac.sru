$PBExportHeader$uo_fppe_plan_setup_prac.sru
forward
global type uo_fppe_plan_setup_prac from userobject
end type
type dw_clin from datawindow within uo_fppe_plan_setup_prac
end type
type st_view from statictext within uo_fppe_plan_setup_prac
end type
type st_temp from statictext within uo_fppe_plan_setup_prac
end type
type dw_templates from datawindow within uo_fppe_plan_setup_prac
end type
type cb_delete from commandbutton within uo_fppe_plan_setup_prac
end type
type cb_add from commandbutton within uo_fppe_plan_setup_prac
end type
type dw_view from datawindow within uo_fppe_plan_setup_prac
end type
type cb_close from commandbutton within uo_fppe_plan_setup_prac
end type
type cb_save from commandbutton within uo_fppe_plan_setup_prac
end type
type cbx_ext from checkbox within uo_fppe_plan_setup_prac
end type
type cbx_retro from checkbox within uo_fppe_plan_setup_prac
end type
type cbx_con from checkbox within uo_fppe_plan_setup_prac
end type
type cbx_pro from checkbox within uo_fppe_plan_setup_prac
end type
type gb_1 from groupbox within uo_fppe_plan_setup_prac
end type
type dw_detail from datawindow within uo_fppe_plan_setup_prac
end type
type cb_reset from commandbutton within uo_fppe_plan_setup_prac
end type
type cb_plan from commandbutton within uo_fppe_plan_setup_prac
end type
type dw_temp from datawindow within uo_fppe_plan_setup_prac
end type
end forward

global type uo_fppe_plan_setup_prac from userobject
integer width = 4553
integer height = 2508
long backcolor = 33551856
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_clin dw_clin
st_view st_view
st_temp st_temp
dw_templates dw_templates
cb_delete cb_delete
cb_add cb_add
dw_view dw_view
cb_close cb_close
cb_save cb_save
cbx_ext cbx_ext
cbx_retro cbx_retro
cbx_con cbx_con
cbx_pro cbx_pro
gb_1 gb_1
dw_detail dw_detail
cb_reset cb_reset
cb_plan cb_plan
dw_temp dw_temp
end type
global uo_fppe_plan_setup_prac uo_fppe_plan_setup_prac

type variables
string is_procd
string is_from
long il_fppe_id
boolean ib_new = false //add by stephen 04.19.2012  -Alpha id 3030 - Setting up Data for Electronic Committee Meetings, FPPE template
end variables

forward prototypes
public function integer of_get_hdr (long al_fppe_id)
public function integer of_hide_boxes (boolean ai_true)
public function string of_set_eval_data ()
public function integer of_set_plan ()
public function integer of_setup (string as_for)
end prototypes

public function integer of_get_hdr (long al_fppe_id);//called before of_setup on open event
il_fppe_id = al_fppe_id
//string s
//long ll_prac
//long ll_facil
//
//dw_detail.retrieve(al_fppe_id)
//
//s = dw_detail.getitemstring(1,"duration")
//if len (s) > 0 then
//	of_hide_boxes(true)
//else
//	of_hide_boxes(true)
//end if
//
//if is_from = "PRAC" then
//	ll_prac = dw_detail.getitemnumber(1,"prac_id")
//	ll_facil = dw_detail.getitemnumber(1,"facility_id")
//	
//	dw_view.settransobject(sqlca)
//	dw_view.retrieve(ll_prac,ll_facil)
//end if

return 1
end function

public function integer of_hide_boxes (boolean ai_true);
if ai_true = true then
	dw_detail.bringtotop = ai_true
	gb_1.visible = false
else
	gb_1.bringtotop = ai_true
	dw_detail.bringtotop = ai_true
	gb_1.visible = true
	cbx_con.bringtotop = true
	cbx_ext.bringtotop = true
	cbx_pro.bringtotop = true
	cbx_retro.bringtotop = true
end if

cb_reset.bringtotop = true

return 1
end function

public function string of_set_eval_data ();//Start Code Change ----11.22.2011 #V12 maha - created
string ls_e_type
string ls_type[]

string ls_dur
string ls_meth
integer t = 0
integer r


if gb_1.visible = true then
	if cbx_pro.checked then 
		t++
		ls_type[t] = "Prospective"
	end if
	
	if cbx_con.checked then 
		t++
		ls_type[t] = "Concurrent"
	end if
	
	if cbx_retro.checked then 
		t++
		ls_type[t] = "Retrospective"
	end if
	
	if cbx_ext.checked then 
		t++
		ls_type[t] = "External"
	end if
	
	for t = 1 to upperbound(ls_type)
		if t > 1 then ls_e_type += " and/or "
		ls_e_type = ls_e_type + ls_type[t]
	next
	dw_detail.setitem(1,"eval_type", ls_e_type)
else
	
end if

ls_e_type = dw_detail.getitemstring(1,"eval_type") //Start Code Change ----05.02.2012 #V12 maha
	
//if t = 1 then
ls_e_type = ls_e_type + " "  //Start Code Change ----01.12.2012 #V12 maha

ls_dur = dw_detail.getitemstring(1,"duration")
ls_meth = dw_detail.getitemstring(1,"eval_crit")

if len( ls_dur) > 0 then
	ls_e_type = ls_e_type + " " + ls_meth + " for  " + ls_dur 
end if
	

return ls_e_type



end function

public function integer of_set_plan ();string ls_text

dw_detail.accepttext() //Start Code Change ----5.01.2012 #V12 maha
ls_text = dw_detail.getitemstring(dw_detail.getrow(),"eval_plan")
if isnull(ls_text) then ls_text = ""
if len(ls_text) > 0 then ls_text+= "~r" 
ls_text = ls_text + is_procd
dw_detail.setitem(dw_detail.getrow(), "eval_plan" , ls_text)

return 1
end function

public function integer of_setup (string as_for);string s
long ll_prac
long ll_facil
datawindowchild dwchild

is_from = as_for

if as_for  = "PRAC" then
	dw_detail.retrieve(il_fppe_id)

	cb_add.visible = false
	cb_delete.visible = false
	ll_prac = dw_detail.getitemnumber(1,"prac_id")
	ll_facil = dw_detail.getitemnumber(1,"facility_id")
	dw_view.settransobject(sqlca)
	dw_view.retrieve(ll_prac,ll_facil)
	s = dw_detail.getitemstring(1,"duration")
	if len (s) > 0 then
		of_hide_boxes(true)
	else
		of_hide_boxes(true)
	end if
else //Temp
	cb_plan.visible = false
	dw_detail.dataobject = "d_fppe_plan_detail_temp"
	dw_view.dataobject = "d_priv_procedure_4_clin_area_fppe"
	st_temp.visible = true
	st_view.visible = true
	dw_templates.visible = true
	dw_templates.settransobject(sqlca)
	dw_templates.retrieve()
	dw_templates.insertrow(1)
	dw_templates.getchild( "fppe_temp_id", dwchild)
	dwchild.insertrow(1)
	dwchild.setitem(1,"fppe_temp_id", 0)
	dwchild.setitem(1,"temp_name", "")

	dw_view.settransobject(sqlca)
	dw_detail.settransobject(sqlca)
	
	dw_clin.settransobject(sqlca)
	dw_clin.retrieve()
	dw_clin.insertrow(1)
	dw_clin.getchild( "lookup_code", dwchild)
	dwchild.insertrow(1)
	dwchild.setitem(1,"lookup_code", 0)
	dwchild.setitem(1,"description", "")
	dw_clin.visible = true
	
	
end if



return 1


end function

on uo_fppe_plan_setup_prac.create
this.dw_clin=create dw_clin
this.st_view=create st_view
this.st_temp=create st_temp
this.dw_templates=create dw_templates
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.dw_view=create dw_view
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cbx_ext=create cbx_ext
this.cbx_retro=create cbx_retro
this.cbx_con=create cbx_con
this.cbx_pro=create cbx_pro
this.gb_1=create gb_1
this.dw_detail=create dw_detail
this.cb_reset=create cb_reset
this.cb_plan=create cb_plan
this.dw_temp=create dw_temp
this.Control[]={this.dw_clin,&
this.st_view,&
this.st_temp,&
this.dw_templates,&
this.cb_delete,&
this.cb_add,&
this.dw_view,&
this.cb_close,&
this.cb_save,&
this.cbx_ext,&
this.cbx_retro,&
this.cbx_con,&
this.cbx_pro,&
this.gb_1,&
this.dw_detail,&
this.cb_reset,&
this.cb_plan,&
this.dw_temp}
end on

on uo_fppe_plan_setup_prac.destroy
destroy(this.dw_clin)
destroy(this.st_view)
destroy(this.st_temp)
destroy(this.dw_templates)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.dw_view)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cbx_ext)
destroy(this.cbx_retro)
destroy(this.cbx_con)
destroy(this.cbx_pro)
destroy(this.gb_1)
destroy(this.dw_detail)
destroy(this.cb_reset)
destroy(this.cb_plan)
destroy(this.dw_temp)
end on

type dw_clin from datawindow within uo_fppe_plan_setup_prac
boolean visible = false
integer x = 2683
integer y = 72
integer width = 997
integer height = 96
integer taborder = 70
string title = "none"
string dataobject = "d_code_lookup_clin_area"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
this.insertrow(1)
end event

event itemchanged;long ll_code

ll_code = long(data)

dw_view.retrieve(ll_code)
end event

type st_view from statictext within uo_fppe_plan_setup_prac
boolean visible = false
integer x = 2697
integer y = 12
integer width = 571
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "View procedures for:"
boolean focusrectangle = false
end type

type st_temp from statictext within uo_fppe_plan_setup_prac
boolean visible = false
integer x = 1385
integer y = 12
integer width = 457
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Template:"
boolean focusrectangle = false
end type

type dw_templates from datawindow within uo_fppe_plan_setup_prac
boolean visible = false
integer x = 1390
integer y = 68
integer width = 1262
integer height = 92
integer taborder = 70
string title = "none"
string dataobject = "d_fppe_template"
boolean border = false
end type

event clicked;long r

r = this.getclickedrow()

this.setrow(r)
end event

event itemchanged;long ll_id



ll_id = long(data)
il_fppe_id = ll_id
dw_detail.retrieve(ll_id)

//of_get_hdr( ll_id)
end event

type cb_delete from commandbutton within uo_fppe_plan_setup_prac
integer x = 878
integer y = 68
integer width = 402
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;integer li_ans
datawindowchild dwchild

li_ans = messagebox("Delete Template","Are you sure you wish to delete this template?",question!,yesno!,2)

if li_ans = 1 then
	dw_detail.deleterow(0)
	dw_detail.update()
	dw_templates.getchild( "fppe_temp_id", dwchild)
	dwchild.settransobject(sqlca)
	dwchild.retrieve()
	//dw_templates.retrieve()
end if


end event

type cb_add from commandbutton within uo_fppe_plan_setup_prac
integer x = 448
integer y = 68
integer width = 402
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;//-------------------APPEON BEGIN --------------------------
//<$>Modified: long.zhang 04.11.2012
//<$>Reason:Fix Bug Alpha Test 2991 Cannot add a new FPPE Template
//cb_save.triggerevent(clicked!)
//dw_detail.insertrow(1)
ib_new = true //add by stephen 04.19.2012 error for add a new FPPE Template-bug 3030 
cb_save.triggerevent(clicked!)
dw_detail.reset( )
dw_detail.insertrow(1)
dw_templates.scrolltorow(1)
//------------------APPEON END------------------------------

end event

type dw_view from datawindow within uo_fppe_plan_setup_prac
integer x = 2167
integer y = 168
integer width = 2359
integer height = 2284
integer taborder = 20
string dragicon = "droparrow.ico"
string title = "none"
string dataobject = "d_priv_prac_for_fppe"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;integer r

r = this.getclickedrow()

if r > 0 then
	this.setrow(r)
end if

Drag(begin!)
end event

event rowfocuschanged;this.selectrow(0,false)
this.selectrow(currentrow,true)

is_procd = this.getitemstring(currentrow,"priv_core_procd_procd_name")
end event

event doubleclicked;of_set_plan()
end event

type cb_close from commandbutton within uo_fppe_plan_setup_prac
integer x = 4073
integer y = 68
integer width = 402
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(w_fppe_prac_plan)
end event

type cb_save from commandbutton within uo_fppe_plan_setup_prac
integer x = 27
integer y = 68
integer width = 402
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;//Start Code Change ----11.22.2011 #V12 maha - created
long ll_id
string ls_e_type
string ls_type[]
string ls_null[]
string ls_dur
string ls_meth
integer t = 0
integer r
boolean lb_new = false
datawindowchild dwchild
string    ls_temp_name

//if is_from = "PLAN" then  //Start Code Change ----04.09.2012 #V12 maha
//	if isnull(dw_detail.getitemnumber(1,"fppe_temp_id") ) then
//		lb_new = true
//		select max ( fppe_temp_id) into :ll_id from fppe_template;
//		if isnull( ll_id) then ll_id = 0
//		ll_id++
//		dw_detail.setitem(1,"fppe_temp_id", ll_id)	
//	else
//		ll_id = dw_detail.getitemnumber(1,"fppe_temp_id")
//	end if
//end if
//pd_oppe_hdr_id

//----------------------------APPEON BEGIN---------------------
//<$>add long.zhang 04.11.2012
//<$> Reason: Fixed bug Alpha Test 2991 Cannot add a new FPPE Template
if is_from = "PLAN" then
	if dw_detail.rowcount( ) = 0 then return 0
	
	ls_temp_name = dw_detail.getitemstring(1,"temp_name")  //add by stephen 04.19.2012 error for add a new FPPE Template-bug 3030 
	if isnull(ls_temp_name) or ls_temp_name = '' then return 0 //add by stephen 04.19.2012 -bug 3030 
	
	if isnull(dw_detail.getitemnumber(1,"fppe_temp_id") ) then
		lb_new = true
		select max ( fppe_temp_id) into :ll_id from fppe_template;
		if isnull( ll_id) then ll_id = 0
		ll_id++
		dw_detail.setitem(1,"fppe_temp_id", ll_id)	
	else
		ll_id = dw_detail.getitemnumber(1,"fppe_temp_id")
	end if
end if
//----------------------------APPEON END-----------------------

if len(dw_detail.getitemstring(1,"eval_plan")) = 0 or isnull(dw_detail.getitemstring(1,"eval_plan")) then
	ls_e_type = of_set_eval_data( )
	dw_detail.setitem(1,"eval_plan", ls_e_type)
end if

dw_detail.update()


if ib_new then lb_new = ib_new //add by stephen 04.19.2012 error for add a new FPPE Template-bug 3030 
if lb_new then
	of_hide_boxes(false)
	//--------------APPEON BEGIN----------------
	//<$>Modified long.zhang 04.11.2012
	//<$>Reason display the correct template name
	
	//	dw_templates.retrieve()
	//	r = dw_templates.find( "fppe_temp_id = " + string(ll_id), 1 , 10000)
	//	dw_templates.setrow(r)
	dw_templates.getchild( "fppe_temp_id", dwchild)
	dwchild.settransobject( sqlca)
	dwchild.retrieve( )
	
	dwchild.insertrow( 1)
	dwchild.setitem(1,"fppe_temp_id", 0)
	dwchild.setitem(1,"temp_name", "")
	
	if dwchild.find("fppe_temp_id = " + string(ll_id), 1 , 10000) >0 then
		r = dw_templates.insertrow( 0)
		dw_templates.setitem( r, 'fppe_temp_id',ll_id)
		dw_templates.scrolltorow( r)
		dw_templates.selectrow( 0,false)
		dw_templates.selectrow( r,true)
	end if
	//-------------APPEON END-------------------

//	dw_templates.getchild( "fppe_temp_id", dwchild)
//	r = 
//	dwchild.setitem(1,"fppe_temp_id", 0)
//	dwchild.setitem(1,"temp_name", "")
else
	of_hide_boxes(true)
end if

ib_new = false //add by stephen 04.19.2012 error for add a new FPPE Template-bug 3030 
	














end event

type cbx_ext from checkbox within uo_fppe_plan_setup_prac
integer x = 1614
integer y = 740
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "External"
end type

type cbx_retro from checkbox within uo_fppe_plan_setup_prac
integer x = 1029
integer y = 740
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Retrospective"
end type

type cbx_con from checkbox within uo_fppe_plan_setup_prac
integer x = 599
integer y = 744
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Concurrent"
end type

type cbx_pro from checkbox within uo_fppe_plan_setup_prac
integer x = 137
integer y = 744
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Prospective"
end type

type gb_1 from groupbox within uo_fppe_plan_setup_prac
integer x = 32
integer y = 672
integer width = 2025
integer height = 164
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Type of Evaluation (select all that apply)"
end type

type dw_detail from datawindow within uo_fppe_plan_setup_prac
integer y = 180
integer width = 2149
integer height = 2276
integer taborder = 10
string title = "none"
string dataobject = "d_fppe_prac_detail_plan"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

event buttonclicked;long ll_prac_id
string ls_full_name
string ls_meth
string ls_text
gs_search lstr_search
gs_batch_search lstr_search_ret
datawindow ldw_data

this.accepttext() //Start Code Change ----05.02.2012 #V12 maha 

if dw_detail.GetRow() < 1 then Return -1

if dwo.name = "b_proctor" then
	// Search practitioner
	lstr_search.stran_transaction = SQLCA
	lstr_search.ls_open_for = "PRIVILEGE"
	OpenWithParm(w_extended_search_new , lstr_search)
	lstr_search_ret = Message.PowerObjectParm
	if IsNull(lstr_search_ret) then Return -1
	if not IsValid(lstr_search_ret) then Return -1
	if UpperBound(lstr_search_ret.li_prac_id) < 1 then Return -1
	
	ll_prac_id = lstr_search_ret.li_prac_id[1]
	select full_name into :ls_full_name from v_full_name where prac_id = :ll_prac_id;
	
	// Set items from selection
	dw_detail.SetItem( 1, "proctor", ls_full_name)
elseif dwo.name = "b_method" then
	open(w_fppe_get_method)
	ls_meth = message.stringparm
	if ls_meth = "C" then
		return 1
	else
		dw_detail.SetItem( 1, "eval_crit", ls_meth)
	end if
	
elseif 	dwo.name = "b_data" then
	ls_meth = of_set_eval_data( )
	ls_text = this.getitemstring(row,"eval_plan")
	if isnull(ls_text) then ls_text = "" //Start Code Change ----05.02.2012 #V12 maha
	if len(ls_text) > 0 then ls_text+= "~r" 
	ls_text = ls_text +  ls_meth
	this.setitem(row, "eval_plan" , ls_text)
end if


Return 1
end event

event dragdrop;string ls_text

if dwo.name = "eval_plan" then
	of_set_plan()
end if
end event

type cb_reset from commandbutton within uo_fppe_plan_setup_prac
integer x = 1211
integer y = 660
integer width = 210
integer height = 72
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reset"
end type

event clicked;string ls_type[]
string ls_e_type
integer t

if gb_1.visible = true then
	if cbx_pro.checked then 
		t++
		ls_type[t] = "Prospective"
	end if
	
	if cbx_con.checked then 
		t++
		ls_type[t] = "Concurrent"
	end if
	
	if cbx_retro.checked then 
		t++
		ls_type[t] = "Retrospective"
	end if
	
	if cbx_ext.checked then 
		t++
		ls_type[t] = "External"
	end if
	
	for t = 1 to upperbound(ls_type)
		if t > 1 then ls_e_type += " and/or "
		ls_e_type = ls_e_type + ls_type[t]
	next
	dw_detail.setitem(1,"eval_type", ls_e_type)
	of_hide_boxes( true )
else
	of_hide_boxes( false )
end if


end event

type cb_plan from commandbutton within uo_fppe_plan_setup_prac
integer x = 32
integer y = 64
integer width = 663
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Set from Plan Template"
end type

event clicked;long ll_temp
long ll_facil
integer res


open(w_get_fppe_template)
debugbreak()
ll_temp = message.doubleparm

if ll_temp = 0 then return

If len(dw_detail.getitemstring(1,"eval_plan") ) > 0 then
	res = messagebox("Plan","Do you wish to overwrite the existing plan data?",question!,yesno!,1)	
	//messagebox("res",res)
	if res = 2 then return
	
End if


res = dw_temp.retrieve(ll_temp)

if res < 1 then 
	return
else
	dw_detail.setitem(1,"eval_type", dw_temp.getitemstring( 1,"eval_type"))
	dw_detail.setitem(1,"eval_crit", dw_temp.getitemstring( 1,"eval_crit"))
	dw_detail.setitem(1,"duration", dw_temp.getitemstring( 1,"duration"))
	dw_detail.setitem(1,"eval_plan", dw_temp.getitemstring( 1,"eval_plan"))
	
	dw_detail.update()
	of_hide_boxes( true)
end if	









end event

type dw_temp from datawindow within uo_fppe_plan_setup_prac
boolean visible = false
integer x = 119
integer y = 4
integer width = 151
integer height = 76
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_fppe_plan_detail_temp"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

