$PBExportHeader$w_batch_verifi_setup.srw
forward
global type w_batch_verifi_setup from w_main
end type
type dw_browse from datawindow within w_batch_verifi_setup
end type
type st_2 from statictext within w_batch_verifi_setup
end type
type dw_crawler from u_dw within w_batch_verifi_setup
end type
type cb_close from commandbutton within w_batch_verifi_setup
end type
type cb_save from commandbutton within w_batch_verifi_setup
end type
type cb_del from commandbutton within w_batch_verifi_setup
end type
type cb_add from commandbutton within w_batch_verifi_setup
end type
type dw_batch from u_dw within w_batch_verifi_setup
end type
type dw_status from u_dw within w_batch_verifi_setup
end type
end forward

global type w_batch_verifi_setup from w_main
integer width = 3616
integer height = 1560
string title = "Batch Verification Setup"
windowtype windowtype = popup!
long backcolor = 33551856
dw_browse dw_browse
st_2 st_2
dw_crawler dw_crawler
cb_close cb_close
cb_save cb_save
cb_del cb_del
cb_add cb_add
dw_batch dw_batch
dw_status dw_status
end type
global w_batch_verifi_setup w_batch_verifi_setup

type variables
long il_pracs[]
long il_batch
long il_pracid
long il_screen
long il_dvid = 1
long il_rec_id
long il_wc_id
long il_facility
long il_entity
string is_save_type = 'N'
string is_prac_names[]
string is_url
string is_type
string is_lookup_search_column_field = "None" 
string is_lookup_search_column_table = "None"
pfc_cst_nv_data_entry_functions inv_data_fun
pfc_n_cst_ai_action_items  inv_action_items
end variables

forward prototypes
public function integer of_batch_type (string as_type)
public function integer of_screen_id (integer ai_table)
public function integer of_set_lookup_filter ()
public function integer of_get_crawler ()
end prototypes

public function integer of_batch_type (string as_type);long n
string s

//O = oig; W = website; C = crawler

choose case as_type
	case "O"
		dw_batch.setitem(1,"screen_id" , 25)
		setnull(n)
		dw_batch.setitem(1,"entity_id" , n )
		dw_batch.modify("entity_id.protect = true ")
		dw_batch.modify("screen_id.protect = true ")
		dw_batch.modify("screen_id.color = 0 ")
		dw_batch.modify("addtl_filter.protect = true ")

	case "W"
		dw_batch.modify("entity_id.protect = false ")
		dw_batch.modify("screen_id.protect = false ")
		dw_batch.modify("addtl_filter.protect = false ")

	case "C"
		dw_batch.modify("entity_id.protect = false ")
		dw_batch.modify("screen_id.protect = false ")
		dw_batch.modify("addtl_filter.protect = false ")

		dw_status.retrieve()
		dw_status.insertrow(1)
end choose

is_type = as_type

of_set_lookup_filter( )
		
return 1
end function

public function integer of_screen_id (integer ai_table); //Start Code Change ----07.07.2015 #V15 maha - gets the lookup table name and the screen id for the table

datawindowchild dwchild
string ls_lu
select top 1 lookup_code into :ls_lu from sys_fields where table_id = :ai_table and lookup_type = 'A' and lookup_code is not null;
select screen_id into :il_screen from data_view_screen where table_id = :ai_table and data_view_id = 1;

dw_batch.getchild( "entity_id", dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve(ls_lu)

of_set_lookup_filter( )

return 1
end function

public function integer of_set_lookup_filter (); //Start Code Change ----07.01.2015 #V15 maha
string ls_filter
datawindowchild dwchild
integer res

choose case is_type
	case "O"
		ls_filter = "lookup_code = 0"
	case "C"
		ls_filter = "not isnull(wc_id)"
	case "W"
		ls_filter = "not isnull(web_address)"
end choose

dw_batch.getchild( "entity_id", dwchild)

res = dwchild.setfilter(ls_filter)
if res < 0 then
	messagebox("Lookup List filter error",ls_filter)
elseif res = 0 then
	if is_type = "W" then
		messagebox("Entity Filter","The Connected Entity Lookup table does not have any records with web addresses")
	elseif is_type = "C" then
		messagebox("Entity Filter","The Connected Entity Lookup table does not have any records Set up as WebCrawlers.")
	end if
end if

dwchild.filter()

return 1


		
end function

public function integer of_get_crawler ();//gets the web crawler id from the selected entity
long wcid
long ll_row
long ll_ent
string sss
datawindowchild dwchild

ll_ent = dw_batch.getitemnumber(1, "entity_id")
sss = "lookup_code = " + string(ll_ent )

dw_batch.getchild("entity_id", dwchild)
ll_row = dwchild.find(sss ,1,dwchild.rowcount())
wcid = dwchild.getitemnumber(ll_row, 'wc_id')

if isnull(wcid)  then 
	messagebox("WebCrawler error", "There is no WebCrawler connected to this Entity")
else
	il_wc_id = wcid
	//messagebox("wc id", wcid)
end if


RETURN 1
end function

on w_batch_verifi_setup.create
int iCurrent
call super::create
this.dw_browse=create dw_browse
this.st_2=create st_2
this.dw_crawler=create dw_crawler
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cb_del=create cb_del
this.cb_add=create cb_add
this.dw_batch=create dw_batch
this.dw_status=create dw_status
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_browse
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.dw_crawler
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.cb_save
this.Control[iCurrent+6]=this.cb_del
this.Control[iCurrent+7]=this.cb_add
this.Control[iCurrent+8]=this.dw_batch
this.Control[iCurrent+9]=this.dw_status
end on

on w_batch_verifi_setup.destroy
call super::destroy
destroy(this.dw_browse)
destroy(this.st_2)
destroy(this.dw_crawler)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cb_del)
destroy(this.cb_add)
destroy(this.dw_batch)
destroy(this.dw_status)
end on

event open;call super::open; //Start Code Change ----07.07.2015 #V15 maha - Added for 15.1
 inv_data_fun = create pfc_cst_nv_data_entry_functions
 inv_data_fun.of_setup_cache()
inv_data_fun.of_refresh_cache()

dw_browse.settransobject(sqlca)
dw_browse.retrieve()

end event

event close;call super::close;destroy inv_data_fun
end event

type dw_browse from datawindow within w_batch_verifi_setup
integer x = 46
integer y = 144
integer width = 3474
integer height = 940
integer taborder = 50
string title = "none"
string dataobject = "d_verif_batch_setup_browse"
boolean livescroll = true
end type

event rowfocuschanged;long ll_batch
long ll_table
string ls_type
string ls_save

if currentrow < 1 then return

ll_batch = this.getitemnumber(currentrow,"batch_id")
il_batch = ll_batch

this.selectrow(0,False)
this.selectrow(currentrow,true)

dw_batch.retrieve(ll_batch)

ls_type = dw_batch.getitemstring(1,"batch_type")
of_batch_type(ls_type)

ll_table = dw_batch.getitemnumber(1,"screen_id")
of_screen_id(ll_table)

il_dvid = dw_batch.getitemnumber(1,"dv_id")
if isnull(il_dvid) or il_dvid = 0 then il_dvid = 1

ls_save = dw_batch.getitemstring(1,"image_yn")
choose case ls_save
	case "0"
		is_save_type = "N"
	case "1"
		is_save_type = "B"
	case "2"
		is_save_type = "H"
end choose

il_facility =  dw_batch.getitemnumber(1,"facility_id")
end event

type st_2 from statictext within w_batch_verifi_setup
boolean visible = false
integer x = 4581
integer y = 272
integer width = 306
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Response:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_crawler from u_dw within w_batch_verifi_setup
boolean visible = false
integer x = 3959
integer y = 368
integer width = 91
integer height = 56
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_wc_hdr_imp"
boolean hscrollbar = true
end type

type cb_close from commandbutton within w_batch_verifi_setup
integer x = 3168
integer y = 36
integer width = 343
integer height = 84
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

type cb_save from commandbutton within w_batch_verifi_setup
integer x = 1966
integer y = 36
integer width = 343
integer height = 84
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
integer r
boolean lb_new = false


//verif batch data
if dw_batch.getitemstatus( 1, 0, primary!) = datamodified! or dw_batch.getitemstatus( 1, 0, primary!) = newmodified! then
	if isnull(dw_batch.getitemnumber(1,"batch_id")) then
		select max(batch_id) into :ll_batch from verif_batch_setup;
		if isnull(ll_batch) then ll_batch = 0
		ll_batch++
		il_batch = ll_batch
		dw_batch.setitem(1,"batch_id",ll_batch)
		lb_new = true
	end if
else
	ll_batch = il_batch
end if

dw_batch.update()

dw_browse.retrieve()
r = dw_browse.find("batch_id = " + string(ll_batch), 1, dw_browse.rowcount())
if r > 0 then
	dw_browse.scrolltorow(r)
	dw_browse.setrow(r)
	dw_browse.selectrow(0,false)
	dw_browse.selectrow(r,true)
end if








end event

type cb_del from commandbutton within w_batch_verifi_setup
boolean visible = false
integer x = 2711
integer y = 36
integer width = 343
integer height = 84
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

type cb_add from commandbutton within w_batch_verifi_setup
integer x = 2341
integer y = 36
integer width = 343
integer height = 84
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
end event

type dw_batch from u_dw within w_batch_verifi_setup
integer x = 46
integer y = 1104
integer width = 3474
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
debugbreak()
if dwo.name = "screen_id" then
	v = data
	of_screen_id(integer(data))
end if

if dwo.name = "dv_id" then
	v = data
	il_dvid = long(data)
end if

if dwo.name = "image_yn" then
	choose case data
		case "0"
			is_save_type = "N"
		case "1"
			is_save_type = "B"
		case "2"
			is_save_type = "H"
	end choose
end if

if dwo.name = "entity_id" then
	this.accepttext()
	of_get_crawler()
end if

if dwo.name = "facility_id" then
	this.accepttext()
	il_facility = long(data)
end if
end event

event buttonclicked;call super::buttonclicked;if dwo.name = "b_link" then
	long l
	string s
	l = this.getitemnumber(1,"entity_id")
	select web_address into :s from address_lookup where lookup_code = :l;
	messagebox("On Clipboard", s)
	::clipboard(s)
end if



IF dwo.Name = "b_filter" THEN

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2006-11-28 By: Rodger Wu (doc painter)
	//$<reason> 
	integer li_module_type, li_found
	long ll_table
	string ls_mess


	ll_table = this.getitemnumber(row,"screen_id")
	ls_Mess = "pd_batch|" +  string(ll_table)
		OpenWithParm(w_query_wizard, ls_Mess)
		//------------------- APPEON END ---------------------
		
	ls_mess = message.stringparm
	if ls_mess = "Cancel" then
		return
	else
		this.setitem(row,"addtl_filter",ls_mess)
	end if
	
	return

end if
end event

event constructor;call super::constructor;datawindowchild dwchild

this.settransobject(sqlca)

this.getchild("facility_id", dwchild)

dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)
end event

type dw_status from u_dw within w_batch_verifi_setup
boolean visible = false
integer x = 4891
integer y = 256
integer width = 635
integer height = 76
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_code_lookup_verif_log_status"
boolean vscrollbar = false
boolean border = false
end type

event itemchanged;call super::itemchanged;this.of_setupdateable(false)
this.of_settransobject(sqlca)
end event

