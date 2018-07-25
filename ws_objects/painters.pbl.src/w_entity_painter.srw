$PBExportHeader$w_entity_painter.srw
forward
global type w_entity_painter from window
end type
type cb_view_p from commandbutton within w_entity_painter
end type
type cb_view_l from commandbutton within w_entity_painter
end type
type dw_detail from u_dw within w_entity_painter
end type
type cbx_update from checkbox within w_entity_painter
end type
type cb_view_g from commandbutton within w_entity_painter
end type
type cb_view_f from commandbutton within w_entity_painter
end type
type cb_add_e from commandbutton within w_entity_painter
end type
type cb_7 from commandbutton within w_entity_painter
end type
type cb_close from commandbutton within w_entity_painter
end type
type cb_save from commandbutton within w_entity_painter
end type
type cb_add_f from commandbutton within w_entity_painter
end type
type cb_add_g from commandbutton within w_entity_painter
end type
type cb_4 from commandbutton within w_entity_painter
end type
type cb_add_l from commandbutton within w_entity_painter
end type
type cb_add_p from commandbutton within w_entity_painter
end type
type cb_1 from commandbutton within w_entity_painter
end type
type dw_browse from datawindow within w_entity_painter
end type
type cb_lookup from commandbutton within w_entity_painter
end type
type cb_provider from commandbutton within w_entity_painter
end type
type cb_location from commandbutton within w_entity_painter
end type
type cb_org from commandbutton within w_entity_painter
end type
type cb_group from commandbutton within w_entity_painter
end type
type cb_facility from commandbutton within w_entity_painter
end type
end forward

global type w_entity_painter from window
integer width = 3822
integer height = 2320
boolean titlebar = true
string title = "Entity Setup"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_view_p cb_view_p
cb_view_l cb_view_l
dw_detail dw_detail
cbx_update cbx_update
cb_view_g cb_view_g
cb_view_f cb_view_f
cb_add_e cb_add_e
cb_7 cb_7
cb_close cb_close
cb_save cb_save
cb_add_f cb_add_f
cb_add_g cb_add_g
cb_4 cb_4
cb_add_l cb_add_l
cb_add_p cb_add_p
cb_1 cb_1
dw_browse dw_browse
cb_lookup cb_lookup
cb_provider cb_provider
cb_location cb_location
cb_org cb_org
cb_group cb_group
cb_facility cb_facility
end type
global w_entity_painter w_entity_painter

type variables
nv_entity_functions inv_ent

end variables

forward prototypes
public function integer of_update_facility (long al_rec)
public function integer of_update_group (long al_rec)
public function integer of_update_loc (integer al_rec)
public function integer of_update_prac (long al_rec, long al_addr)
end prototypes

public function integer of_update_facility (long al_rec);//Start Code Change ----04.03.2014 #V14.2 maha

datastore ldw_row
long r
string ls_val
long fac

ldw_row = create datastore
ldw_row.dataobject = "d_facility_setup_database"
ldw_row.settransobject(sqlca)

r = ldw_row.retrieve(al_rec)
if r < 1 then return 1

r = 1

//ls_val = of_check_field_status(dw_detail,1,"entity_name")
//messagebox("",ls_val)
debugbreak()


if dw_detail.getitemstatus(1,"entity_name", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "entity_name") 
	ldw_row.setitem(r, "facility_name",ls_val )
	ldw_row.setitem(r, "return_facility_name",  ls_val )
end if

if dw_detail.getitemstatus(1,"street1", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "street1") 
	ldw_row.setitem(r, "street", ls_val)
	ldw_row.setitem(r, "return_street", ls_val )
end if

if dw_detail.getitemstatus(1,"street2", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "street2") 
	ldw_row.setitem(r, "street_2",ls_val )
	ldw_row.setitem(r, "return_street_2", ls_val )
end if

if dw_detail.getitemstatus(1,"city", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "city") 
	ldw_row.setitem(r, "city", ls_val )
	ldw_row.setitem(r, "return_city", ls_val )
end if

if dw_detail.getitemstatus(1,"state", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "state") 
	ldw_row.setitem(r, "state", ls_val )
	ldw_row.setitem(r, "return_state", ls_val )
end if

if dw_detail.getitemstatus(1,"zip", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "zip") 
	ldw_row.setitem(r, "zip",ls_val)
	ldw_row.setitem(r, "return_zip", ls_val )
end if

if dw_detail.getitemstatus(1,"email_address", primary!)  = datamodified! then
	ldw_row.setitem(r, "email_address", dw_detail.getitemstring(1,"email_address") )
end if	
if dw_detail.getitemstatus(1,"web_address", primary!)  = datamodified! then
	ldw_row.setitem(r, "web_address", dw_detail.getitemstring(1,"web_address") )
end if
if dw_detail.getitemstatus(1,"phone", primary!)  = datamodified! then
	ldw_row.setitem(r, "phone", dw_detail.getitemstring(1,"phone") )
end if	
if dw_detail.getitemstatus(1,"fax", primary!)  = datamodified! then
	ldw_row.setitem(r, "fax", dw_detail.getitemstring(1,"fax") )
end if
if dw_detail.getitemstatus(1,"contact_name", primary!)  = datamodified! then
	ldw_row.setitem(r, "credentialing_contact_name", dw_detail.getitemstring(1,"contact_name") )
end if

r = ldw_row.update()

destroy ldw_row

return 1
end function

public function integer of_update_group (long al_rec);//Start Code Change ----04.03.2014 #V14.2 maha

datastore ldw_row
long r
string ls_val
long fac

ldw_row = create datastore
ldw_row.dataobject = "d_multi_group_detail"
ldw_row.settransobject(sqlca)

r = ldw_row.retrieve(al_rec)
if r < 1 then return 1

r = 1

if dw_detail.getitemstatus(1,"entity_name", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "entity_name") 
	ldw_row.setitem(r, "gp_name",ls_val )
end if

if dw_detail.getitemstatus(1,"street1", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "street1") 
	ldw_row.setitem(r, "street1", ls_val)
end if

if dw_detail.getitemstatus(1,"street2", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "street2") 
	ldw_row.setitem(r, "street2",ls_val )
end if

if dw_detail.getitemstatus(1,"city", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "city") 
	ldw_row.setitem(r, "city", ls_val )
end if

if dw_detail.getitemstatus(1,"state", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "state") 
	ldw_row.setitem(r, "state", ls_val )
end if

if dw_detail.getitemstatus(1,"zip", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "zip") 
	ldw_row.setitem(r, "zip",ls_val)
end if

if dw_detail.getitemstatus(1,"email_address", primary!)  = datamodified! then
	ldw_row.setitem(r, "email_address", dw_detail.getitemstring(1,"email_address") )
end if	
if dw_detail.getitemstatus(1,"web_address", primary!)  = datamodified! then
	ldw_row.setitem(r, "web_address", dw_detail.getitemstring(1,"web_address") )
end if
if dw_detail.getitemstatus(1,"phone", primary!)  = datamodified! then
	ldw_row.setitem(r, "phone", dw_detail.getitemstring(1,"phone") )
end if	
if dw_detail.getitemstatus(1,"fax", primary!)  = datamodified! then
	ldw_row.setitem(r, "fax", dw_detail.getitemstring(1,"fax") )
end if
if dw_detail.getitemstatus(1,"contact_name", primary!)  = datamodified! then
	ldw_row.setitem(r, "contact_name", dw_detail.getitemstring(1,"contact_name") )
end if

r = ldw_row.update()

destroy ldw_row

return 1
end function

public function integer of_update_loc (integer al_rec); //Start Code Change ----11.07.2016 #V153 maha - added
datastore ldw_row
long r
string ls_val
long fac

ldw_row = create datastore
ldw_row.dataobject = "d_group_data_entry"
ldw_row.settransobject(sqlca)

r = ldw_row.retrieve(al_rec)
if r < 1 then return 1

r = 1

if dw_detail.getitemstatus(1,"entity_name", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "entity_name") 
	ldw_row.setitem(r, "street",ls_val )
end if

if dw_detail.getitemstatus(1,"street1", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "street1") 
	ldw_row.setitem(r, "street_2", ls_val)
end if

if dw_detail.getitemstatus(1,"suite_apart", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "suite_apart") 
	ldw_row.setitem(r, "suite_apart",ls_val )
end if

if dw_detail.getitemstatus(1,"city", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "city") 
	ldw_row.setitem(r, "city", ls_val )
end if

if dw_detail.getitemstatus(1,"state_code", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "state_code") 
	ldw_row.setitem(r, "state", ls_val )
end if

if dw_detail.getitemstatus(1,"zip", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "zip") 
	ldw_row.setitem(r, "zip",ls_val)
end if

if dw_detail.getitemstatus(1,"email_address", primary!)  = datamodified! then
	ldw_row.setitem(r, "e_mail_address", dw_detail.getitemstring(1,"email_address") )
end if	
if dw_detail.getitemstatus(1,"web_address", primary!)  = datamodified! then
	ldw_row.setitem(r, "web_address", dw_detail.getitemstring(1,"web_address") )
end if
if dw_detail.getitemstatus(1,"phone", primary!)  = datamodified! then
	ldw_row.setitem(r, "phone", dw_detail.getitemstring(1,"phone") )
end if	
if dw_detail.getitemstatus(1,"fax", primary!)  = datamodified! then
	ldw_row.setitem(r, "fax", dw_detail.getitemstring(1,"fax") )
end if
if dw_detail.getitemstatus(1,"contact_name", primary!)  = datamodified! then
	ldw_row.setitem(r, "contact_person", dw_detail.getitemstring(1,"contact_name") )
end if

r = ldw_row.update()

destroy ldw_row

return 1
end function

public function integer of_update_prac (long al_rec, long al_addr); //Start Code Change ----11.07.2016 #V153 maha - added
n_ds ldw_row
n_ds ldw_addr
long r
long ra
string ls_val
long fac

//prac
ldw_row = create n_ds
ldw_row.dataobject = "d_entity_prac_add"
ldw_row.settransobject(sqlca)
//address
ldw_addr = create n_ds
ldw_addr.dataobject = "d_entity_prac_addr_add"
ldw_addr.settransobject(sqlca)

r = ldw_row.retrieve(al_rec)
if r < 1 then return 1
ra = ldw_addr.retrieve(al_addr)

r = 1

//prac
if dw_detail.getitemstatus(1,"entity_name", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "entity_name") 
	ldw_row.setitem(r, "last_name",ls_val )
end if


//address
if dw_detail.getitemstatus(1,"entity_name", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "entity_name") 
	ldw_addr.setitem(r, "street",ls_val )
end if

if dw_detail.getitemstatus(1,"street1", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "street1") 
	ldw_addr.setitem(r, "street_2", ls_val)
end if

if dw_detail.getitemstatus(1,"suite_apart", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "suite_apart") 
	ldw_addr.setitem(r, "suite_apart",ls_val )
end if

if dw_detail.getitemstatus(1,"city", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "city") 
	ldw_addr.setitem(r, "city", ls_val )
end if

if dw_detail.getitemstatus(1,"state_code", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "state_code") 
	ldw_addr.setitem(r, "state", ls_val )
end if

if dw_detail.getitemstatus(1,"zip", primary!)  = datamodified! then
	ls_val =  dw_detail.getitemstring(1, "zip") 
	ldw_addr.setitem(r, "zip",ls_val)
end if

if dw_detail.getitemstatus(1,"email_address", primary!)  = datamodified! then
	ldw_addr.setitem(r, "e_mail_address", dw_detail.getitemstring(1,"email_address") )
end if	
if dw_detail.getitemstatus(1,"web_address", primary!)  = datamodified! then
	ldw_addr.setitem(r, "web_address", dw_detail.getitemstring(1,"web_address") )
end if
if dw_detail.getitemstatus(1,"phone", primary!)  = datamodified! then
	ldw_addr.setitem(r, "phone", dw_detail.getitemstring(1,"phone") )
end if	
if dw_detail.getitemstatus(1,"fax", primary!)  = datamodified! then
	ldw_addr.setitem(r, "fax", dw_detail.getitemstring(1,"fax") )
end if
if dw_detail.getitemstatus(1,"contact_name", primary!)  = datamodified! then
	ldw_addr.setitem(r, "contact_person", dw_detail.getitemstring(1,"contact_name") )
end if

//audit data
r = ldw_row.update()
//audit data
r = ldw_addr.update()


destroy ldw_row
destroy ldw_addr

return 1
end function

on w_entity_painter.create
this.cb_view_p=create cb_view_p
this.cb_view_l=create cb_view_l
this.dw_detail=create dw_detail
this.cbx_update=create cbx_update
this.cb_view_g=create cb_view_g
this.cb_view_f=create cb_view_f
this.cb_add_e=create cb_add_e
this.cb_7=create cb_7
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cb_add_f=create cb_add_f
this.cb_add_g=create cb_add_g
this.cb_4=create cb_4
this.cb_add_l=create cb_add_l
this.cb_add_p=create cb_add_p
this.cb_1=create cb_1
this.dw_browse=create dw_browse
this.cb_lookup=create cb_lookup
this.cb_provider=create cb_provider
this.cb_location=create cb_location
this.cb_org=create cb_org
this.cb_group=create cb_group
this.cb_facility=create cb_facility
this.Control[]={this.cb_view_p,&
this.cb_view_l,&
this.dw_detail,&
this.cbx_update,&
this.cb_view_g,&
this.cb_view_f,&
this.cb_add_e,&
this.cb_7,&
this.cb_close,&
this.cb_save,&
this.cb_add_f,&
this.cb_add_g,&
this.cb_4,&
this.cb_add_l,&
this.cb_add_p,&
this.cb_1,&
this.dw_browse,&
this.cb_lookup,&
this.cb_provider,&
this.cb_location,&
this.cb_org,&
this.cb_group,&
this.cb_facility}
end on

on w_entity_painter.destroy
destroy(this.cb_view_p)
destroy(this.cb_view_l)
destroy(this.dw_detail)
destroy(this.cbx_update)
destroy(this.cb_view_g)
destroy(this.cb_view_f)
destroy(this.cb_add_e)
destroy(this.cb_7)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cb_add_f)
destroy(this.cb_add_g)
destroy(this.cb_4)
destroy(this.cb_add_l)
destroy(this.cb_add_p)
destroy(this.cb_1)
destroy(this.dw_browse)
destroy(this.cb_lookup)
destroy(this.cb_provider)
destroy(this.cb_location)
destroy(this.cb_org)
destroy(this.cb_group)
destroy(this.cb_facility)
end on

event open;long r

dw_browse.retrieve()

 inv_ent = create nv_entity_functions
 
//Start Code Change ----10.01.2014 #V14.2 maha - added security
 r =  w_mdi.of_security_access(470)  //main facility

 if r= 0 then
	cb_add_f.visible = false
	cb_view_f.visible = false
elseif r = 1 then
	cb_add_f.enabled = false
end if

if w_mdi.of_security_access(533) = 0 then  ////Start Code Change ----10.20.2014 #V14.2 maha - add facility
	cb_add_f.enabled = false
end if


 r =  w_mdi.of_security_access(1320)  //main group
 if r= 0 then
	cb_add_g.visible = false
	cb_view_g.visible = false
elseif r = 1 then
	cb_add_g.enabled = false
end if
//Start Code Change ----10.01.2014

end event

event close;destroy inv_ent
end event

type cb_view_p from commandbutton within w_entity_painter
integer x = 1984
integer y = 2112
integer width = 448
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Provider"
end type

event clicked;//Start Code Change ----04.03.2014 #V14.2 maha

//long r
//long f
//
//if dw_detail.rowcount() < 1 then return  //Start Code Change ----10.01.2014 #V14.2 maha
//
//f = dw_detail.getitemnumber(1,"prac_id")
//
//if f > 0 then
//	of_open_prac_folder(f, 0)
//end if

//Start Code Change ----11.02.2016 #V153 maha

datastore ldw_new
boolean lb_no_loc = false
long r
long ll_prac
string ls_val
long ll_ent
long ll_addr
gs_pass_ids lst_ids


if dw_detail.rowcount() < 1 then return  //Start Code Change ----10.01.2014 #V14.2 maha
ll_prac = dw_detail.getitemnumber(1,"prac_id")
ll_ent = dw_detail.getitemnumber(1,"entity_id")
ll_addr = dw_detail.getitemnumber(1,"addr_id")

if ll_prac > 0 then
	lst_ids.l_ids[1] = ll_ent
	lst_ids.l_ids[2] = ll_prac
	lst_ids.l_ids[3] = ll_addr
	lst_ids.s_stringval = "V"
	openwithparm(w_prac_add_from_entity, lst_ids  )
	return 1
else	
	messagebox("Provider Add","There is no Provider record connected to this Entity")
end if

end event

type cb_view_l from commandbutton within w_entity_painter
integer x = 1495
integer y = 2112
integer width = 448
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Location"
end type

event clicked;//Start Code Change ----04.03.2014 #V14.2 maha

long r
long fac

if dw_detail.rowcount() < 1 then return  //Start Code Change ----10.01.2014 #V14.2 maha

fac = dw_detail.getitemnumber(1,"loc_id")

if isnull(fac) or fac = 0 then
	messagebox("View Group","There is no Location record connected to this Entity")
	return 1
else
	openwithparm(w_loc_view, fac)
end if



end event

type dw_detail from u_dw within w_entity_painter
integer y = 948
integer width = 3813
integer height = 976
integer taborder = 30
string dataobject = "d_entity_lookup_detail"
boolean vscrollbar = false
end type

event buttonclicked;call super::buttonclicked;//Start Code Change ----04.03.2014 #V14.2 maha
long ll_null
integer res

res = messagebox("Clear","Are you sure you want to break this link to the entity?", question!,yesno!,2)

if res = 2 then return

setnull(ll_null)
choose case dwo.name
	case "b_fac"
		this.setitem(1,"facility_id", ll_null)
	case "b_group"
		this.setitem(1,"group_id", ll_null)
	case "b_loc"
		this.setitem(1,"loc_id", ll_null)
	case "b_org"
		this.setitem(1,"org_id", ll_null)
	case "b_prac"
		this.setitem(1,"prac_id", ll_null)
		this.setitem(1,"addr_id", ll_null)
	case "b_lu"
		this.setitem(1,"lookup_id", ll_null)
end choose
end event

event constructor;call super::constructor;this.settransobject(sqlca)
end event

event itemchanged;call super::itemchanged;//Start Code Change ----04.03.2014 #V14.2 maha
datawindowchild dwchild
long ll_id
long f
string ls_code

if dwo.name = "state_code" then
	this.getchild( "state_code", dwchild )
	f = dwchild.find("lookup_code = " + data, 1, dwchild.rowcount())
	//messagebox("",f)
	if F > 0 then
		ls_code = dwchild.getitemstring(f,"code")
		this.setitem(1,"state", ls_code)
	end if
end if


 //Start Code Change ----04.07.2015 #V15 maha - zip autofill
if dwo.name = "zip" then
	string val
	this.accepttext( )
	val = this.getitemstring(1,"zip")
	of_zip_fill(val, "ENT", this)
end if
end event

type cbx_update from checkbox within w_entity_painter
integer x = 585
integer y = 52
integer width = 722
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Update connected Entities"
boolean checked = true
end type

type cb_view_g from commandbutton within w_entity_painter
integer x = 997
integer y = 2112
integer width = 448
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Group"
end type

event clicked;//Start Code Change ----04.03.2014 #V14.2 maha

long r
long fac

if dw_detail.rowcount() < 1 then return  //Start Code Change ----10.01.2014 #V14.2 maha

fac = dw_detail.getitemnumber(1,"group_id")

if isnull(fac) or fac = 0 then
	messagebox("View Group","There is no Group record connected to this Entity")
	return 1
else
	openwithparm(w_entity_group_add_view, fac)
end if



end event

type cb_view_f from commandbutton within w_entity_painter
integer x = 503
integer y = 2112
integer width = 443
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Facility"
end type

event clicked;//Start Code Change ----04.02.2014 #V14.2 maha

datastore ldw_new
long r
long fac
string ls_val

if dw_detail.rowcount() < 1 then return  //Start Code Change ----10.01.2014 #V14.2 maha

fac = dw_detail.getitemnumber(1,"facility_id")

ls_val = "E" + string(fac)

if gs_cust_type = 'I' then
	openwithparm(w_facility_setup_intelliapp, ls_val)
else
	openwithparm(w_facility_setup, ls_val)
end if
end event

type cb_add_e from commandbutton within w_entity_painter
integer x = 1367
integer y = 36
integer width = 530
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Entity"
end type

event clicked;//Start Code Change ----04.12.2011 #V11 maha - trap for no row.
if dw_detail.rowcount() > 0 then
	cb_save.triggerevent(clicked!)
end if

dw_detail.insertrow(1)
dw_detail.setrow(1)  //Start Code Change ----10.23.2014 #V14.2 maha
dw_detail.setfocus()
end event

type cb_7 from commandbutton within w_entity_painter
integer x = 1920
integer y = 36
integer width = 530
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;integer li_ans
long ll_row

li_ans = messagebox("Entity Delete ","Are you sure you wish to delete the Entity record.  This will not effect the currently linked records.", question!,yesno!,2)

//Start Code Change ----10.01.2014 #V14.2 maha - recoded to trap for unsaved record.
if li_ans = 2 then return
debugbreak()
if dw_detail.getitemstatus( 1, 0, primary!) = newmodified! or dw_detail.getitemstatus( 1, 0, primary!) = new! then
	dw_detail.deleterow(0)
	dw_detail.update()
else
	dw_detail.deleterow(0)
	dw_detail.update()
	dw_browse.deleterow(0)
	
	//---------Begin Added by (Appeon)Harry 10.22.2014 for BugH100901--------
	ll_row = dw_browse.getrow( )
	if ll_row > 0 then dw_browse.event rowfocuschanged(ll_row)
	//---------End Added ------------------------------------------------------
end if

//End Code Change ----10.01.2014 
	
end event

type cb_close from commandbutton within w_entity_painter
integer x = 3195
integer y = 36
integer width = 530
integer height = 84
integer taborder = 30
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

type cb_save from commandbutton within w_entity_painter
integer x = 27
integer y = 36
integer width = 530
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;long ll_eid
long fid

dw_detail.accepttext()
debugbreak()

if dw_detail.getitemstatus( 1, 0, primary!) = NotModified! then return

//Added by Appeon long.zhang 09.05.2014 ( V14.2 Bug#4179 Error when deleting an Entity)
if dw_detail.rowcount() = 0 then return

ll_eid = dw_detail.getitemnumber(1,"entity_id")

if isnull(ll_eid) then
	select max(entity_id) into :ll_eid from entity_lookup;
	if isnull(ll_eid) then ll_eid = 0
	ll_eid++
	dw_detail.setitem(1,"entity_id",ll_eid)
	dw_detail.setitem(1,"create_date",datetime(today(),now()))
	dw_detail.setitem(1,"create_user",gs_user_id )
else
	dw_detail.setitem(1,"mod_date",datetime(today(),now()))
	dw_detail.setitem(1,"mod_user",gs_user_id )
end if

if cbx_update.checked then
	fid = dw_detail.getitemnumber(1,"facility_id")
	of_update_facility( fid)
	fid = dw_detail.getitemnumber(1,"group_id")
	of_update_group( fid)
	 //Start Code Change ----11.07.2016 #V153 maha - added
	fid = dw_detail.getitemnumber(1,"loc_id")
	of_update_loc( fid)
	 //End Code Change ----11.07.2016
	  //Start Code Change ----11.07.2016 #V153 maha - added
	fid = dw_detail.getitemnumber(1,"prac_id")
	of_update_prac( fid, dw_detail.getitemnumber(1,"addr_id"))
	 //End Code Change ----11.07.2016
end if

dw_detail.update()

dw_browse.retrieve()
fid = dw_browse.find("entity_id =  " + string(ll_eid),1, dw_browse.rowcount())
if fid > 0 then
	dw_browse.setrow(fid)
	dw_browse.scrolltorow(fid)
	dw_browse.selectrow(0,false)
	dw_browse.selectrow(fid,true)
end if

end event

type cb_add_f from commandbutton within w_entity_painter
integer x = 503
integer y = 2032
integer width = 443
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Facility"
end type

event clicked;//Start Code Change ----04.02.2014 #V14.2 maha

datastore ldw_new
long r
long fac
string ls_val

if dw_detail.rowcount() < 1 then return  //Start Code Change ----10.01.2014 #V14.2 maha

if not(isnull(dw_detail.getitemnumber(1,"facility_id"))) then
	messagebox("Facility Add","There is already a facility record connected to this Entity")
	return 1
end if

ls_val = dw_detail.getitemstring(1, "entity_name") 
select count(facility_id)  into :fac from facility  where upper(facility_name) = upper(:ls_val);

if fac > 0 then 
	messagebox("Facility Add","There is already a facility with the name: " + ls_val)
	return 1
end if
 
ldw_new = create datastore
ldw_new.dataobject = "d_facility_setup_database"
ldw_new.settransobject(sqlca)

r = ldw_new.insertrow(1)

ls_val =  dw_detail.getitemstring(1, "entity_name") 
ldw_new.setitem(r, "facility_name",ls_val )
ldw_new.setitem(r, "return_facility_name",  ls_val )

ls_val =  dw_detail.getitemstring(1, "street1") 
ldw_new.setitem(r, "street", ls_val)
ldw_new.setitem(r, "return_street", ls_val )

ls_val =  dw_detail.getitemstring(1, "street2") 
ldw_new.setitem(r, "street_2",ls_val )
ldw_new.setitem(r, "return_street_2", ls_val )

ls_val =  dw_detail.getitemstring(1, "city") 
ldw_new.setitem(r, "city", ls_val )
ldw_new.setitem(r, "return_city", ls_val )

ls_val =  dw_detail.getitemstring(1, "state") 
ldw_new.setitem(r, "state", ls_val )
ldw_new.setitem(r, "return_state", ls_val )

ls_val =  dw_detail.getitemstring(1, "zip") 
ldw_new.setitem(r, "zip",ls_val)
ldw_new.setitem(r, "return_zip", ls_val )

ldw_new.setitem(r, "email_address", dw_detail.getitemstring(1,"email_address") )
ldw_new.setitem(r, "web_address", dw_detail.getitemstring(1,"web_address") )
ldw_new.setitem(r, "phone", dw_detail.getitemstring(1,"phone") )
ldw_new.setitem(r, "fax", dw_detail.getitemstring(1,"fax") )
ldw_new.setitem(r, "credentialing_contact_name", dw_detail.getitemstring(1,"contact_name") )

select max(facility_id) into :fac from facility;
fac++
ldw_new.setitem(r, "facility_id", fac)

r = ldw_new.update()

destroy ldw_new

if r < 1 then return

inv_ent.of_add_user_facility( fac, 0) //Start Code Change ----05.21.2014 #V14.2 maha

dw_detail.setitem(1,"facility_id", fac)  //Start Code Change ----05.20.2014 #V14.2 maha

ls_val = "E" + string(fac)

if gs_cust_type = 'I' then
	openwithparm(w_facility_setup_intelliapp, ls_val)
else
	openwithparm(w_facility_setup, ls_val)
end if
end event

type cb_add_g from commandbutton within w_entity_painter
integer x = 997
integer y = 2032
integer width = 448
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Group"
end type

event clicked;//Start Code Change ----04.03.2014 #V14.2 maha
datastore ldw_new
long r
long fac
string ls_val

if dw_detail.rowcount() < 1 then return  //Start Code Change ----10.01.2014 #V14.2 maha
fac = dw_detail.getitemnumber(1,"group_id")

if not(isnull(fac))  and fac > 0 then
	messagebox("Group Add","There is already a Group record connected to this Entity")
	openwithparm(w_entity_group_add_view, fac)
	return 1
end if

ls_val = dw_detail.getitemstring(1, "entity_name") 
select rec_id  into :fac from group_multi_loc  where upper(gp_name) = upper(:ls_val);

if fac > 0 then 
	messagebox("Group Add","There is already a Group with the name: " + ls_val)
	openwithparm(w_entity_group_add_view, fac)
	return 1
end if

ldw_new = create datastore
ldw_new.dataobject = "d_multi_group_detail"
ldw_new.settransobject(sqlca)

r = ldw_new.insertrow(1)

ls_val =  dw_detail.getitemstring(1, "entity_name") 
ldw_new.setitem(r, "gp_name",ls_val )

ls_val =  dw_detail.getitemstring(1, "street1") 
ldw_new.setitem(r, "street1", ls_val)

ls_val =  dw_detail.getitemstring(1, "street2") 
ldw_new.setitem(r, "street2",ls_val )

ls_val =  dw_detail.getitemstring(1, "city") 
ldw_new.setitem(r, "city", ls_val )

ls_val =  dw_detail.getitemstring(1, "state") 
ldw_new.setitem(r, "state", ls_val )

ls_val =  dw_detail.getitemstring(1, "zip") 
ldw_new.setitem(r, "zip",ls_val)

ldw_new.setitem(r, "email_address", dw_detail.getitemstring(1,"email_address") )
ldw_new.setitem(r, "web_address", dw_detail.getitemstring(1,"web_address") )
ldw_new.setitem(r, "phone", dw_detail.getitemstring(1,"phone") )
ldw_new.setitem(r, "fax", dw_detail.getitemstring(1,"fax") )
ldw_new.setitem(r, "contact_name", dw_detail.getitemstring(1,"contact_name") )

select max(rec_id) into :fac from group_multi_loc;
fac++
ldw_new.setitem(1,"rec_id", fac)

ldw_new.update()

destroy ldw_new

openwithparm(w_entity_group_add_view, fac)

if message.stringparm = "Cancel" then 
	return 1
else
	fac = message.doubleparm
	if fac = 0 then 
		return 1
	else
		dw_detail.setitem(1,"group_id", fac)
	end if
end if





 

end event

type cb_4 from commandbutton within w_entity_painter
boolean visible = false
integer x = 2633
integer y = 2048
integer width = 448
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Add Organization"
end type

event clicked;messagebox("Entity ","Not Yet functional.")
end event

type cb_add_l from commandbutton within w_entity_painter
integer x = 1495
integer y = 2032
integer width = 448
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Location"
end type

event clicked;//Start Code Change ----11.01.2016 #V153 maha

datastore ldw_new
boolean lb_no_loc = false
long r
long fac
string ls_val
long ll_val

if dw_detail.rowcount() < 1 then return  //Start Code Change ----10.01.2014 #V14.2 maha
fac = dw_detail.getitemnumber(1,"loc_id")

if not(isnull(fac))  and fac > 0 then
	messagebox("Location Add","There is already a Location record connected to this Entity")
	openwithparm(w_group_add_from_entity, fac)
	return 1
else
	lb_no_loc = true
end if

ls_val = dw_detail.getitemstring(1, "entity_name") 
select rec_id  into :fac from group_practice  where upper(street) = upper(:ls_val);

if fac > 0 then 
	messagebox("Group Add","There is already a Group with the name: " + ls_val)
	openwithparm(w_group_add_from_entity, fac)
	if lb_no_loc then
		if message.stringparm = "Cancel" then 
			return 1
		else //set the existing group into the entity
			fac = message.doubleparm
			if fac = 0 then 
				return 1
			else
				dw_detail.setitem(1,"loc_id", fac)
			end if
		end if
	end if
	return 1
end if

ldw_new = create datastore
ldw_new.dataobject = "d_group_data_entry"
ldw_new.settransobject(sqlca)

r = ldw_new.insertrow(1)

ls_val =  dw_detail.getitemstring(1, "entity_name") 
ldw_new.setitem(r, "street",ls_val )

ls_val =  dw_detail.getitemstring(1, "street1") 
ldw_new.setitem(r, "street_2", ls_val)

ls_val =  dw_detail.getitemstring(1, "suite_apart") 
ldw_new.setitem(r, "suite_apart",ls_val )

ls_val =  dw_detail.getitemstring(1, "city") 
ldw_new.setitem(r, "city", ls_val )

ls_val =  dw_detail.getitemstring(1, "state") 
ls_val = gnv_data.of_getitem("code_lookup", "lookup_code", "code = '" + ls_val + "'")
ldw_new.setitem(r, "state", long(ls_val) )

ls_val =  dw_detail.getitemstring(1, "zip") 
ldw_new.setitem(r, "zip",ls_val)

ldw_new.setitem(r, "e_mail_address", dw_detail.getitemstring(1,"email_address") )
ldw_new.setitem(r, "web_address", dw_detail.getitemstring(1,"web_address") )
ldw_new.setitem(r, "phone", dw_detail.getitemstring(1,"phone") )
ldw_new.setitem(r, "fax", dw_detail.getitemstring(1,"fax") )
ldw_new.setitem(r, "contact_person", dw_detail.getitemstring(1,"contact_name") )

select max(rec_id) into :fac from group_practice;
fac++
ldw_new.setitem(1,"rec_id", fac)

ldw_new.update()

destroy ldw_new

openwithparm(w_group_add_from_entity, fac)

if message.stringparm = "Cancel" then 
	return 1
else
	fac = message.doubleparm
	if fac = 0 then 
		return 1
	else
		dw_detail.setitem(1,"loc_id", fac)
	end if
end if





 

end event

type cb_add_p from commandbutton within w_entity_painter
integer x = 1984
integer y = 2032
integer width = 448
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Provider"
end type

event clicked;//Start Code Change ----11.02.2016 #V153 maha

datastore ldw_new
boolean lb_no_loc = false
long r
long ll_prac
string ls_val
long ll_ent
long ll_addr
gs_pass_ids lst_ids


if dw_detail.rowcount() < 1 then return  //Start Code Change ----10.01.2014 #V14.2 maha
ll_prac = dw_detail.getitemnumber(1,"prac_id")
ll_ent = dw_detail.getitemnumber(1,"entity_id")
ll_addr = dw_detail.getitemnumber(1,"addr_id")

if isnull(ll_ent) then return //(Appeon)Stephen 03.17.2017 - BugS031602
if ll_prac > 0 then
	messagebox("Provider Add","There is already a Provider record connected to this Entity")
	lst_ids.l_ids[1] = ll_ent
	lst_ids.l_ids[2] = ll_prac
	lst_ids.l_ids[3] = ll_addr
	lst_ids.s_stringval = "V"
	openwithparm(w_prac_add_from_entity, lst_ids  )
	return 1
else	
	lst_ids.l_ids[1] = ll_ent
	lst_ids.l_ids[2] = 0
	lst_ids.l_ids[3] = 0
	lst_ids.s_stringval = "A"
	openwithparm(w_prac_add_from_entity, lst_ids  )
end if

if message.stringparm = "Cancel" then return 
	
lst_ids = message.powerobjectparm

 dw_detail.setitem(1,"prac_id",  lst_ids.l_ids[1])
 dw_detail.setitem(1,"addr_id",  lst_ids.l_ids[2] )
  
  dw_detail.update()

end event

type cb_1 from commandbutton within w_entity_painter
boolean visible = false
integer x = 3136
integer y = 2048
integer width = 448
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Add Lookup"
end type

event clicked;messagebox("Entity ","Not Yet functional.")
end event

type dw_browse from datawindow within w_entity_painter
integer y = 136
integer width = 3813
integer height = 812
integer taborder = 10
string title = "none"
string dataobject = "d_entity_lookup"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

event clicked;long i

i = this.getclickedrow( )
this.setrow(i)
this.selectrow(0,false)
this.selectrow(i,true)
end event

event rowfocuschanged;long ll_id 

if currentrow< 1 then return  //Start Code Change ----10.01.2014 #V14.2 maha - trap for last delete

ll_id = this.getitemnumber( currentrow, "entity_id")

dw_detail.retrieve(ll_id)
end event

event retrieveend;if this.rowcount() > 0 then this.selectrow(1,true)
end event

type cb_lookup from commandbutton within w_entity_painter
boolean visible = false
integer x = 3136
integer y = 1952
integer width = 448
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Link Lookup"
end type

event clicked;messagebox("Entity ","Not Yet functional.")
end event

type cb_provider from commandbutton within w_entity_painter
integer x = 1984
integer y = 1952
integer width = 448
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Link Provider"
end type

event clicked;//Start Code Change ----10.28.2016 #V153 maha
gs_search lstr_search
long ic
long loc_id
long ll_addr

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "AUDIT"

OpenWithParm( w_extended_search_new , lstr_search )

IF Message.DoubleParm = -1 THEN Return 

ic = message.doubleparm

debugbreak()
if ic > 0 then dw_detail.setitem(1, "prac_id", ic)

loc_id = dw_detail.getitemnumber(1,"loc_id")

if loc_id > 0 then 
	select rec_id into :ll_addr from pd_address where prac_id = :ic and gp_id = :loc_id;
end if

if ll_addr > 0 then
	//use the one retrieved
else
	//open addresses for the user to select
	OpenWithParm(w_entity_select_prac_address, ic)
	ll_addr = message.doubleparm
end if

if ll_addr > 0 then
	dw_detail.setitem(1,"addr_id", ll_addr)
end if



end event

type cb_location from commandbutton within w_entity_painter
integer x = 1495
integer y = 1952
integer width = 448
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Link Location"
end type

event clicked;long f

if dw_detail.rowcount() < 1 then return  //Start Code Change ----10.01.2014 #V14.2 maha

open(w_loc_find)

f = message.doubleparm

if f > 0 then dw_detail.setitem(1,"loc_id",f)
end event

type cb_org from commandbutton within w_entity_painter
boolean visible = false
integer x = 2638
integer y = 1952
integer width = 448
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Link Organization"
end type

event clicked;messagebox("Entity ","Not Yet functional.")
end event

type cb_group from commandbutton within w_entity_painter
integer x = 997
integer y = 1952
integer width = 448
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Link Group"
end type

event clicked;long f

if dw_detail.rowcount() < 1 then return  //Start Code Change ----10.01.2014 #V14.2 maha

open(w_select_group)

f = message.doubleparm

if f > 0 then dw_detail.setitem(1,"group_id",f)
end event

type cb_facility from commandbutton within w_entity_painter
integer x = 503
integer y = 1952
integer width = 443
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Link Facility"
end type

event clicked;long f

if dw_detail.rowcount() < 1 then return  //Start Code Change ----10.01.2014 #V14.2 maha

openwithparm(w_select_facility,"A")


f = message.doubleparm

if f > 0 then dw_detail.setitem(1,"facility_id",f)


end event

