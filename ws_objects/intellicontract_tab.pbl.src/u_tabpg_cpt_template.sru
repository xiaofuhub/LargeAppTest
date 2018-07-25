$PBExportHeader$u_tabpg_cpt_template.sru
$PBExportComments$[intellicontract_tab] Used to create templates
forward
global type u_tabpg_cpt_template from u_tabpg_contract_master
end type
type dw_detail from u_dw_contract within u_tabpg_cpt_template
end type
type dw_master from u_dw_contract within u_tabpg_cpt_template
end type
type cb_delete from commandbutton within u_tabpg_cpt_template
end type
type cb_insert from u_cb within u_tabpg_cpt_template
end type
type gb_1 from u_gb within u_tabpg_cpt_template
end type
type gb_2 from u_gb within u_tabpg_cpt_template
end type
type cb_2 from u_cb within u_tabpg_cpt_template
end type
type cb_4 from u_cb within u_tabpg_cpt_template
end type
type cb_select from u_cb within u_tabpg_cpt_template
end type
type cb_selectall from commandbutton within u_tabpg_cpt_template
end type
type cb_sort from u_cb within u_tabpg_cpt_template
end type
type cb_filter from u_cb within u_tabpg_cpt_template
end type
type cb_copybase from commandbutton within u_tabpg_cpt_template
end type
end forward

global type u_tabpg_cpt_template from u_tabpg_contract_master
integer width = 4101
integer height = 1936
string text = "Templates"
string powertiptext = "Templates"
event ue_prep_selection ( )
dw_detail dw_detail
dw_master dw_master
cb_delete cb_delete
cb_insert cb_insert
gb_1 gb_1
gb_2 gb_2
cb_2 cb_2
cb_4 cb_4
cb_select cb_select
cb_selectall cb_selectall
cb_sort cb_sort
cb_filter cb_filter
cb_copybase cb_copybase
end type
global u_tabpg_cpt_template u_tabpg_cpt_template

type variables
long il_item_id

n_ds ids_1

u_dw idw_fee_schedule

boolean ib_retriev_detail = true
end variables

forward prototypes
public function integer of_add_missing ()
public function integer of_retrieve_detail ()
public function integer of_copy_missing ()
end prototypes

event ue_prep_selection();/******************************************************************************************************************
**  [PUBLIC]   : ue_prep_selection
**==================================================================================================================
**  Purpose   	: Make some buttons visable others not when in select mode
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 27 Febuary 2006 © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
dw_master.object.item_name.protect = 1

cb_delete.visible = false
cb_insert.visible = false
cb_select.visible = true
dw_master.height = 336
end event

public function integer of_add_missing ();
if ids_1.rowcount( ) < 1 then 
	ids_1.retrieve()
end if 

long ll_i 
long ll_count
string ls_item_name
long ll_ins_row,ll_found

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.19.2006 By: LeiWei
//$<reason> Fix a defect.
/*
ls_item_name = dw_master.GetItemString(dw_master.getrow(),'item_name')
*/
IF dw_master.getrow() > 0 THEN
	ls_item_name = dw_master.GetItemString(dw_master.getrow(),'item_name')
END IF
//---------------------------- APPEON END ----------------------------

ll_count = ids_1.rowcount()
string ls_filter_list[]
string ls_filter

//---------Begin Modified by (Appeon)Harry 06.07.2013 for V141 ISG-CLX--------
//<$>added:long.zhang 04.19.2013
//<$>reason:the application was crashed when the ls_filter was too long
if dw_detail.rowcount( ) > 8000 then
		return of_copy_missing()
end if
//---------End Modfiied ------------------------------------------------------

// loop through dw_detail get the current cpt codes
// filter out the filter from ids_i
for ll_i = 1 to dw_detail.rowcount()
	ls_filter_list[upperbound(ls_filter_list) + 1 ] = dw_detail.getItemstring(ll_i,'cpt_code')
next

//---------Begin Modified by (Appeon)Harry 06.07.2013 for V141 ISG-CLX--------
//<$>Modified:long.zhang appeon 04.19.2013
//<$>reason:the application was crashed when the ls_filter was too long
//for ll_i = 1 to upperbound(ls_filter_list)
//	if upperbound(ls_filter_list) = 1 then 
//		ls_filter = ls_filter + 'CPT_CODE <> ' +"'"+ ls_filter_list[ll_i]  +"'" 
//	end if
//
//	if upperbound(ls_filter_list) > 1 then 
//		
//		if ll_i <> upperbound(ls_filter_list)  then 
//			ls_filter = ls_filter + 'CPT_CODE <> ' +"'"+ ls_filter_list[ll_i]  +"'"  +" AND "
//		else 
//			ls_filter = ls_filter + 'CPT_CODE <> ' +"'"+ ls_filter_list[ll_i]  +"'"
//					
//		end if 
//			
//	end if 
//next
for ll_i = 1 to upperbound(ls_filter_list)
	if ll_i = 1 then 
		ls_filter = ls_filter + 'CPT_CODE not in( ' +"'"+ ls_filter_list[ll_i]  +"'" 
	end if
	
	//---------Begin Modified by (Appeon)Stephen 10.28.2013 for test bug--------
	//if ll_i > 1 and ll_i < upperbound(ls_filter_list) then 
	if ll_i > 1 and ll_i <= upperbound(ls_filter_list) then 
	//---------End Modfiied ------------------------------------------------------
			ls_filter = ls_filter + ', ' +"'"+ ls_filter_list[ll_i]  +"'"
	end if					
	
	if 	upperbound(ls_filter_list)  = ll_i then
			ls_filter = ls_filter  + ')'
	end if 
next
//---------End Modfiied ------------------------------------------------------

//messagebox('', ls_filter)

ids_1.setfilter(ls_filter) //<> 1 then messagebox('Set Filter Failed', 'ids_1')
ids_1.filter() //<> 1 then messagebox('Filter() Failed', 'ids_1')


ids_1.RowsCOPY(1, ids_1.rowcount(), primary!, dw_detail, dw_detail.ROWCOUNT() + 1, Primary!) 
//THEN messagebox('ROWS MOVE FAILED', 'ids_1')
//end if



ids_1.setfilter('') //<> 1 then messagebox('Set Filter Failed', 'ids_1')
ids_1.filter() //<> 1 then messagebox('Filter() Failed', 'ids_1')


return  0 


end function

public function integer of_retrieve_detail ();


IF dw_master.rowcount() > 0 THEN
   SETPOINTER(HOURGLASS!)	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.19.2006 By: LeiWei
	//$<reason> Fix a defect.
	IF dw_master.rowcount() > 0 AND dw_master.getrow() = 0 THEN
		dw_master.setrow(1)
	END IF
	//---------------------------- APPEON END ----------------------------
	
	dw_master.SelectRow(0, FALSE)
   dw_master.SelectRow(dw_master.getrow(), TRUE)
	il_item_id = dw_master.GETiTEMnUMBER(dw_master.getrow(),'ITEM_ID')
	dw_detail.EVENT PFC_RETRIEVE()
	SETPOINTER(ARROW!)
END IF




return success
end function

public function integer of_copy_missing ();// (Appeon)Harry 06.07.2013 - V141 ISG-CLX
//$<add> 04.19.2013 By:long.zhang
//$<reason>crash the appliation when setfilter parameter was too long
//this function called from of_add_missing()
//$ return type Integer

long ll_i 
long ll_count
long ll_found

string ls_cpt_code

ll_count = ids_1.rowcount()

for ll_i = 1 to ll_count
	
	ls_cpt_code = 	ids_1.getitemstring( ll_i,'cpt_code')
	ll_found = dw_detail.find( "cpt_code ='" + ls_cpt_code + "'", 1, dw_detail.rowcount())
	
	if ll_found = 0 then
		ids_1.RowsCOPY(ll_i,ll_i, primary!, dw_detail, dw_detail.ROWCOUNT() + 1, Primary!) 	
	end if
	
end for

return 0
end function

on u_tabpg_cpt_template.create
int iCurrent
call super::create
this.dw_detail=create dw_detail
this.dw_master=create dw_master
this.cb_delete=create cb_delete
this.cb_insert=create cb_insert
this.gb_1=create gb_1
this.gb_2=create gb_2
this.cb_2=create cb_2
this.cb_4=create cb_4
this.cb_select=create cb_select
this.cb_selectall=create cb_selectall
this.cb_sort=create cb_sort
this.cb_filter=create cb_filter
this.cb_copybase=create cb_copybase
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_detail
this.Control[iCurrent+2]=this.dw_master
this.Control[iCurrent+3]=this.cb_delete
this.Control[iCurrent+4]=this.cb_insert
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.cb_4
this.Control[iCurrent+9]=this.cb_select
this.Control[iCurrent+10]=this.cb_selectall
this.Control[iCurrent+11]=this.cb_sort
this.Control[iCurrent+12]=this.cb_filter
this.Control[iCurrent+13]=this.cb_copybase
end on

on u_tabpg_cpt_template.destroy
call super::destroy
destroy(this.dw_detail)
destroy(this.dw_master)
destroy(this.cb_delete)
destroy(this.cb_insert)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.cb_select)
destroy(this.cb_selectall)
destroy(this.cb_sort)
destroy(this.cb_filter)
destroy(this.cb_copybase)
end on

event constructor;call super::constructor;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : 
//==================================================================================================================
//  Purpose   	: 
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	  
//==================================================================================================================
//  Created By	: Michael Skinner  25 Febuary 2006
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

ids_1 = CREATE N_DS
ids_1.DATAOBJECT = 'ds_cpt_code_all'
ids_1.SETTRANSObject(SQLCA)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<comment> 05.06.2006 By: Liang QingShi
//$<reason> Dynamic Create visual user object is currently unsupported.
//$<modification> Comment out the following script.
/*
idw_fee_schedule = create u_dw
*/
//---------------------------- APPEON END ----------------------------



//dw_master.of_SetLinkage(TRUE)
//
//dw_detail.of_SetLinkage(TRUE)
//
//dw_detail.inv_linkage.of_SetMaster(dw_master)
//dw_detail.inv_linkage.of_Register ("item_id", "item_id")
//dw_detail.inv_linkage.of_SetStyle(dw_detail.inv_linkage.RETRIEVE)
//dw_master.inv_linkage.of_SetTransObject(SQLCA)
//
//dw_master.inv_linkage.of_SetUpdateOnRowChange(TRUE)
//
//dw_detail.inv_linkage.of_SetUpdateOnRowChange(TRUE)
//

PowerObject lpo[]

lpo[1] = dw_master
lpo[2] = dw_detail

of_setUpdateObjects(lpo)


end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_cpt_template
integer x = 667
integer y = 2084
integer width = 2674
integer height = 116
end type

type dw_detail from u_dw_contract within u_tabpg_cpt_template
event ue_no_update ( )
integer x = 59
integer y = 672
integer width = 3968
integer height = 1204
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_cpt_for_template"
boolean hsplitscroll = true
boolean ib_rmbmenu = false
boolean ib_use_row_selection = true
end type

event ue_no_update();
this.ib_isupdateable = false
end event

event pfc_preupdate;

// override 



long ll_i
long ll_count 
dwItemStatus l_status
ll_count = rowcount()

setredraw(false)





this.accepttext( )

FOR ll_i = ll_count to 1 step -1  
	if this.getItemNumber(ll_i,'selected') = 1 and this.getItemNumber(ll_i,'selected',primary!,true) <> this.getItemNumber(ll_i,'selected',primary!,false)  then
		if	this.getitemstatus(ll_i,0, primary!) = DataMODIFIED! then		
			this.setitem(ll_i,'ctx_cpt_code_item_cpt_code_id', this.getItemNumber(ll_i,'ctx_cpt_codes_cpt_code_id'))
			this.setitem(ll_i,'item_id', dw_master.getItemNumber(dw_master.getRow(),'item_id'))
			//Set states From DataModified! to NewModified
			this.SetItemStatus(ll_i,0,Primary!,New!)
			CONTINUE
		end if	
	end if
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 08.21.2006 By: Liang QingShi
	//$<reason> Contract module modification
	//$<reason> Fix a defect.
	/*
	if this.getItemNumber(ll_i,'selected') = 0 and this.getitemstatus(ll_i,0, primary!) = datamodified!  then  
	*/
	integer li_selected
	
	l_status = this.getitemstatus(ll_i,0, primary!)
	li_selected = this.getItemNumber(ll_i,'selected')
	If isnull(li_selected) Then li_selected = 0
	
	If li_selected = 0 and (l_status = datamodified! or l_status = newmodified!) and this.getItemNumber(ll_i,'selected',primary!,true) <> this.getItemNumber(ll_i,'selected',primary!,false) Then  
	
	//---------------------------- APPEON END ----------------------------
	
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 2006-10-30 By: Rodger Wu
		//$<reason> Fix a defect.
		/* deleterow(ll_i) */
		
		This.SetRedraw( False )
		
		This.RowsCopy( ll_i, ll_i, Primary!, This, ll_i + 1, Primary! )
		This.SetItemStatus( ll_i + 1, 0, Primary!, NotModified! )
		This.DeleteRow( ll_i )
		
		This.SetRedraw( True )
		
		//---------------------------- APPEON END ----------------------------

			//THIS.IB_isupdateable = TRUE
		CONTINUE
	End If 
	
	// SET THE ROW TO NOT MODIFIED
	l_status = this.getitemstatus(ll_i,0, primary!)
	choose case l_status
		case new!
			//messagebox(string(this.getItemNumber(ll_i,'selected')),'new!')
		case newmodified!
			//messagebox(string(this.getItemNumber(ll_i,'selected')),'newmodified!')
		   //IF this.SETitemstatus(ll_i,0, primary!,NOTMODIFIED!) <> 1 THEN MESSAgeBOX('','SETitemstatus FAILED')
				//THIS.IB_isupdateable = TRUE
		case datamodified!
				//messagebox(string(this.getItemNumber(ll_i,'selected')),'datamodified!')
		case notmodified!
				//messagebox(string(this.getItemNumber(ll_i,'selected')),'notmodified!')
   end choose 
    
	
NEXT

return 0
end event

event updateend;call super::updateend;




//this.event pfc_retrieve( )







setredraw(true)

return success
end event

event retrieveend;call super::retrieveend;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 10 March 2006  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_i
long ll_count
Long ll_Cnt = 0 //Add by Andy 03.24.2008

ll_count = this.rowcount()

for ll_i = 1 to ll_count 
   if f_validstr(string(this.getItemNumber(ll_i,'ctx_cpt_code_item_cpt_code_id'))) then 
//		this.setItem(ll_i,'selected',1)
		ll_Cnt ++ //Add by Andy 03.24.2008
//		this.setItemstatus(ll_i,0,primary!,notmodified!)	
	end if 
next

//Add by Andy 03.24.2008
//Reason:Fixed BugN030704
if ll_Cnt = ll_count then 
	dw_detail.Object.b_select.Text = 'A'
end if
//end of add 03.24.2008

///////////////////////////////////////////////////////////////////////////////////////////
//  
///////////////////////////////////////////////////////////////////////////////////////////

//of_add_missing()

///////////////////////////////////////////////////////////////////////////////////////////
//  
///////////////////////////////////////////////////////////////////////////////////////////
//ll_count = this.rowcount()
//for ll_i = 1 to ll_count
//   SetItemStatus(ll_i, 0, Primary!, notmodified!)
//next

setredraw(true)
end event

event pfc_retrieve;call super::pfc_retrieve;//setredraw(false)

//this.reset()
/////this.retrieve(il_item_id)
//IDS_ITEM_ONLY.retrieve(il_item_id)
//iDS_ITEM_NOT_EXISTING.retrieve(il_item_id)
//long ll_null
//setnull(ll_null)
//long ll_i
//
//
//for ll_i = 1 to IDS_ITEM_ONLY.rowcount()
//	IDS_ITEM_ONLY.setItem(ll_i,'ctx_cpt_code_item_item_id',ll_null)
//	IDS_ITEM_ONLY.setItem(ll_i,'ctx_cpt_code_item_cpt_code_id',ll_null)
//next
//
//
//
//IDS_ITEM_ONLY.RowsCopy(1, IDS_ITEM_ONLY.RowCount(), Primary!, THIS, 1, Primary!)
//IDS_ITEM_NOT_EXISTING.RowsCopy(1, IDS_ITEM_NOT_EXISTING.RowCount(), Primary!, this,this.rowcount() + 1 ,Primary!)
//dw_detail.sort()
//
//long ll_count
//ll_count = this.rowcount()
//
//for ll_i = 1 to ll_count
//	this.setItemstatus(ll_i,0,primary!,newmodified!)
//next
//
//
//for ll_i = 1 to ll_count 
//   if f_validstr(string(this.getItemNumber(ll_i,'ctx_cpt_code_item_cpt_code_id'))) then 
//		this.setItem(ll_i,'selected',1)
//		this.setItemstatus(ll_i,0,primary!,notmodified!)	
//	end if 
//	  
//	  
//next

setredraw(false)
string ls_object
ls_object = this.dataobject
this.dataobject = ''
this.dataobject = ls_object
this.ib_retrieve_drop_downs = false
this.event ue_populatedddws()	//jervis 08.14.2009
this.settransobject(sqlca)
ids_1.Retrieve()
this.retrieve(il_item_id )
return success

end event

event buttonclicked;call super::buttonclicked;choose case dwo.name
	//--------------------------- APPEON BEGIN ---------------------------
	//$<comment> 09.29.2006 By: Liang QingShi
	//$<reason> Fix a defect.
	/*
	case 'b_sort'
		event pfc_sortdlg( )
		
	case 'b_filter'
		event pfc_filterdlg( )
	case 'b_1'
		event pfc_deleterow( )
	*/	
	//---------------------------- APPEON END ----------------------------
	case 'b_select'
		 if Object.b_select.Text = 'N' then 
			cb_selectall.event clicked()
			Object.b_select.Text = 'A'
		 else
			cb_selectall.event clicked()
			Object.b_select.Text = 'N'
		 end if 
end choose
end event

event constructor;call super::constructor;this.of_SetSort(TRUE)


this.inv_sort.of_SetUseDisplay(TRUE)

this.inv_sort.of_SetColumnnameSource(this.inv_sort.HEADER)

this.inv_sort.of_SetStyle(this.inv_sort.DRAGDROP)

this.inv_sort.of_SetColumnHeader(TRUE)


this.of_SetFilter(TRUE)
this.inv_filter.of_SetColumnDisplayNameStyle(2)
this.inv_filter.of_SetStyle(2)


end event

event losefocus;//
this.border = true
	this.borderstyle = StyleLowered!
return 0
end event

event getfocus;//
return 0
end event

event pfc_prermbmenuproperty;call super::pfc_prermbmenuproperty;      am_dw.m_table.m_insert.Visible  = false
		am_dw.m_table.m_delete.Visible = false
		am_dw.m_table.m_addrow.Visible = false
end event

event rowfocuschanging;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.21.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason> Fix a defect.
//
//---------------------------- APPEON END ----------------------------
if currentrow=0 then return 0
if dw_detail.accepttext() = -1 then return
if parent.iw_parent.triggerevent('pfc_save')<>1 then return 1
end event

type dw_master from u_dw_contract within u_tabpg_cpt_template
integer x = 59
integer y = 216
integer width = 3968
integer height = 276
integer taborder = 10
boolean bringtotop = true
string title = "Templates"
string dataobject = "d_cpt_code_template_hdr"
boolean ib_use_row_selection = true
end type

event pfc_preupdate;


// override

long ll_i 
///////////////////////////////////////////////////////////////////////////////////
// 
///////////////////////////////////////////////////////////////////////////////////

for ll_i = 1 to this.rowcount()
	if not f_validstr(string(getitemNumber(ll_i,'item_id'))) then 
		select max(item_id)
		into :il_item_id
		from ctx_item;
		
		if isnull(il_item_id) or il_item_id = 0 then 
			il_item_id = 1
		else 
		   il_item_id = il_item_id + 1
	   end if
		
		setitem(ll_i,'item_id',il_item_id)
		
	end if 				
		
next 

return 0
end event

event pfc_retrieve;call super::pfc_retrieve;

retrieve()


return success
end event

event constructor;call super::constructor;settransobject(sqlca)
dw_master.event pfc_retrieve()

This.of_setrmbmenu(False) //Added by Ken.Guo on 2008-12-05
end event

event doubleclicked;call super::doubleclicked;//
//IF ROW > 0 THEN
//   SETPOINTER(HOURGLASS!)	
//	This.SelectRow(0, FALSE)
//   This.SelectRow(ROW, TRUE)
//	
//	il_item_id = THIS.GETiTEMnUMBER(ROW,'ITEM_ID')
//	dw_detail.EVENT PFC_RETRIEVE()
//	SETPOINTER(ARROW!)
//END IF
end event

event getfocus;this.border = TRUE


return 0
end event

event losefocus;

//

return 0
end event

event rowfocuschanged;
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.08.2007 By: Jack 
//$<reason> 
of_retrieve_detail()
//---------------------------- APPEON END ----------------------------

end event

event updateend;call super::updateend;
//if rowsinserted > 0 then 
//	ib_retriev_detail = true
//   of_retrieve_detail()
//end if 

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.29.2006 By: LeiWei
//$<reason> Refresh cache for Contract Logix.
gnv_app.inv_dwcache.of_unRegister("dddw_contract_code_tempate")
gnv_app.inv_dwcache.of_Register("dddw_contract_code_tempate", "dddw_contract_code_tempate", SQLCA, true)
//---------------------------- APPEON END ----------------------------

end event

event rowfocuschanging;call super::rowfocuschanging;//Added by Alan on 2008-12-16
if currentrow=0 then return 0
if dw_master.accepttext() = -1 then return
if this.getitemstatus(currentrow,0, primary!)=new! then return 1
if isnull(this.getitemstring(currentrow,"item_name")) or trim(this.getitemstring(currentrow,"item_name"))="" then return 1
if parent.iw_parent.triggerevent('pfc_save')<>1 then return 1
end event

type cb_delete from commandbutton within u_tabpg_cpt_template
string tag = "Delete a template"
integer x = 475
integer y = 36
integer width = 411
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete Template"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.06.2006 By: LiuHongXin
//$<reason> Fix a defect.
Long 		ll_item_id
Long 		ll_row
String	ls_ItemName

ll_row = dw_master.getrow( )
IF ll_row > 0 THEN
	ll_item_id = dw_master.getitemnumber(ll_row, "item_id")
	//---------Begin Added by (Appeon)Harry 12.02.2013 for V141 ISG-CLX--------
	Long ll_count
	SELECT COUNT(*) INTO :ll_count FROM ctx_fee_sched_locations WHERE fee_bonus = :ll_item_id;
	IF isnull(ll_count) or ll_count = 0 THEN ll_count = 0
	IF ll_count > 0 THEN
		messagebox('Delete','The record cannot be deleted as it is being used in Fee Schedules.')
		return
	END IF
	//---------End Added ------------------------------------------------------

	//--------------------------- APPEON BEGIN ---------------------------
	//$<Modify> 2008-03-11 By: Scofield
	//$<Reason> if item_name is null,can't delete the record on Web.

	ls_ItemName = dw_master.GetItemString(ll_row, "item_name")
	if Not IsNull(ll_item_id) then
		delete from ctx_cpt_code_item where item_id = :ll_item_id;
	end if
	
	if IsNull(ls_ItemName) then
		dw_master.SetItem(ll_row, "item_name"," ")
	end if
	//---------------------------- APPEON END ----------------------------
END IF
//---------------------------- APPEON END ----------------------------

//long ll_null
//setnull(ll_null)
//dw_detail.retrieve(ll_null)

dw_master.event pfc_deleterow( )


end event

type cb_insert from u_cb within u_tabpg_cpt_template
string tag = "Insert a new template"
integer x = 64
integer y = 36
integer width = 402
integer taborder = 40
boolean bringtotop = true
string text = "Add Template"
end type

event clicked;call super::clicked;//Added by Alan on 2008-12-16
long	ll_row

ll_row = dw_master.getrow()
if ll_row>0 then
	if dw_master.accepttext() = -1 then return
	if dw_master.getitemstatus(ll_row,0, primary!)=new! then return
	if isnull(dw_master.getitemstring(ll_row,"item_name")) or trim(dw_master.getitemstring(ll_row,"item_name"))="" then return
	if parent.iw_parent.triggerevent('pfc_save')<>1 then return
end if
ib_retriev_detail = false
dw_master.event pfc_addrow( )
dw_master.setrow(dw_master.rowcount()  )
dw_master.scrolltorow( dw_master.rowcount())


end event

type gb_1 from u_gb within u_tabpg_cpt_template
integer x = 27
integer y = 160
integer width = 4037
integer height = 372
integer taborder = 60
long backcolor = 33551856
string text = "Fee Basis Template"
end type

type gb_2 from u_gb within u_tabpg_cpt_template
integer x = 27
integer y = 532
integer width = 4037
integer height = 1376
integer taborder = 70
long backcolor = 33551856
string text = "Fee Basis Detail"
end type

type cb_2 from u_cb within u_tabpg_cpt_template
string tag = "Close window"
integer x = 3698
integer y = 24
integer taborder = 30
boolean bringtotop = true
string text = "Clos&e"
end type

event clicked;call super::clicked;close(iw_parent)
end event

type cb_4 from u_cb within u_tabpg_cpt_template
string tag = "Save current template"
integer x = 3333
integer y = 24
integer taborder = 50
boolean bringtotop = true
string text = "&Save"
end type

event clicked;call super::clicked;

parent.iw_parent.triggerevent('pfc_save')
end event

type cb_select from u_cb within u_tabpg_cpt_template
boolean visible = false
integer x = 2967
integer y = 24
integer taborder = 90
boolean bringtotop = true
string text = "Sele&ct"
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
**  Created By	: Michael B. Skinner 27 Febuary 2006 © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
LONG LL_I
long ll_active_code
// mskinner 08 March 2006 -- begin
////////////////////////////////////////////////////////////////////////////////
// if the cb_select button is vis. then do not allow updates
////////////////////////////////////////////////////////////////////////////////

if cb_select.visible then 
	dw_detail.event ue_no_update()

end if 


// mskinner 08 March 2006 -- end



//////////////////////////////////////////////////////////////////////////
// save the current configuration
//////////////////////////////////////////////////////////////////////////

//if dw_detail.event pfc_updatespending( ) = 1 then
//	if messagebox(iw_parent.title, 'Do you want to save changes made to this template?',question!,yesNo!,1) = 1 then 
//	    parent.iw_parent.triggerevent('pfc_save')
//   end if 
//end if 

setredraw(false)

//////////////////////////////////////////////////////////////////////////
// filter out all of the Checked items
//////////////////////////////////////////////////////////////////////////

dw_detail.setfilter('selected = 1 ')
dw_detail.filter()


//////////////////////////////////////////////////////////////////////////
// insert the records into idw_fee_schedule
//////////////////////////////////////////////////////////////////////////
long ll_new_row
dw_detail.accepttext( )

for ll_i = 1 to dw_detail.rowcount()
   // check to see if the cpt code already exists in datawindow
 //if idw_fee_schedule.Find("CPT_CODE = " +"'"+ DW_DETAIL.GETiTEMSTRING(LL_I,'CPT_CODE') +"'",1, idw_fee_schedule.RowCount()) < 1 then //commented by long.zhang 08.09.2012 //(Appeon)Harry 06.07.2013 - V141 ISG-CLX
 	ll_new_row =  idw_fee_schedule.INSERTROW(0)
   idw_fee_schedule.SETITEM(LL_NEW_ROW, 'CPT_CODE', DW_DETAIL.GETiTEMSTRING(LL_I,'CPT_CODE') ) 
	idw_fee_schedule.SETITEM(LL_NEW_ROW, 'fee', DW_DETAIL.getitemdecimal(LL_I,'location_price') ) 
	
	if ll_active_code = 0 then 
			ll_active_code = inv_contract_details.of_get_active_status_code( )
	end if 
	 
	idw_fee_schedule.SETITEM(LL_NEW_ROW, 'status', ll_active_code ) 
	//idw_fee_schedule.SETITEM(LL_NEW_ROW, 'effective_date', DATETIME(TODAY(),nOW())) 
	idw_fee_schedule.SETITEM(LL_NEW_ROW, 'effective_date',inv_contract_details.idt_contract_eff_date) //01.23.2008 By Jervis Set Default to effective date
	idw_fee_schedule.SETITEM(LL_NEW_ROW, 'expiration_date', inv_contract_details.idt_contract_exp_date  ) 
	
	idw_fee_schedule.SetItem(ll_New_Row, 'description', dw_detail.GetItemString(ll_i,"code_description"))		//Added by Scofield on 2009-08-14
  //end if  //commented by long.zhang 08.09.2012
next
 
//////////////////////////////////////////////////////////////////////////
// clear the filter
//////////////////////////////////////////////////////////////////////////
dw_detail.setfilter('')
dw_detail.filter()
setredraw(true)
CLOSE( iw_parent )












end event

type cb_selectall from commandbutton within u_tabpg_cpt_template
integer x = 59
integer y = 596
integer width = 274
integer height = 76
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select &All"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.14.2006 By: LeiWei
//$<reason> Requirement modification.

long ll_rowcount
long ll_start

IF dw_detail.rowcount() = 0 THEN RETURN

IF THIS.text = "Select &All" THEN
	ll_rowcount = dw_detail.rowcount( )
	dw_detail.setredraw(false)
	for ll_start = 1 to ll_rowcount
		dw_detail.setItem(ll_start,'selected', 1)
	
	next
	dw_detail.Object.b_select.Text = 'A'
	
	dw_detail.setredraw(true)
	THIS.text = "&Deselect All"
ELSE
	ll_rowcount = dw_detail.rowcount( )
	dw_detail.setredraw(false)
	for ll_start = 1 to ll_rowcount
		dw_detail.setItem(ll_start,'selected', 0)
	
	next
	dw_detail.Object.b_select.Text = 'N'
	dw_detail.setredraw(true)

	THIS.text = "Select &All"
END IF

//---------------------------- APPEON END ----------------------------

end event

type cb_sort from u_cb within u_tabpg_cpt_template
integer x = 2235
integer y = 24
integer taborder = 100
boolean bringtotop = true
string text = "So&rt"
end type

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.29.2006 By: Liang QingShi
//$<reason> Fix a defect.
dw_detail.event pfc_sortdlg( )
//---------------------------- APPEON END ----------------------------

end event

type cb_filter from u_cb within u_tabpg_cpt_template
integer x = 2601
integer y = 24
integer taborder = 110
boolean bringtotop = true
string text = "&Filter"
end type

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.29.2006 By: Liang QingShi
//$<reason>Fix a defect. 
dw_detail.event pfc_filterdlg( )
//---------------------------- APPEON END ----------------------------

end event

type cb_copybase from commandbutton within u_tabpg_cpt_template
string tag = "Delete a template"
integer x = 1669
integer y = 24
integer width = 553
integer height = 92
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Copy Base to Location"
end type

event clicked;//Start Code Change ----11.18.2008 #V85 maha - added copy fucntion
Long 		ll_item_id
Long 		ll_row
decimal 	ld_fee

for ll_row =1 to dw_detail.rowcount( )
	if dw_detail.getitemnumber(ll_row, "selected") = 1 then
		ld_fee = dw_detail.getitemnumber(ll_row, "base_price")
		dw_detail.SetItem(ll_row, "location_price",ld_fee)
	end if
next



end event

