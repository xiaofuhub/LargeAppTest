$PBExportHeader$pfc_cst_u_address_linked_data.sru
forward
global type pfc_cst_u_address_linked_data from userobject
end type
type dw_addr_head from datawindow within pfc_cst_u_address_linked_data
end type
type st_privs from statictext within pfc_cst_u_address_linked_data
end type
type st_ids from statictext within pfc_cst_u_address_linked_data
end type
type st_specs from statictext within pfc_cst_u_address_linked_data
end type
type dw_ids from u_dw within pfc_cst_u_address_linked_data
end type
type dw_specs from u_dw within pfc_cst_u_address_linked_data
end type
type dw_privs from u_dw within pfc_cst_u_address_linked_data
end type
end forward

global type pfc_cst_u_address_linked_data from userobject
integer width = 2779
integer height = 1812
long backcolor = 16777215
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_addr_head dw_addr_head
st_privs st_privs
st_ids st_ids
st_specs st_specs
dw_ids dw_ids
dw_specs dw_specs
dw_privs dw_privs
end type
global pfc_cst_u_address_linked_data pfc_cst_u_address_linked_data

type variables
long il_addrid
long il_prac_id
long ii_facility
end variables

forward prototypes
public function integer of_get_data (long al_rec_id, long al_gp_id, integer al_facility)
public function integer of_security (integer ai_set)
end prototypes

public function integer of_get_data (long al_rec_id, long al_gp_id, integer al_facility);//Start Code Change ----07.15.2014 #V14.2 maha - added
integer r

if isnull(al_rec_id) or al_rec_id = 0 then return 1  //Start Code Change ----10.01.2014 #V14.2 maha - trap for null recid

il_addrid = al_rec_id

r = dw_specs.retrieve( il_prac_id, al_rec_id)
r = dw_privs.retrieve( il_prac_id, al_facility, al_rec_id)
 //Start Code Change ----04.08.2015 #V15 maha - added check for valid location
if al_gp_id > 0 then  
	r = dw_ids.retrieve( il_prac_id, al_gp_id)
else
	 dw_ids.reset()
end if
 //End Code Change ----04.08.2015
r = dw_addr_head.retrieve(al_rec_id)

return 1
end function

public function integer of_security (integer ai_set);//Start Code Change ----07.15.2014 #V14.2 maha - added for function security

if ai_set = 1 then
	st_privs.visible = false
	dw_privs.visible = false
	st_specs.width = 2600
	dw_specs.width = 2600
	st_ids.x = st_specs.x
	st_ids.y = dw_specs.y + dw_specs.height + 10
	st_ids.width = 2600
	dw_ids.width = 2600
	dw_ids.x = st_specs.x
	dw_ids.y = st_ids.y + st_ids.height + 10
end if

return 1
end function

on pfc_cst_u_address_linked_data.create
this.dw_addr_head=create dw_addr_head
this.st_privs=create st_privs
this.st_ids=create st_ids
this.st_specs=create st_specs
this.dw_ids=create dw_ids
this.dw_specs=create dw_specs
this.dw_privs=create dw_privs
this.Control[]={this.dw_addr_head,&
this.st_privs,&
this.st_ids,&
this.st_specs,&
this.dw_ids,&
this.dw_specs,&
this.dw_privs}
end on

on pfc_cst_u_address_linked_data.destroy
destroy(this.dw_addr_head)
destroy(this.st_privs)
destroy(this.st_ids)
destroy(this.st_specs)
destroy(this.dw_ids)
destroy(this.dw_specs)
destroy(this.dw_privs)
end on

event constructor;//Start Code Change ----07.15.2014 #V14.2 maha
IF gi_priv_mod = 0 or w_mdi.of_security_access( 1310 ) = 0 or w_mdi.of_security_access( 210 ) = 0 then
	of_security( 1)
end if
end event

type dw_addr_head from datawindow within pfc_cst_u_address_linked_data
integer width = 2784
integer height = 84
integer taborder = 10
string title = "none"
string dataobject = "d_addr_linked_header"
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

type st_privs from statictext within pfc_cst_u_address_linked_data
integer y = 664
integer width = 2784
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Linked Privileges"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_ids from statictext within pfc_cst_u_address_linked_data
integer x = 1362
integer y = 88
integer width = 1422
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Linked Ids"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_specs from statictext within pfc_cst_u_address_linked_data
integer y = 88
integer width = 1362
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Linked Specialties"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_ids from u_dw within pfc_cst_u_address_linked_data
integer x = 1362
integer y = 160
integer width = 1422
integer height = 500
integer taborder = 10
string title = "Linked Ids"
string dataobject = "d_addr_net_dev_ids_prac_demog"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event pfc_deleterow;//override - skip
return 1
end event

type dw_specs from u_dw within pfc_cst_u_address_linked_data
integer y = 160
integer width = 1362
integer height = 500
integer taborder = 10
string title = "Linked Specialties"
string dataobject = "d_addr_linked_specs"
borderstyle borderstyle = stylebox!
end type

event retrieveend;call super::retrieveend;//Start Code Change ----06.30.2014 #V14.2 maha
integer rc
integer r

for r = 1 to this.rowcount()
	if isnull(this.getitemnumber(r, "addr_recid")) then
		this.setitem(r , "addr_recid", il_addrid )
		this.setitem(r , "spec_recid", this.getitemnumber(r, "pd_board_specialty_rec_id") )
		this.setitem(r , "prac_id", this.getitemnumber(r, "pd_board_specialty_prac_id") )
		this.setitem(r , "specialty", this.getitemnumber(r, "pd_board_specialty_specialty") )
		this.setitem(r , "practicing", 1 )
		this.setitemstatus( r, 0, primary!, newmodified!)
	end if
next

this.update()
end event

event pfc_deleterow;//override - skip
return 1
end event

type dw_privs from u_dw within pfc_cst_u_address_linked_data
integer y = 732
integer width = 2784
integer height = 1084
integer taborder = 10
string title = "Linked Privileges"
string dataobject = "d_addr_linked_privs"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event retrieveend;call super::retrieveend;//Start Code Change ----06.30.2014 #V14.2 maha
integer rc
integer r
long lid
boolean lb_new = false

for r = 1 to this.rowcount()
	if isnull(this.getitemnumber(r, "addr_recid")) then
		this.setitem(r , "addr_recid", il_addrid )
		this.setitem(r , "priv_recid", this.getitemnumber(r, "rec_id") )
		this.setitem(r , "link_prac_id", this.getitemnumber(r, "pd_priv_list_prac_id") )
		this.setitem(r , "link_procd_id", this.getitemnumber(r, "procd_id") )
		this.setitem(r , "practicing", 1 )
		this.setitemstatus( r, 0, primary!, newmodified!)
		lb_new = true
	end if
next

if lb_new then
	select max(apl_id ) into :lid from pd_addr_priv_link;
	if isnull(lid) then lid = 0
	for r = 1 to this.rowcount()
		if isnull(this.getitemnumber(r, "apl_id")) then
			lid++
			this.setitem(r, "apl_id", lid)
		end if 
	next
end if
	



this.update()
end event

event pfc_deleterow;call super::pfc_deleterow;//override - skip
return 1
end event

