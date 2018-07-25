$PBExportHeader$uo_fppe_plan_setup.sru
forward
global type uo_fppe_plan_setup from userobject
end type
type st_1 from statictext within uo_fppe_plan_setup
end type
type dw_clin from datawindow within uo_fppe_plan_setup
end type
type dw_procd from datawindow within uo_fppe_plan_setup
end type
type dw_browse from datawindow within uo_fppe_plan_setup
end type
type cb_copy from commandbutton within uo_fppe_plan_setup
end type
type cb_delete from commandbutton within uo_fppe_plan_setup
end type
type cb_add from commandbutton within uo_fppe_plan_setup
end type
type cb_save from commandbutton within uo_fppe_plan_setup
end type
type cb_3 from commandbutton within uo_fppe_plan_setup
end type
type cb_1 from commandbutton within uo_fppe_plan_setup
end type
type cb_mod from commandbutton within uo_fppe_plan_setup
end type
type dw_crit from datawindow within uo_fppe_plan_setup
end type
type cbx_ext from checkbox within uo_fppe_plan_setup
end type
type cbx_retro from checkbox within uo_fppe_plan_setup
end type
type cbx_con from checkbox within uo_fppe_plan_setup
end type
type cbx_pro from checkbox within uo_fppe_plan_setup
end type
type gb_1 from groupbox within uo_fppe_plan_setup
end type
type gb_3 from groupbox within uo_fppe_plan_setup
end type
type dw_detail from datawindow within uo_fppe_plan_setup
end type
end forward

global type uo_fppe_plan_setup from userobject
integer width = 4690
integer height = 2992
long backcolor = 33551856
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_1 st_1
dw_clin dw_clin
dw_procd dw_procd
dw_browse dw_browse
cb_copy cb_copy
cb_delete cb_delete
cb_add cb_add
cb_save cb_save
cb_3 cb_3
cb_1 cb_1
cb_mod cb_mod
dw_crit dw_crit
cbx_ext cbx_ext
cbx_retro cbx_retro
cbx_con cbx_con
cbx_pro cbx_pro
gb_1 gb_1
gb_3 gb_3
dw_detail dw_detail
end type
global uo_fppe_plan_setup uo_fppe_plan_setup

forward prototypes
public function integer of_get_hdr (long al_fppe_id)
public function integer of_hide_boxes (boolean ai_true)
public function integer of_get_browse ()
end prototypes

public function integer of_get_hdr (long al_fppe_id);string s
integer r

r = dw_detail.retrieve(al_fppe_id)
dw_crit.retrieve(al_fppe_id)

if r > 0 then
	s = dw_detail.getitemstring(1,"eval_plan")
	if len (s) > 0 then
		of_hide_boxes(true)
	else
		of_hide_boxes(true)
	end if
else
	dw_detail.insertrow(1)
end if


return 1
end function

public function integer of_hide_boxes (boolean ai_true);

dw_detail.bringtotop = ai_true
//gb_1.visible = ai_true
//gb_3.visible = ai_true
cb_mod.enabled = ai_true


return 1
end function

public function integer of_get_browse ();long ll_fppe

if dw_browse.retrieve() > 1 then
	ll_fppe = dw_browse.getitemnumber(1,"fppe_temp_id")
else
	ll_fppe = 0
end if

of_get_hdr( ll_fppe)

return 1
end function

on uo_fppe_plan_setup.create
this.st_1=create st_1
this.dw_clin=create dw_clin
this.dw_procd=create dw_procd
this.dw_browse=create dw_browse
this.cb_copy=create cb_copy
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.cb_save=create cb_save
this.cb_3=create cb_3
this.cb_1=create cb_1
this.cb_mod=create cb_mod
this.dw_crit=create dw_crit
this.cbx_ext=create cbx_ext
this.cbx_retro=create cbx_retro
this.cbx_con=create cbx_con
this.cbx_pro=create cbx_pro
this.gb_1=create gb_1
this.gb_3=create gb_3
this.dw_detail=create dw_detail
this.Control[]={this.st_1,&
this.dw_clin,&
this.dw_procd,&
this.dw_browse,&
this.cb_copy,&
this.cb_delete,&
this.cb_add,&
this.cb_save,&
this.cb_3,&
this.cb_1,&
this.cb_mod,&
this.dw_crit,&
this.cbx_ext,&
this.cbx_retro,&
this.cbx_con,&
this.cbx_pro,&
this.gb_1,&
this.gb_3,&
this.dw_detail}
end on

on uo_fppe_plan_setup.destroy
destroy(this.st_1)
destroy(this.dw_clin)
destroy(this.dw_procd)
destroy(this.dw_browse)
destroy(this.cb_copy)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.cb_save)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.cb_mod)
destroy(this.dw_crit)
destroy(this.cbx_ext)
destroy(this.cbx_retro)
destroy(this.cbx_con)
destroy(this.cbx_pro)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.dw_detail)
end on

type st_1 from statictext within uo_fppe_plan_setup
integer x = 2441
integer y = 56
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
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_clin from datawindow within uo_fppe_plan_setup
integer x = 3031
integer y = 48
integer width = 997
integer height = 96
integer taborder = 100
string title = "none"
string dataobject = "d_dddw_clin_area"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
this.insertrow(1)
end event

event itemchanged;long ll_code

ll_code = long(data)

dw_procd.retrieve(ll_code)
end event

type dw_procd from datawindow within uo_fppe_plan_setup
integer x = 2213
integer y = 164
integer width = 2240
integer height = 684
integer taborder = 20
string title = "none"
string dataobject = "d_priv_procedure_4_clin_area_fppe"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

type dw_browse from datawindow within uo_fppe_plan_setup
integer x = 37
integer y = 160
integer width = 2144
integer height = 692
integer taborder = 10
string title = "none"
string dataobject = "d_fppe_plan_browse"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;long r

r = this.getclickedrow()

this.setrow(r)
end event

event constructor;this.settransobject(sqlca)

end event

event rowfocuschanged;long ll_id

this.selectrow(0, false)
this.selectrow( currentrow, true)

ll_id = this.getitemnumber(currentrow,"fppe_temp_id")

of_get_hdr( ll_id)









end event

type cb_copy from commandbutton within uo_fppe_plan_setup
integer x = 1362
integer y = 36
integer width = 402
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Copy"
end type

event clicked;long ll_null


cb_save.triggerevent(clicked!)

setnull(ll_null)

dw_detail.rowscopy( 1, 1, primary!,dw_detail, 1, primary!)

dw_detail.setitem(1,"fppe_temp_id",ll_null)
dw_detail.setitem(1, "temp_name", "")
end event

type cb_delete from commandbutton within uo_fppe_plan_setup
integer x = 494
integer y = 36
integer width = 402
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

type cb_add from commandbutton within uo_fppe_plan_setup
integer x = 64
integer y = 36
integer width = 402
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;cb_save.triggerevent(clicked!)
dw_detail.insertrow(1)
end event

type cb_save from commandbutton within uo_fppe_plan_setup
integer x = 923
integer y = 36
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
string ls_e_type
string ls_type[]
string ls_null[]
string ls_dur
string ls_meth
integer t = 0
integer r
integer li_find
long ll_id


debugbreak()
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
 
//if t = 1 then
ls_e_type = ls_e_type + " "  //Start Code Change ----01.12.2012 #V12 maha

dw_detail.setitem(1,"eval_type", ls_e_type)

ls_dur = dw_detail.getitemstring(1,"eval_dur")

//get criteria
t = 0
ls_type = ls_null

for r = 1 to dw_crit.rowcount()
	if dw_crit.getitemnumber(r,"selected") = 1 then
		t++
		ls_type[t] = dw_crit.getitemstring(r,"description") 
	end if
next

if t > 0 then
	for t = 1 to upperbound(ls_type)
		if t > 1 then ls_meth += " and/or "
		ls_meth = ls_meth + ls_type[t]
	next
end if

dw_detail.setitem(1,"eval_crit", ls_meth)

if len( ls_dur) > 0 then
	ls_e_type = ls_e_type + " " + ls_meth + " for the period of " + ls_dur 
end if
	
//messagebox("Eval type",ls_e_type )
dw_detail.setitem(1,"eval_plan", ls_e_type)

if isnull(dw_detail.getitemnumber(1,"fppe_temp_id") ) then
	select max ( fppe_temp_id) into :ll_id from fppe_template;
	if isnull( ll_id) then ll_id = 0
	ll_id++
	dw_detail.setitem(1,"fppe_temp_id", ll_id)	
else
	ll_id = dw_detail.getitemnumber(1,"fppe_temp_id")
end if

dw_detail.update()

of_hide_boxes(true)

dw_browse.retrieve()

li_find = dw_browse.find( "fppe_temp_id =" + string(ll_id), 1, dw_browse.rowcount())

if li_find > 0 then
	dw_browse.setrow(li_find)
	dw_browse.scrolltorow(li_find)
end if




	














end event

type cb_3 from commandbutton within uo_fppe_plan_setup
boolean visible = false
integer x = 2295
integer y = 36
integer width = 110
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "S"
end type

event clicked;of_hide_boxes(false)
end event

type cb_1 from commandbutton within uo_fppe_plan_setup
boolean visible = false
integer x = 2245
integer y = 36
integer width = 110
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "H"
end type

event clicked;of_hide_boxes(true)
end event

type cb_mod from commandbutton within uo_fppe_plan_setup
integer x = 1819
integer y = 36
integer width = 402
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Modify Plan"
end type

event clicked;
of_hide_boxes(false)


	














end event

type dw_crit from datawindow within uo_fppe_plan_setup
integer x = 2272
integer y = 1160
integer width = 2171
integer height = 808
integer taborder = 40
string title = "none"
string dataobject = "d_fppe_eval_crit_select"
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

type cbx_ext from checkbox within uo_fppe_plan_setup
integer x = 1742
integer y = 1188
integer width = 302
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

type cbx_retro from checkbox within uo_fppe_plan_setup
integer x = 1138
integer y = 1188
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

type cbx_con from checkbox within uo_fppe_plan_setup
integer x = 603
integer y = 1192
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

type cbx_pro from checkbox within uo_fppe_plan_setup
integer x = 137
integer y = 1268
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

type gb_1 from groupbox within uo_fppe_plan_setup
integer x = 73
integer y = 1088
integer width = 2085
integer height = 268
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

type gb_3 from groupbox within uo_fppe_plan_setup
integer x = 2222
integer y = 1084
integer width = 2263
integer height = 920
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Evaluation Criteria  (data sources and methodology)"
end type

type dw_detail from datawindow within uo_fppe_plan_setup
integer x = 37
integer y = 924
integer width = 4631
integer height = 1968
integer taborder = 10
string title = "none"
string dataobject = "d_fppe_plan_detail_temp"
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

