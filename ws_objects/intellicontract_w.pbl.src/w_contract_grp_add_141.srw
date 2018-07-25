$PBExportHeader$w_contract_grp_add_141.srw
$PBExportComments$[intellicontract_w] Response window used for adding group practices to the location tab
forward
global type w_contract_grp_add_141 from w_response
end type
type st_1 from u_st_splitbar within w_contract_grp_add_141
end type
type cb_1 from u_cb within w_contract_grp_add_141
end type
type cb_close from u_cb within w_contract_grp_add_141
end type
type cb_ok from u_cb within w_contract_grp_add_141
end type
type dw_master from u_dw within w_contract_grp_add_141
end type
type dw_detail from u_dw within w_contract_grp_add_141
end type
type gb_1 from u_gb within w_contract_grp_add_141
end type
type gb_2 from u_gb within w_contract_grp_add_141
end type
end forward

global type w_contract_grp_add_141 from w_response
integer width = 3657
integer height = 1996
string title = "Find Group Location"
long backcolor = 32891346
st_1 st_1
cb_1 cb_1
cb_close cb_close
cb_ok cb_ok
dw_master dw_master
dw_detail dw_detail
gb_1 gb_1
gb_2 gb_2
end type
global w_contract_grp_add_141 w_contract_grp_add_141

type variables





//n_cst_dwsrv_find inv_find
PowerObject	 ipo

u_tabpg_contract_locations iw_locations_tabpage



n_ds ids_pracs  





//dragObject ipo2 //u_tabpg_contract_locations 
//window  iw_window
//
//iw_window  = w_contract



//ipo2 = u_tabpg_contract_locations 
end variables

forward prototypes
public subroutine of_insert_main_data ()
end prototypes

public subroutine of_insert_main_data ();//

long ll_row

iw_locations_tabpage.DW_Main.RESET()
iw_locations_tabpage.DW_detail.reset()

//iw_locations_tabpage.dw_phone.reset()

ll_row = iw_locations_tabpage.dw_main.insertrow(0)

iw_locations_tabpage.dw_main.SetItem( ll_row, "parent_comp_id",      dw_master.GetItemDecimal( dw_master.getrow(), "rec_id" ) )
iw_locations_tabpage.dw_main.SetItem( ll_row, "gp_name",      dw_master.GetItemString( dw_master.getrow(), "gp_name" ) )
iw_locations_tabpage.dw_main.SetItem( ll_row, "street1",      dw_master.GetItemString( dw_master.getrow(), "street1" ) )
iw_locations_tabpage.dw_main.SetItem( ll_row, "street2",      dw_master.GetItemString( dw_master.getrow(), "street2" ) )
iw_locations_tabpage.dw_main.SetItem( ll_row, "city",         dw_master.GetItemString( dw_master.getrow(), "city" ) )
iw_locations_tabpage.dw_main.SetItem( ll_row, "state",        dw_master.GetItemString( dw_master.getrow(), "state" ) )
iw_locations_tabpage.dw_main.SetItem( ll_row, "phone",        dw_master.GetItemString( dw_master.getrow(), "phone" ) )
iw_locations_tabpage.dw_main.SetItem( ll_row, "zip",          dw_master.GetItemString( dw_master.getrow(), "zip" ) )
iw_locations_tabpage.dw_main.SetItem( ll_row, "contact_name", dw_master.GetItemString( dw_master.getrow(), "contact_name" ))


end subroutine

on w_contract_grp_add_141.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_close=create cb_close
this.cb_ok=create cb_ok
this.dw_master=create dw_master
this.dw_detail=create dw_detail
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.dw_master
this.Control[iCurrent+6]=this.dw_detail
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.gb_2
end on

on w_contract_grp_add_141.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_close)
destroy(this.cb_ok)
destroy(this.dw_master)
destroy(this.dw_detail)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event pfc_postopen;call super::pfc_postopen;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  16 June 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


ids_pracs = create n_ds
ids_pracs.dataobject=  'd_ctx_group_practitioners'//'dS_contract_group_practitioners'
ids_pracs.settransobject(sqlca)

ipo = message.powerobjectparm	

iw_locations_tabpage = ipo

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// set the linkage stuff
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//dw_master.of_SetLinkage(true) // master datawindow
//dw_detail.of_SetLinkage(true)
//dw_master.inv_linkage.of_SetTransObject(SQLCA)
//dw_detail.inv_linkage.of_SetMaster(dw_master)
//dw_detail.inv_linkage.of_Register("rec_id", "REC_ID") 
//dw_detail.inv_linkage.of_SetStyle(n_cst_dwsrv_linkage.retrieve) 

dw_master.event pfc_retrieve( )
end event

type st_1 from u_st_splitbar within w_contract_grp_add_141
integer y = 768
integer width = 3584
integer height = 32
long backcolor = 128
boolean border = true
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;
this.of_Register (dw_master , ABOVE )
this.of_Register (gb_1,ABOVE )

this.of_Register (dw_detail , BELOW )
this.of_Register (gb_2,BELOW)


this.of_SetBarColor(rgb(128,0,0))
end event

type cb_1 from u_cb within w_contract_grp_add_141
integer x = 37
integer y = 1772
integer taborder = 41
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

type cb_close from u_cb within w_contract_grp_add_141
integer x = 3255
integer y = 1792
integer taborder = 31
string text = "&Cancel"
end type

event clicked;call super::clicked;



parent.event pfc_close( )
end event

type cb_ok from u_cb within w_contract_grp_add_141
integer x = 2889
integer y = 1792
integer taborder = 21
fontcharset fontcharset = ansi!
string text = "&OK"
end type

event clicked;call super::clicked;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  16 June 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

String	ls_GpName,ls_Street1,ls_Street2,ls_City,ls_Local
long 		ll_row
long 		ll_i
long 		ll_j
long 		ll_status
boolean	lb_found

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 2006-09-22 By: Liu Hongxin
//$<reason>: Perfermance tuning: This object is redundant. 
/*
n_ds lds_location_pracs
lds_location_pracs = create N_ds
lds_location_pracs.dataobject = 'ds_location_pracs'
lds_location_pracs.settransobject(sqlca)
*/
//---------------------------- APPEON END ----------------------------

iw_locations_tabpage.dw_doctors.of_SetFind(TRUE)

iw_locations_tabpage.setredraw( false)
iw_locations_tabpage.dw_main.rowcount()

//////////////////////////////////////////////////////////////////////////////////////
// if nothing is selected do not continue
//////////////////////////////////////////////////////////////////////////////////////

for ll_i = 1 to dw_detail.rowcount( )
	if dw_detail.object.selected[ll_i] = 1 and not lb_found then
		lb_found = true
		Exit	//continue
	end if
next

if not lb_found then
			iw_locations_tabpage.setredraw( true)						
else  

	if iw_locations_tabpage.dw_main.rowcount( ) > 0 then
		 if iw_locations_tabpage.dw_main.find("rec_id = " + string(dw_master.GetItemDecimal( dw_master.getrow(), "rec_id" ))  , 1, iw_locations_tabpage.dw_main.rowcount()) < 1 then
			 of_insert_main_data( )
		end if
		
	else
			of_insert_main_data( )
	end if 

	//////////////////////////////////////////////////////////////////////////////////////
	// detail items
	//////////////////////////////////////////////////////////////////////////////////////
	
	dw_Master.AcceptText()
	dw_Detail.AcceptText()
	
	ll_Row = dw_Master.GetRow()
	ls_GpName = dw_Master.GetItemString(ll_Row,"gp_name")
	if IsNull(ls_GpName) then ls_GpName = ""
	
	FOR ll_i = 1 TO dw_detail.rowcount( )
		if dw_detail.object.selected[ll_i] = 1 then
			LONG LL_RET 
			LL_RET = iw_locations_tabpage.dw_detail.find("loc_id = " + string(dw_detail.object.group_practice_rec_id[ll_i])  , 1, iw_locations_tabpage.dw_detail.rowcount())
			if LL_RET < 1 then
				iw_locations_tabpage.dw_detail.of_SetMultiTable(false)
				// before we add the row delete -- to fix bad code (this can be removed later) 18 June 2006 begin
				long ll_ctx_id
				long ll_parent_comp_id
				long ll_loc_id 
				
				 ll_ctx_id         = iw_locations_tabpage.inv_contract_details.of_get_ctx_id( )
				 ll_parent_comp_id = iw_locations_tabpage.dw_main.object.parent_comp_id[iw_locations_tabpage.dw_main.getrow()]
				 ll_loc_id         = dw_detail.object.group_practice_rec_id[ll_i]
				 
				delete from ctx_loc where ctx_id = :ll_ctx_id and parent_comp_id =:ll_parent_comp_id and loc_id = :ll_loc_id;
				// before we add the row delete -- to fix bad code (this can be removed later) 18 June 2006 end
				//Link Servers Bug - jervis 07.14.2010
				//ll_row = iw_locations_tabpage.dw_detail.event pfc_insertrow( )
				ll_row = iw_locations_tabpage.dw_detail.insertrow( 0)
				iw_locations_tabpage.dw_detail.SetItem( ll_row, "practice_type", dw_detail.GetItemDecimal( ll_i, "practice_type" ) )
				iw_locations_tabpage.dw_detail.SetItem( ll_row, "group_practice_street", dw_detail.GetItemString( ll_i, "group_practice_street" ) )
				iw_locations_tabpage.dw_detail.SetItem( ll_row, "group_practice_street_2", dw_detail.GetItemString( ll_i, "group_practice_street_2"  ))
				iw_locations_tabpage.dw_detail.SetItem( ll_row, "group_practice_city", dw_detail.GetItemString( ll_i, "group_practice_city" ) )
				iw_locations_tabpage.dw_detail.SetItem( ll_row, "tax_id", dw_detail.GetItemString( ll_i, "tax_id" ) )
				iw_locations_tabpage.dw_detail.setitem( ll_row ,"loc_id", dw_detail.object.group_practice_rec_id[ll_i])
				iw_locations_tabpage.dw_detail.setitem( ll_row ,"rec_id", dw_detail.object.group_practice_rec_id[ll_i])
				
				ls_Street1 = dw_Detail.GetItemString(ll_i,"group_practice_street")
				ls_Street2 = dw_Detail.GetItemString(ll_i,"group_practice_street_2")
				ls_City = dw_Detail.GetItemString(ll_i,"group_practice_city")
				
				if IsNull(ls_Street1) then ls_Street1 = ""
				if IsNull(ls_Street2) then ls_Street2 = ""
				if IsNull(ls_City) then ls_City = ""
				
				ls_Local = ls_GpName + " - " + ls_Street1 + " " + ls_Street2 + ", " + ls_City
				
				iw_locations_tabpage.dw_detail.SetItem( ll_Row ,"local", ls_Local)
			end if
			 
	
			 //////////////////////////////////////////////////////////////////////////////////////////////
			 // add the practitioners -- not here in the tab
			 //////////////////////////////////////////////////////////////////////////////////////////////
	   end if 				
	NEXT
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2006-09-20 By: Liu Hongxin
	//$<reason> Performance tuning: Reduce Calls.
	/*
	iw_locations_tabpage.OF_Update( TRUE, TRUE)
	lds_location_pracs.of_update(true, true)  
	//iw_locations_tabpage.of_retrieve( ) -- nope
	iw_locations_tabpage.DW_main.event pfc_retrieve( )
	iw_locations_tabpage.dw_main.SelectRow(0, FALSE)
	//	iw_locations_tabpage.dw_detail.SelectRow(0, FALSE)
	iw_locations_tabpage.dw_main.SelectRow(1, TRUE)
	*/
	
	gnv_appeondb.of_StartQueue()
	iw_locations_tabpage.OF_Update( TRUE, TRUE)
	//iw_locations_tabpage.of_retrieve( ) -- nope
	iw_locations_tabpage.DW_main.Reset()
	iw_locations_tabpage.DW_main.event pfc_retrieve( )
	gnv_appeondb.of_CommitQueue()
	
	ll_row = iw_locations_tabpage.dw_main.Find("parent_comp_id = " + String(dw_master.GetItemDecimal( dw_master.getrow(), "rec_id" )), 1, iw_locations_tabpage.dw_main.RowCount())
	if ll_row < 1 then ll_row = 1
	if iw_locations_tabpage.dw_main.RowCount() > 0 then
		iw_locations_tabpage.dw_main.SelectRow(0, FALSE)
		iw_locations_tabpage.dw_main.SelectRow(ll_row, TRUE)
		iw_locations_tabpage.dw_main.SetRow(ll_row)
	end if
	//---------------------------- APPEON END ----------------------------

end if //if not lb_found then

iw_locations_tabpage.setredraw( true)

CLOSE(PARENT)

end event

type dw_master from u_dw within w_contract_grp_add_141
string tag = "Parent Group"
integer x = 37
integer y = 4
integer width = 3547
integer height = 756
integer taborder = 20
boolean titlebar = true
string title = "Parent Group"
string dataobject = "d_contract_multi_group_browse_search"
boolean hscrollbar = true
boolean ib_isupdateable = false
end type

event constructor;//Add sort - jervis 05.04.2010
this.of_SetSort( true)
this.inv_sort.of_setcolumnheader(true)


dw_master.of_SetLinkage(true) // master datawindow
dw_detail.of_SetLinkage(true)
dw_master.inv_linkage.of_SetTransObject(SQLCA)
dw_detail.inv_linkage.of_SetMaster(dw_master)
dw_detail.inv_linkage.of_Register("rec_id", "rec_id") 
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01 
//$<modify> 01.16.2006 By: LeiWei
//$<reason> It is unsupported on the Web to use an object without creating it first.
//$<modification> Create the object first and then use it.
//dw_detail.inv_linkage.of_SetStyle(n_cst_dwsrv_linkage.retrieve) 
n_cst_dwsrv_linkage lnv_cst_dwsrv_linkage
lnv_cst_dwsrv_linkage = Create n_cst_dwsrv_linkage
dw_detail.inv_linkage.of_SetStyle(lnv_cst_dwsrv_linkage.retrieve) 
Destroy lnv_cst_dwsrv_linkage
//---------------------------- APPEON END ----------------------------

this.of_SetRowManager(TRUE)
this.of_setrowselect( true)
this.inv_rowselect.of_SetStyle(this.inv_rowselect.single )


end event

event pfc_retrieve;call super::pfc_retrieve;


retrieve( )

return success
end event

type dw_detail from u_dw within w_contract_grp_add_141
string tag = "Associated Location"
integer x = 37
integer y = 820
integer width = 3547
integer height = 924
integer taborder = 10
boolean titlebar = true
string title = "Associated Location"
string dataobject = "d_contract_group_linked_locations_search"
boolean hscrollbar = true
boolean ib_isupdateable = false
end type

event itemchanged;//

//dw_detail.inv_linkage.of_SetTransObject(SQLCA)
end event

event retrieveend;call super::retrieveend;











cb_1.text =  'Select All'
end event

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

type gb_1 from u_gb within w_contract_grp_add_141
boolean visible = false
integer width = 3621
integer height = 832
integer taborder = 11
long backcolor = 32891346
string text = "Parent Organization"
end type

type gb_2 from u_gb within w_contract_grp_add_141
boolean visible = false
integer y = 832
integer width = 3621
integer height = 928
integer taborder = 11
long backcolor = 32891346
string text = "Associated Group / Location"
end type

