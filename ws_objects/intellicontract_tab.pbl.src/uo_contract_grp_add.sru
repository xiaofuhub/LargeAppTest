$PBExportHeader$uo_contract_grp_add.sru
forward
global type uo_contract_grp_add from userobject
end type
type dw_detail from u_dw within uo_contract_grp_add
end type
type cb_ok from u_cb within uo_contract_grp_add
end type
type cb_close from u_cb within uo_contract_grp_add
end type
type cb_1 from u_cb within uo_contract_grp_add
end type
type cb_2 from commandbutton within uo_contract_grp_add
end type
type dw_search from u_dw within uo_contract_grp_add
end type
type st_none from statictext within uo_contract_grp_add
end type
type cbx_valid from checkbox within uo_contract_grp_add
end type
type cb_clear from commandbutton within uo_contract_grp_add
end type
end forward

global type uo_contract_grp_add from userobject
integer width = 3621
integer height = 1896
long backcolor = 33551856
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_detail dw_detail
cb_ok cb_ok
cb_close cb_close
cb_1 cb_1
cb_2 cb_2
dw_search dw_search
st_none st_none
cbx_valid cbx_valid
cb_clear cb_clear
end type
global uo_contract_grp_add uo_contract_grp_add

type variables
long il_group_id
long il_ctx_id
u_tabpg_contract_locations iw_locations_tabpage
n_ds ids_pracs

powerobject ipo
end variables

forward prototypes
public function integer of_add_data (long al_ctx)
public function integer of_search_locations ()
public subroutine of_post_open ()
end prototypes

public function integer of_add_data (long al_ctx); //Start Code Change ----03.17.2015 #V15 maha - Copied from original split window and modified to create new data in this screen rather than the locations tab

String	ls_GpName,ls_Street1,ls_Street2,ls_City,ls_Local
long 		ll_row
long 		ll_i
long 		ll_j
long 		ll_status
long ll_group_id  //maha 03.16.2015
long ll_rec_id  //maha 03.16.2015
long ll_ctx_id
long ll_parent_comp_id
long ll_loc_id 
long ll_prac_id  //maha 05.29.2015
long p,  pc , nr //maha 05.29.2015
LONG LL_RET
boolean	lb_found
n_ds lds_group  //maha 05.28.2015
n_ds lds_location //maha 05.28.2015
n_ds lds_prac_get //maha 05.28.2015
n_ds lds_prac_add //maha 05.28.2015

iw_locations_tabpage.dw_doctors.of_SetFind(TRUE)

iw_locations_tabpage.setredraw( false)
iw_locations_tabpage.dw_main.rowcount()

dw_Detail.AcceptText()

// if nothing is selected do not continue
for ll_i = 1 to dw_detail.rowcount( )
	if dw_detail.object.selected[ll_i] = 1 and not lb_found then
		lb_found = true
		Exit	//continue
	end if
next

if not lb_found then
	iw_locations_tabpage.setredraw( true)						
else  
	//skip
end if

 //Start Code Change ----05.28.2015 #V15 maha
lds_group = create n_ds
lds_location = create n_ds
lds_prac_get = create n_ds
lds_prac_add = create n_ds

lds_group.dataobject = "d_ctx_loc_linked_group"
lds_location.dataobject = "d_ctx_loc_linked_location"
lds_prac_add.dataobject = "d_ctx_location_pracs_copy"
lds_prac_get.dataobject = "d_group_practitioners"

lds_group.settransobject(sqlca)
lds_location.settransobject(sqlca)
lds_prac_get.settransobject(sqlca)
lds_prac_add.settransobject(sqlca)

select lookup_code into :ll_status from code_lookup where lookup_name = 'Contract Practitioner Contract Stat' and code = 'Not Par.';

ll_ctx_id = al_ctx
 
 lds_group.retrieve(ll_ctx_id)
 lds_location.retrieve(ll_ctx_id)
 //End Code Change ----05.28.2015
 select max(record_id) into :ll_rec_id from ctx_loc;
 if isnull(ll_rec_id) then ll_rec_id = 0

FOR ll_i = 1 TO dw_detail.rowcount( )
	if dw_detail.object.selected[ll_i] = 1 then
		//first get the group data
		ll_group_id = dw_detail.GetItemDecimal(ll_i, "group_loc_link_group_id" )
		ll_loc_id =dw_detail.object.group_practice_rec_id[ll_i] //##########
		ls_GpName = dw_detail.GetItemString(ll_i,"gp_name") //#########
		if IsNull(ls_GpName) then ls_GpName = ""
		
		if lds_group.find("parent_comp_id = " + string(ll_group_id)  , 1, lds_group.rowcount()) = 0 then
			ll_row = lds_group.insertrow(0)
			lds_group.SetItem( ll_row, "parent_comp_id",  ll_group_id )
			lds_group.SetItem( ll_row, "ctx_id",      ll_ctx_id )
			lds_group.SetItem( ll_row, "loc_id",      0)
			ll_rec_id++
			lds_group.SetItem( ll_row, "record_id",  ll_rec_id )
			lds_group.SetItem( ll_row, "inserted_by_user",  gs_user_id ) 
			lds_group.SetItem( ll_row, "inserted_at_date_time", datetime(today(),now()))
		end if
		
		
		if lds_location.find("loc_id = " + string(ll_loc_id) + " and parent_comp_id = " + string(ll_group_id) , 1,lds_location.rowcount()) = 0 then
			ll_row = lds_location.insertrow( 0)
			
			ls_Street1 = dw_Detail.GetItemString(ll_i,"group_practice_street")
			if IsNull(ls_Street1) then ls_Street1 = ""
			ls_Street2 = dw_Detail.GetItemString(ll_i,"group_practice_street_2")
			if IsNull(ls_Street2) then ls_Street2 = ""
			ls_City = dw_Detail.GetItemString(ll_i,"group_practice_city")
			if IsNull(ls_City) then ls_City = ""
			ls_Local = ls_GpName + " - " + ls_Street1 + " " + ls_Street2 + ", " + ls_City		
			lds_location.SetItem( ll_Row ,"local", ls_Local)	
			
			lds_location.SetItem( ll_row, "parent_comp_id",  ll_group_id )
			lds_location.SetItem( ll_row, "ctx_id",      ll_ctx_id )
			lds_location.SetItem( ll_row, "loc_id",      ll_loc_id)
			ll_rec_id++
			lds_location.SetItem( ll_row, "record_id",  ll_rec_id )
			lds_location.SetItem( ll_row, "inserted_by_user",  gs_user_id )
			lds_group.SetItem( ll_row, "inserted_at_date_time", datetime(today(),now()))
			
			 //Start Code Change ----05.29.2015 #V15 maha - prac records
			//provider adds
			pc = lds_prac_get.retrieve(ll_loc_id)
			
			for p = 1 to pc
				ll_prac_id = lds_prac_get.getitemnumber(p,"pd_address_prac_id")
				
				nr = lds_prac_add.insertrow(0)
				lds_prac_add.setitem(nr,"ctx_id", ll_ctx_id)
				lds_prac_add.setitem(nr,"parent_comp_id",ll_group_id)
				lds_prac_add.setitem(nr,"loc_id",ll_loc_id)
				lds_prac_add.setitem(nr,"gp_rec_id",ll_loc_id)
				lds_prac_add.setitem(nr,"prac_id",ll_prac_id)
				lds_prac_add.setitem(nr,"status", ll_status)
			next
		end if
		 

		 //////////////////////////////////////////////////////////////////////////////////////////////
		 // add the practitioners -- not here in the tab
		 //////////////////////////////////////////////////////////////////////////////////////////////
   end if 				
NEXT

 //Start Code Change ----05.28.2015 #V15 maha
gnv_appeondb.of_StartQueue()
 
lds_group.update()
lds_location.update()
lds_prac_add.update()

 
 gnv_appeondb.of_CommitQueue()
 
destroy lds_group
destroy lds_location
destroy lds_prac_get
destroy lds_prac_add
 //End Code Change ----05.28.2015
	

	//---------------------------- APPEON END ----------------------------

//end if //if not lb_found then


//move to outside of function
ll_row = iw_locations_tabpage.dw_main.Find("parent_comp_id = " + String(ll_group_id), 1, iw_locations_tabpage.dw_main.RowCount())
if ll_row < 1 then ll_row = 1
if iw_locations_tabpage.dw_main.RowCount() > 0 then
	iw_locations_tabpage.dw_main.SelectRow(0, FALSE)
	iw_locations_tabpage.dw_main.SelectRow(ll_row, TRUE)
	iw_locations_tabpage.dw_main.SetRow(ll_row)
end if
iw_locations_tabpage.DW_main.Reset()
iw_locations_tabpage.DW_main.event pfc_retrieve( )
iw_locations_tabpage.setredraw( true)
//CLOSE(PARENT)

return 1

end function

public function integer of_search_locations ();//Start Code Change ----08.09.2010 #V10 maha - added for modification of the search functionality

integer i
integer li_rc
integer c
integer res
string stype
string scrit
string ls_where = ""
string ls_criteria[]
string ls_type[]
string ls_ret  //maha 01.16.2014
boolean lb_loc_only = true

st_none.visible = false  //Start Code Change ----01.16.2014 #V14 maha
//IF tab_2.tabpage_browse.rb_l_p.checked = true then lb_loc_only = false//practitioners and locations	

li_rc =  dw_search.rowcount()

FOR i = 1 TO li_rc
	stype =  dw_search.GetItemString( i, "search_type" )
	
	 if lb_loc_only = true then
		if stype = "Specialty" or stype = "Language" or stype = "Provider_type" then
			Messagebox("Search Error","You cannot use " + stype + " as a search criteria for a Locations Only search.")
			return 0
		end if
	end if
	
	scrit =  dw_search.GetItemString( i, "criteria" )
	
	if	cbx_valid.checked then
		ls_ret = of_validate_crit(stype, scrit)
		choose case ls_ret
			case "OK"
				//continue
			case "NUM"
				messagebox("Search Validation", "The criteria for " + stype + " must be a numeric value.")
				return -1
			case "NPI"
				messagebox("Search Validation", "The criteria for " + stype + " must be a 10 digits.")
				return -1
			case "TAX"
				messagebox("Search Validation", "The criteria for " + stype + " must be a 9 digits.")
				return -1
		end choose
	end if
	
	//Start Code Change ----11.18.2013 #V14 maha
	if stype = "proup_practice_active_status" then
		choose case scrit
			case "INACTIVE"
				scrit = '0'
			case else
				scrit = '1'
		end choose
	end if
	//End Code Change ----11.18.2013 
	
	IF IsNull( stype ) or isnull(scrit) THEN
		CONTINUE
	else 
		c++
		ls_type[c ] = stype
		ls_criteria[c ] = scrit
	end if
	
NEXT
debugbreak()

SetRedraw(FALSE)

if dw_detail.rowcount() = 0 then 
	dw_detail.retrieve()
	dw_detail.setfilter("")
	dw_detail.filter()
end if

if c = 0 then 
	SetRedraw(TRUE)
	return 1
end if
//messagebox("","returieve")
For i = 1 to c
	choose case ls_type[i ]
		case "code_lookup_state",  "code_lookup_county",  "code_lookup_ptype"
			ls_where = ls_where + "pos(Upper(" + ls_type[i] + "), '" + Upper( ls_criteria[i]) + "' ,1) > 0 AND "	
		case "rec_id"  //Start Code Change ----12.05.2012 #V12 maha
			ls_where = ls_where + " " + ls_type[i] + " = " +  ls_criteria[i] + "  AND "	
		case "group_practice_active_status"  //Start Code Change ----11.18.2013 #V14 maha
			ls_where = ls_where +  ls_type[i] + " = " + ls_criteria[i] + " AND "	
		case else
		//	ls_where = ls_where + "Upper(" + ls_type[i] + ") like '" + Upper( ls_criteria[i]) + "%' AND "	
			ls_where = ls_where + "pos(Upper(" + ls_type[i] + "), '" + Upper( ls_criteria[i]) + "' ,1) > 0 AND "	
	end choose
next

ls_where = mid(  ls_where, 1, Len( ls_where ) - 5 )


res =  dw_detail.setfilter(ls_where)
if res < 0 then 
	SetRedraw(TRUE)
	Messagebox("Setfilter","Error in w_group_practice cb_search::clicked:~r " + ls_where )
	return 0

end if

 dw_detail.filter()
 
	//Start Code Change ----01.16.2014 #V14 maha
if dw_detail.rowcount() = 0 then
	//messagebox('none',"")
	st_none.visible = true
end if
	//End Code Change ----01.16.2014

SetRedraw(TRUE) 


return 1
end function

public subroutine of_post_open ();ids_pracs = create n_ds
ids_pracs.dataobject=  'd_ctx_group_practitioners'//'dS_contract_group_practitioners'
ids_pracs.settransobject(sqlca)


ipo = message.powerobjectparm	

iw_locations_tabpage = ipo

il_ctx_id = iw_locations_tabpage.inv_contract_details.of_get_ctx_id( )
//messagebox("",il_ctx_id)

dw_detail.retrieve()

dw_search.of_setupdateable( false)
end subroutine

on uo_contract_grp_add.create
this.dw_detail=create dw_detail
this.cb_ok=create cb_ok
this.cb_close=create cb_close
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_search=create dw_search
this.st_none=create st_none
this.cbx_valid=create cbx_valid
this.cb_clear=create cb_clear
this.Control[]={this.dw_detail,&
this.cb_ok,&
this.cb_close,&
this.cb_1,&
this.cb_2,&
this.dw_search,&
this.st_none,&
this.cbx_valid,&
this.cb_clear}
end on

on uo_contract_grp_add.destroy
destroy(this.dw_detail)
destroy(this.cb_ok)
destroy(this.cb_close)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_search)
destroy(this.st_none)
destroy(this.cbx_valid)
destroy(this.cb_clear)
end on

event destructor;if isvalid(ids_pracs) then destroy ids_pracs
end event

type dw_detail from u_dw within uo_contract_grp_add
string tag = "Associated Location"
integer x = 32
integer y = 380
integer width = 3547
integer height = 1484
integer taborder = 20
boolean titlebar = true
string title = "Groups/Locations"
string dataobject = "d_ctx_location_select_tv"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-04-18 By: Scofield
//$<Reason> Retrieve state data to display code.

long	ll_RowCnt
DataWindowChild ldwc_Child

This.GetChild("state",ldwc_Child)
ldwc_Child.SetTransObject(SQLCA)
ll_RowCnt = ldwc_Child.Retrieve("state")

if ll_RowCnt <= 0 then ldwc_Child.InsertRow(0)
//---------------------------- APPEON END ----------------------------


//Add sort - jervis 05.04.2010
this.of_SetSort( true)
this.inv_sort.of_setcolumnheader(true)
end event

event itemchanged;//

//dw_detail.inv_linkage.of_SetTransObject(SQLCA)
end event

event retrieveend;call super::retrieveend;











cb_1.text =  'Select All'
end event

type cb_ok from u_cb within uo_contract_grp_add
boolean visible = false
integer x = 2912
integer y = 280
integer width = 87
integer taborder = 10
fontcharset fontcharset = ansi!
string text = "&OK"
end type

event clicked;call super::clicked; //Start Code Change ----03.17.2015 #V15 maha - Copied from original split window and modified to create new data in this screen rather than the locations tab

String	ls_GpName,ls_Street1,ls_Street2,ls_City,ls_Local
long 		ll_row
long 		ll_i
long 		ll_j
long 		ll_status
long ll_group_id  //maha 03.16.2015
long ll_rec_id  //maha 03.16.2015
long ll_ctx_id
long ll_parent_comp_id
long ll_loc_id 
long ll_prac_id  //maha 05.29.2015
long p,  pc , nr //maha 05.29.2015
LONG LL_RET
boolean	lb_found
n_ds lds_group  //maha 05.28.2015
n_ds lds_location //maha 05.28.2015
n_ds lds_prac_get //maha 05.28.2015
n_ds lds_prac_add //maha 05.28.2015

iw_locations_tabpage.dw_doctors.of_SetFind(TRUE)

iw_locations_tabpage.setredraw( false)
iw_locations_tabpage.dw_main.rowcount()
dw_Detail.AcceptText()

// if nothing is selected do not continue
for ll_i = 1 to dw_detail.rowcount( )
	if dw_detail.object.selected[ll_i] = 1 and not lb_found then
		lb_found = true
		Exit	//continue
	end if
next

if not lb_found then
	iw_locations_tabpage.setredraw( true)						
else  
	//skip
end if

 //Start Code Change ----05.28.2015 #V15 maha
lds_group = create n_ds
lds_location = create n_ds
lds_prac_get = create n_ds
lds_prac_add = create n_ds

lds_group.dataobject = "d_ctx_loc_linked_group"
lds_location.dataobject = "d_ctx_loc_linked_location"
lds_prac_add.dataobject = "d_ctx_location_pracs_copy"
lds_prac_get.dataobject = "d_group_practitioners"

lds_group.settransobject(sqlca)
lds_location.settransobject(sqlca)
lds_prac_get.settransobject(sqlca)
lds_prac_add.settransobject(sqlca)

select lookup_code into :ll_status from code_lookup where lookup_name = 'Contract Practitioner Contract Stat' and code = 'Not Par.';

 ll_ctx_id = iw_locations_tabpage.inv_contract_details.of_get_ctx_id( )
 
 lds_group.retrieve(ll_ctx_id)
 lds_location.retrieve(ll_ctx_id)
 //End Code Change ----05.28.2015
 select max(record_id) into :ll_rec_id from ctx_loc;
 if isnull(ll_rec_id) then ll_rec_id = 0

FOR ll_i = 1 TO dw_detail.rowcount( )
	if dw_detail.object.selected[ll_i] = 1 then
		//first get the group data
		ll_group_id = dw_detail.GetItemDecimal(ll_i, "group_loc_link_group_id" )
		ll_loc_id =dw_detail.object.group_practice_rec_id[ll_i] //##########
		ls_GpName = dw_detail.GetItemString(ll_i,"gp_name") //#########
		if IsNull(ls_GpName) then ls_GpName = ""
		
		if lds_group.find("parent_comp_id = " + string(ll_group_id)  , 1, lds_group.rowcount()) = 0 then
			ll_row = lds_group.insertrow(0)
			lds_group.SetItem( ll_row, "parent_comp_id",  ll_group_id )
			lds_group.SetItem( ll_row, "ctx_id",      ll_ctx_id )
			lds_group.SetItem( ll_row, "loc_id",      0)
			ll_rec_id++
			lds_group.SetItem( ll_row, "record_id",  ll_rec_id )
			lds_group.SetItem( ll_row, "inserted_by_user",  gs_user_id ) 
			lds_group.SetItem( ll_row, "inserted_at_date_time", datetime(today(),now()))
		end if
		
		
		if lds_location.find("loc_id = " + string(ll_loc_id) + " and parent_comp_id = " + string(ll_group_id) , 1,lds_location.rowcount()) = 0 then
			ll_row = lds_location.insertrow( 0)
			
			ls_Street1 = dw_Detail.GetItemString(ll_i,"group_practice_street")
			if IsNull(ls_Street1) then ls_Street1 = ""
			ls_Street2 = dw_Detail.GetItemString(ll_i,"group_practice_street_2")
			if IsNull(ls_Street2) then ls_Street2 = ""
			ls_City = dw_Detail.GetItemString(ll_i,"group_practice_city")
			if IsNull(ls_City) then ls_City = ""
			ls_Local = ls_GpName + " - " + ls_Street1 + " " + ls_Street2 + ", " + ls_City		
			lds_location.SetItem( ll_Row ,"local", ls_Local)	
			
			lds_location.SetItem( ll_row, "parent_comp_id",  ll_group_id )
			lds_location.SetItem( ll_row, "ctx_id",      ll_ctx_id )
			lds_location.SetItem( ll_row, "loc_id",      ll_loc_id)
			ll_rec_id++
			lds_location.SetItem( ll_row, "record_id",  ll_rec_id )
			lds_location.SetItem( ll_row, "inserted_by_user",  gs_user_id )
			lds_group.SetItem( ll_row, "inserted_at_date_time", datetime(today(),now()))
			
			 //Start Code Change ----05.29.2015 #V15 maha - prac records
			//provider adds
			pc = lds_prac_get.retrieve(ll_loc_id)
			
			for p = 1 to pc
				ll_prac_id = lds_prac_get.getitemnumber(p,"pd_address_prac_id")
				
				nr = lds_prac_add.insertrow(0)
				lds_prac_add.setitem(nr,"ctx_id", ll_ctx_id)
				lds_prac_add.setitem(nr,"parent_comp_id",ll_group_id)
				lds_prac_add.setitem(nr,"loc_id",ll_loc_id)
				lds_prac_add.setitem(nr,"gp_rec_id",ll_loc_id)
				lds_prac_add.setitem(nr,"prac_id",ll_prac_id)
				lds_prac_add.setitem(nr,"status", ll_status)
			next
		end if
		 

		 //////////////////////////////////////////////////////////////////////////////////////////////
		 // add the practitioners -- not here in the tab
		 //////////////////////////////////////////////////////////////////////////////////////////////
   end if 				
NEXT

 //Start Code Change ----05.28.2015 #V15 maha
gnv_appeondb.of_StartQueue()
 
lds_group.update()
lds_location.update()
lds_prac_add.update()
iw_locations_tabpage.DW_main.Reset()
iw_locations_tabpage.DW_main.event pfc_retrieve( )
 
 gnv_appeondb.of_CommitQueue()
 
destroy lds_group
destroy lds_location
destroy lds_prac_get
destroy lds_prac_add
 //End Code Change ----05.28.2015
	
ll_row = iw_locations_tabpage.dw_main.Find("parent_comp_id = " + String(ll_group_id), 1, iw_locations_tabpage.dw_main.RowCount())
if ll_row < 1 then ll_row = 1
if iw_locations_tabpage.dw_main.RowCount() > 0 then
	iw_locations_tabpage.dw_main.SelectRow(0, FALSE)
	iw_locations_tabpage.dw_main.SelectRow(ll_row, TRUE)
	iw_locations_tabpage.dw_main.SetRow(ll_row)
end if
	//---------------------------- APPEON END ----------------------------

//end if //if not lb_found then

iw_locations_tabpage.setredraw( true)

//CLOSE(PARENT)

end event

type cb_close from u_cb within uo_contract_grp_add
boolean visible = false
integer x = 3008
integer y = 280
integer width = 82
integer taborder = 10
string text = "&Cancel"
end type

event clicked;call super::clicked;
//Close(parent)
end event

type cb_1 from u_cb within uo_contract_grp_add
integer x = 59
integer y = 388
integer taborder = 20
fontcharset fontcharset = ansi!
string text = "Select All"
end type

event clicked;call super::clicked;

long ll_i
choose case this.text
	case 'Select All'
      for ll_i = 1 to dw_detail.rowcount()
	      dw_detail.object.selected[ll_i] = 1
		next
		this.text = 'Deselect All'
	case else
		for ll_i = 1 to dw_detail.rowcount()
	      dw_detail.object.selected[ll_i] = 0
		next
		this.text =  'Select All'
end choose
	
dw_detail.accepttext( )
end event

type cb_2 from commandbutton within uo_contract_grp_add
integer x = 2171
integer y = 100
integer width = 393
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter Locations"
end type

event clicked; //Start Code Change ----03.16.2015 #V15 maha - copied from group screen
Integer i
Integer li_rc
String ls_where
string stype
string ls_criteria

ls_where = " and " 
li_rc = dw_search.RowCount() 
dw_search.AcceptText()

SetPointer(HourGlass!) //alfee 12.12.2008


of_search_locations()



end event

type dw_search from u_dw within uo_contract_grp_add
integer x = 37
integer y = 20
integer width = 2112
integer height = 348
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_group_search_ctx"
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_SetUpdateAble( False )
This.InsertRow( 0 )
This.InsertRow( 0 )
This.InsertRow( 0 )
//This.InsertRow( 0 )				//Added by Scofield on 2008-03-17

//This.SetItem( 1, "search_type", "street" )

end event

event itemchanged;call super::itemchanged; //Start Code Change ----03.17.2015 #V15 maha

DataWindowChild dwchild
string ls_lookup
integer d
string ss
debugbreak()
IF This.GetColumnName() = "search_type" THEN
	//messagebox("",upper(data))
	this.setitem(1,"criteria","")
	Choose case upper(data) 
		case "GROUP_PRACTICE_ACTIVE_STATUS"
			d = This.GetChild( "criteria", dwchild )
			ss = this.Modify("criteria.dddw.name = 'd_code_lookup_active_address'")
			ss = this.Modify("criteria.dddw.datacolumn = 'description'")			
			ss = this.Modify("criteria.dddw.displaycolumn = 'description'")
			d = dwchild.SetTransObject( SQLCA )
			//d = dwchild.retrieve()
//		CASE  "CODE_LOOKUP_STATE"
//			ss = this.Modify("criteria.dddw.name = 'd_dddw_code_lookup_state'")
//			ss = this.Modify("criteria.dddw.datacolumn = 'lookup_code'")			
//			ss = this.Modify("criteria.dddw.displaycolumn = 'description'")
//			d = This.GetChild( "criteria", dwchild )
//			d = dwchild.SetTransObject( SQLCA )
//			d = dwchild.retrieve()
		CASE "CODE_LOOKUP_COUNTY", "CODE_LOOKUP_STATE",  "CODE_LOOKUP_PTYPE" 
			if upper(data)  = "CODE_LOOKUP_COUNTY" then
				ls_lookup = "County"
			elseif upper(data)  = "CODE_LOOKUP_STATE" then
				ls_lookup = "State"
			elseif upper(data)  = "CODE_LOOKUP_PTYPE" then
				ls_lookup = "Provider Type"
			end if
			
			this.Modify("criteria.dddw.name = 'd_dddw_code_lookup'")
			this.Modify("criteria.dddw.datacolumn = 'description'")			
			this.Modify("criteria.dddw.displaycolumn = 'description'")
			d = This.GetChild( "criteria", dwchild )
			d = dwchild.SetTransObject( SQLCA )
			//the retrieve is in the dropdown event
			//d = dwchild.retrieve(ls_lookup)
		CASE ELSE
			dwchild.reset()
	END CHOOSE
END IF


this.setcolumn( "criteria")


end event

event rowfocuschanged;call super::rowfocuschanged;if this.rowcount() < 1 then return //maha 092903
//IF This.GetColumnName() = "search_type" THEN
	DataWindowChild dwchild
	This.GetChild( "criteria", dwchild )
	dwchild.SetTransObject( SQLCA )
	CHOOSE CASE Upper( This.GetItemString( currentrow, "search_type" ))
		CASE "COUNTY"
			dwchild.Retrieve("county")	
		CASE "STATE"
			dwchild.Retrieve("State")			
		CASE "LANGUAGE"
			dwchild.Retrieve("Foreign Languages")					
		CASE "SPECIALTY"
			dwchild.Retrieve("PRACTITIONER SPECIALTIES")			
		CASE "PROVIDER_TYPE"
			dwchild.Retrieve("Provider Types")						
	END CHOOSE
//END IF




end event

event dropdown;call super::dropdown;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-04-16 By: Scofield
//$<Reason> Refresh the drop down datawindow value

String	ls_Type
long		ll_Row

DataWindowChild ldwc_Child

if This.GetColumnName() = "criteria" then
	This.GetChild("criteria",ldwc_Child)
	ldwc_Child.SetTransObject(SQLCA)
	
	ll_Row = This.GetRow()
	ls_Type = This.GetItemString(ll_Row,'search_type')
	Choose Case Upper(ls_Type)
		Case "CODE_LOOKUP_COUNTY"
			ldwc_Child.Retrieve("County")
		Case "CODE_LOOKUP_STATE"
			ldwc_Child.Retrieve("State")
		Case "CODE_LOOKUP_PTYPE"  //Start Code Change ----11.18.2013 maha V14
			ldwc_Child.Retrieve("Practice Type")
		case "GROUP_PRACTICE_ACTIVE_STATUS"
			//nothing
		Case else
			ldwc_Child.Reset()
	End Choose
End if
//---------------------------- APPEON END ----------------------------

end event

type st_none from statictext within uo_contract_grp_add
boolean visible = false
integer x = 2181
integer y = 288
integer width = 681
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "No results Found"
boolean focusrectangle = false
end type

type cbx_valid from checkbox within uo_contract_grp_add
integer x = 2176
integer y = 28
integer width = 736
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Validate Numeric Values"
end type

type cb_clear from commandbutton within uo_contract_grp_add
integer x = 2176
integer y = 196
integer width = 384
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear Filter"
end type

event clicked;//Start Code Change ----08.09.2010 #V10 maha

st_none.visible = false  //Start Code Change ----01.16.2014 #V14 maha

dw_search.Reset()
dw_search.InsertRow( 0 )
dw_search.InsertRow( 0 )
dw_search.InsertRow( 0 )

dw_detail.setfilter("")
dw_detail.filter()

//dw_detail.SetSqlSelect( is_sql)

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-03-17 By: Scofield
//$<Reason> Reset update table to allow deletes.

//dw_detail.SetTransObject( SQLCA )
//dw_detail.Modify("DataWindow.Table.updatetable='group_practice'")
////---------------------------- APPEON END ----------------------------
//
//dw_detail.retrieve()
//of_change_row()  //Start Code Change ----04.21.2011 #V11 maha


//dw_search.Reset()
//dw_search.InsertRow( 0 )
//dw_search.InsertRow( 0 )
//dw_search.InsertRow( 0 )
//dw_search.InsertRow( 0 )
//
//dw_detail.SetSqlSelect( is_sql)
//
////--------------------------- APPEON BEGIN ---------------------------
////$< Add  > 2008-03-17 By: Scofield
////$<Reason> Reset update table to allow deletes.
//
//dw_detail.SetTransObject( SQLCA )
//dw_detail.Modify("DataWindow.Table.updatetable='group_practice'")
////---------------------------- APPEON END ----------------------------
//
//dw_detail.retrieve()

end event

