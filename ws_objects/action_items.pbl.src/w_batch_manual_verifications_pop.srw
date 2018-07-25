$PBExportHeader$w_batch_manual_verifications_pop.srw
forward
global type w_batch_manual_verifications_pop from w_main
end type
type cb_close from commandbutton within w_batch_manual_verifications_pop
end type
type cb_web from commandbutton within w_batch_manual_verifications_pop
end type
type cb_3 from commandbutton within w_batch_manual_verifications_pop
end type
type cb_2 from commandbutton within w_batch_manual_verifications_pop
end type
type cb_1 from commandbutton within w_batch_manual_verifications_pop
end type
type st_1 from statictext within w_batch_manual_verifications_pop
end type
type dw_select from u_dw within w_batch_manual_verifications_pop
end type
type dw_log from u_dw within w_batch_manual_verifications_pop
end type
type cb_prac from commandbutton within w_batch_manual_verifications_pop
end type
type cb_batch from commandbutton within w_batch_manual_verifications_pop
end type
type cb_forward from commandbutton within w_batch_manual_verifications_pop
end type
type cb_back from commandbutton within w_batch_manual_verifications_pop
end type
type dw_data from u_dw within w_batch_manual_verifications_pop
end type
type dw_pracs from u_dw within w_batch_manual_verifications_pop
end type
type dw_batch from u_dw within w_batch_manual_verifications_pop
end type
type uo_popsite from pfc_cst_u_popwebsite within w_batch_manual_verifications_pop
end type
end forward

global type w_batch_manual_verifications_pop from w_main
integer width = 4553
integer height = 2900
long backcolor = 33551856
cb_close cb_close
cb_web cb_web
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
st_1 st_1
dw_select dw_select
dw_log dw_log
cb_prac cb_prac
cb_batch cb_batch
cb_forward cb_forward
cb_back cb_back
dw_data dw_data
dw_pracs dw_pracs
dw_batch dw_batch
uo_popsite uo_popsite
end type
global w_batch_manual_verifications_pop w_batch_manual_verifications_pop

type variables
long il_pracs[]
long il_batch
long il_pracid
string is_prac_names[]
string is_url
end variables

forward prototypes
public function integer of_batch_type (string as_type)
public function integer of_screen_id (integer ai_table)
end prototypes

public function integer of_batch_type (string as_type);long n
string s

choose case as_type
	case "O"
		dw_batch.setitem(1,"screen_id" , 25)
		setnull(n)
		dw_batch.setitem(1,"entity_id" , n )
		dw_batch.modify("entity_id.protect = true ")
		dw_batch.modify("screen_id.protect = true ")
		dw_batch.modify("screen_id.color = 0 ")
		dw_batch.modify("addtl_filter.protect = true ")
		cb_web.enabled = false
		cb_forward.enabled = false
		cb_back.enabled = false
	case else
		dw_batch.modify("entity_id.protect = false ")
		dw_batch.modify("screen_id.protect = false ")
		dw_batch.modify("addtl_filter.protect = false ")
		cb_web.enabled = true
end choose
		
return 1
end function

public function integer of_screen_id (integer ai_table);datawindowchild dwchild
string ls_lu
select top 1 lookup_code into :ls_lu from sys_fields where table_id = :ai_table and lookup_type = 'A' and lookup_code is not null;

dw_batch.getchild( "entity_id", dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve(ls_lu)

return 1
end function

on w_batch_manual_verifications_pop.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_web=create cb_web
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.dw_select=create dw_select
this.dw_log=create dw_log
this.cb_prac=create cb_prac
this.cb_batch=create cb_batch
this.cb_forward=create cb_forward
this.cb_back=create cb_back
this.dw_data=create dw_data
this.dw_pracs=create dw_pracs
this.dw_batch=create dw_batch
this.uo_popsite=create uo_popsite
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_web
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.dw_select
this.Control[iCurrent+8]=this.dw_log
this.Control[iCurrent+9]=this.cb_prac
this.Control[iCurrent+10]=this.cb_batch
this.Control[iCurrent+11]=this.cb_forward
this.Control[iCurrent+12]=this.cb_back
this.Control[iCurrent+13]=this.dw_data
this.Control[iCurrent+14]=this.dw_pracs
this.Control[iCurrent+15]=this.dw_batch
this.Control[iCurrent+16]=this.uo_popsite
end on

on w_batch_manual_verifications_pop.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_web)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.dw_select)
destroy(this.dw_log)
destroy(this.cb_prac)
destroy(this.cb_batch)
destroy(this.cb_forward)
destroy(this.cb_back)
destroy(this.dw_data)
destroy(this.dw_pracs)
destroy(this.dw_batch)
destroy(this.uo_popsite)
end on

event resize;call super::resize; //Start Code Change ----05.14.2015 #V15 maha
long ll_win_h
long ll_win_w
long ll_ole_h
long ll_ole_w
long ll_p_w


ll_win_h = w_batch_manual_verifications_pop.WorkSpaceHeight() - 400
ll_ole_h = ll_win_h /10 *8
uo_popsite.height = ll_ole_h
dw_pracs.height = uo_popsite.height

ll_ole_w = w_batch_manual_verifications_pop.WorkSpaceWidth() /100 *85 - 40
ll_p_w = w_batch_manual_verifications_pop.WorkSpaceWidth() /100 *15

//ll_ole_w = w_batch_manual_verifications_pop.WorkSpaceWidth() - dw_pracs.width - 20

uo_popsite.width = ll_ole_w
uo_popsite.x = ll_p_w + 20
dw_pracs.width = ll_p_w


dw_log.y = uo_popsite.height + uo_popsite.y +5
dw_log.height =  ll_win_h /10 *2
dw_data.y = uo_popsite.height + uo_popsite.y +5
dw_data.height =  ll_win_h /10 *2

dw_data.width = w_batch_manual_verifications_pop.WorkSpaceWidth() /2 - 10
dw_log.x = dw_data.width + 10
dw_log.width = w_batch_manual_verifications_pop.WorkSpaceWidth() /2 - 10

uo_popsite.triggerevent("ue_resize")

//cb_close.x = w_batch_manual_verifications_pop.WorkSpaceWidth() - 335
 



end event

event pfc_preopen;call super::pfc_preopen;//Register controls
this.of_SetResize(True)
inv_resize.of_SetMinSize(This.WorkSpaceWidth(),This.WorkSpaceHeight())
inv_resize.of_SetOrigSize(This.WorkSpaceWidth(),This.WorkSpaceHeight())

//inv_resize.of_Register(cb_close, inv_resize.FIXEDRIGHT)
//inv_resize.of_Register(tab_1, inv_resize.SCALE)
//inv_resize.of_Register(tab_1.tabpage_1.dw_app_list, inv_resize.SCALE)
//inv_resize.of_Register(uo_popsite, inv_resize.SCALE)
end event

type cb_close from commandbutton within w_batch_manual_verifications_pop
integer x = 4215
integer y = 24
integer width = 283
integer height = 92
integer taborder = 30
boolean bringtotop = true
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

type cb_web from commandbutton within w_batch_manual_verifications_pop
boolean visible = false
integer x = 2281
integer y = 324
integer width = 325
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Go To Site"
end type

event clicked;//long ll_lu
//string ls_site
//
//
//ll_lu = dw_batch.getitemnumber(1,"entity_id")
//
//if isnull(ll_lu) then
//	messagebox("Select Entity","No Entity selected for this batch")
//end if
//
//select web_address into :ls_site from address_lookup where lookup_code = :ll_lu;
//
//if isnull(ls_site) or len(ls_site) < 10 then 
//	messagebox("No Web Link","No valid WebSite for this entity. Please check the lookup list.")
//	return
//end if
//
//try
//	ole_browser.object.navigate(ls_site)
//	catch (RuntimeError e)
//end try
end event

type cb_3 from commandbutton within w_batch_manual_verifications_pop
integer x = 4215
integer y = 128
integer width = 283
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;long ll_batch

if dw_batch.getitemstatus( 1, 0, primary!) = datamodified! or dw_batch.getitemstatus( 1, 0, primary!) = newmodified! then
	if isnull(dw_batch.getitemnumber(1,"batch_id")) then
		select max(batch_id) into :ll_batch from verif_batch_setup;
		if isnull(ll_batch) then ll_batch = 0
		ll_batch++
		il_batch = ll_batch
		dw_batch.setitem(1,"batch_id",ll_batch)
	end if
	dw_batch.update()
end if
end event

type cb_2 from commandbutton within w_batch_manual_verifications_pop
integer x = 434
integer y = 164
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Delete"
end type

type cb_1 from commandbutton within w_batch_manual_verifications_pop
integer x = 27
integer y = 164
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;dw_batch.insertrow(1)
dw_batch.setitem(1,"image_yn",0)
dw_batch.setitem(1,"create_verif",0)
end event

type st_1 from statictext within w_batch_manual_verifications_pop
integer x = 41
integer y = 12
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Batch"
boolean focusrectangle = false
end type

type dw_select from u_dw within w_batch_manual_verifications_pop
integer x = 23
integer y = 64
integer width = 754
integer height = 84
integer taborder = 20
string dataobject = "d_verif_batch_select"
boolean vscrollbar = false
boolean border = false
end type

event constructor;call super::constructor;this.settransobject( sqlca)
this.retrieve()
this.insertrow(1)

this.of_setupdateable(false)
end event

event itemchanged;call super::itemchanged;long ll_table
string ls_type


il_batch = long(data)

if il_batch > 0 then
	dw_batch.retrieve(il_batch)
	
	ls_type = dw_batch.getitemstring(1,"batch_type")
	of_batch_type(ls_type)

	ll_table = dw_batch.getitemnumber(1,"screen_id")
	of_screen_id(ll_table)
end if
end event

type dw_log from u_dw within w_batch_manual_verifications_pop
integer x = 2272
integer y = 2204
integer width = 2231
integer height = 576
integer taborder = 20
end type

type cb_prac from commandbutton within w_batch_manual_verifications_pop
integer x = 23
integer y = 328
integer width = 366
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select Provider"
end type

event clicked;Integer li_nr
Integer li_find
Long ll_prac_id
String ls_full_name
long r
long rc
long i
long ic
gs_search lstr_search
gs_batch_search lst_batch

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "REPORTS0" 

OpenWithParm( w_extended_search_new , lstr_search )

IF Message.DoubleParm = -1 THEN
	Return -1
END IF
debugbreak()
rc = UpperBound( il_pracs )
////ll_prac_id = Long( Mid( Message.StringParm, 1, Pos( Message.StringParm, "-" ) -1 ) )

lst_batch = message.powerobjectparm
//maha 091605 allowing for multi selection
ic = upperbound(lst_batch.li_prac_id[])
//maha app101305
for i = 1 to ic
	ll_prac_id = lst_batch.li_prac_id[i] //maha 091605
	for r = 1 to rc
		if il_pracs[r] = ll_prac_id then
			li_find = 1
			exit
		end if
	next
	IF li_find > 0 THEN
		//skip
	else
		rc++
		il_pracs[rc] = ll_prac_id
		//Start Code Change ---- 04.10.2006 #396 maha
		is_prac_names[rc] = lst_batch.ls_name[i]
		//End Code Change---04.10.2006
	END IF
next


//st_pracs.Text = String( UpperBound( il_pracs[] ) ) + " Providers selected."

IF UpperBound( il_pracs ) > 0 THEN
	dw_pracs.retrieve(il_pracs)
END IF

 

end event

type cb_batch from commandbutton within w_batch_manual_verifications_pop
integer x = 389
integer y = 328
integer width = 210
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Batch "
end type

event clicked;gs_batch_search lst_search

openwithparm(w_batch_prac_select_new, "R" )

if message.stringparm = "Cancel" then return

lst_search = message.powerobjectparm
il_pracs[] = lst_search.li_prac_id[]
is_prac_names[] = lst_search.ls_name[]

//st_pracs.Text = String( UpperBound( il_pracs[] ) ) + " Providers selected."

IF UpperBound( il_pracs ) > 0 THEN
	dw_pracs.retrieve(il_pracs)
END IF



 

end event

type cb_forward from commandbutton within w_batch_manual_verifications_pop
boolean visible = false
integer x = 2423
integer y = 324
integer width = 325
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Forward >>"
end type

event clicked;//////---------Begin Modified by alfee 08.11.2010 --------
////If ole_browser.bringtotop = True Then
//	ole_browser.object.goforward()
////ElseIf ole_browser2.bringtotop = True Then
////	ole_browser2.object.goforward()
////End If
////tab_1.tabpage_view.ole_browser.object.goforward()
////---------End Modified ------------------------------
//
end event

type cb_back from commandbutton within w_batch_manual_verifications_pop
boolean visible = false
integer x = 2377
integer y = 324
integer width = 325
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "<< Back"
end type

event clicked;//try
//
////	If ole_browser.bringtotop = True Then
//		ole_browser.object.goback()
////	ElseIf ole_browser2.bringtotop = True Then
////		ole_browser2.object.goback()
////	End If
//
//	//---------End Modified ------------------------------	
//catch (RuntimeError e) // Add by Evan on 10.19.2009
//end try
end event

type dw_data from u_dw within w_batch_manual_verifications_pop
integer x = 18
integer y = 2204
integer width = 2231
integer height = 576
integer taborder = 10
boolean hscrollbar = true
end type

event itemchanged;call super::itemchanged;this.of_setupdateable(false)
end event

type dw_pracs from u_dw within w_batch_manual_verifications_pop
integer x = 18
integer y = 324
integer width = 786
integer height = 1864
integer taborder = 10
boolean titlebar = true
string title = "Providers"
string dataobject = "d_practitioner_list"
end type

event constructor;call super::constructor;this.of_setupdateable(false)
end event

event clicked;call super::clicked;long r
string s
r = this.getclickedrow()
if r < 1 then return



this.setrow(r)
this.selectrow( 0, false)
this.selectrow( r, true)
il_pracid = this.getitemnumber(r,"prac_id")
//messagebox("Prac",il_pracid)

//fix this


//of_get_data()
//dw_log.insertrow(1)
//dw_log.setitem(1,"prac_id", il_pracid)
//dw_log.setitem(1,"verif_date", datetime(today(),now()))



end event

event buttonclicked;call super::buttonclicked;string s

//this does not work
if dwo.name = 'b_last' then 
	s = this.getitemstring(row,"last_name")
	//messagebox("",s)
	clipboard(s)
end if

if dwo.name = 'b_first' then 
	s = this.getitemstring(row,"first_name")
	clipboard(s)
end if
end event

type dw_batch from u_dw within w_batch_manual_verifications_pop
integer x = 795
integer y = 8
integer width = 3397
integer height = 280
integer taborder = 10
string dataobject = "d_verif_batch_setup_detail"
boolean vscrollbar = false
end type

event itemchanged;call super::itemchanged;string v

if dwo.name = "batch_type" then
	v = data
	of_batch_type(v)
end if

if dwo.name = "screen_id" then
	v = data
	of_screen_id(integer(data))
end if


			
end event

type uo_popsite from pfc_cst_u_popwebsite within w_batch_manual_verifications_pop
integer x = 809
integer y = 324
integer height = 1864
integer taborder = 40
boolean bringtotop = true
boolean border = true
end type

on uo_popsite.destroy
call pfc_cst_u_popwebsite::destroy
end on

