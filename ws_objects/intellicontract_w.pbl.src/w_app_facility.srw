$PBExportHeader$w_app_facility.srw
$PBExportComments$[intellicontract_w] Application Facility Painter
forward
global type w_app_facility from w_response
end type
type cb_delete from u_cb within w_app_facility
end type
type cb_2 from u_cb within w_app_facility
end type
type cb_1 from u_cb within w_app_facility
end type
type dw_2 from u_dw within w_app_facility
end type
type cb_ok from u_cb within w_app_facility
end type
type dw_1 from u_dw within w_app_facility
end type
type cb_save from u_cb within w_app_facility
end type
end forward

global type w_app_facility from w_response
integer width = 3497
integer height = 1436
string title = "Company Facility"
long backcolor = 33551856
boolean center = false
cb_delete cb_delete
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
cb_ok cb_ok
dw_1 dw_1
cb_save cb_save
end type
global w_app_facility w_app_facility

type variables
//app_facility

str_pass istr_pass

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 03.29.2006 By: Liang QingShi
//$<reason> Perofrmance tuning
//$<modification> Define a variable to be used in subsequent script.

integer ii_save = 0
boolean ib_new = False
//---------------------------- APPEON END ----------------------------
end variables

on w_app_facility.create
int iCurrent
call super::create
this.cb_delete=create cb_delete
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_2=create dw_2
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.cb_save=create cb_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_delete
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_ok
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.cb_save
end on

on w_app_facility.destroy
call super::destroy
destroy(this.cb_delete)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.cb_ok)
destroy(this.dw_1)
destroy(this.cb_save)
end on

event pfc_postopen;call super::pfc_postopen;
istr_pass = message.powerobjectparm


DW_2.event pfc_retrieve( )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-08-15 By: Rodger Wu (Contract)
//$<reason> Tiny tuning for the situation that this window is opened
//$<reason> by click menu bar.

if not isvalid( istr_pass ) then
	//Start Change By Jervis 02.25.2007
	//cb_2.Text = "&Save/Close"
	cb_2.visible = false
	cb_save.visible = true
	//End Change
	
	return;
end if
//---------------------------- APPEON END ----------------------------

cb_1.event clicked( )


end event

event pfc_postupdate;call super::pfc_postupdate;

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01.09.2007 By: Davis
//$<reason> Fix a defect.
//dw_2.event pfc_retrieve( )
dw_2.post event pfc_retrieve( )
//---------------------------- APPEON END ----------------------------

dw_1.Object.facility_name.Edit.Required='No'
return success
end event

event pfc_endtran;call super::pfc_endtran;

IF AI_update_results = SUCcess THEN 
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-02
	//$<modify> 03.24.2006 By: LeiWei
	//$<reason> Perofrmance tuning.
	//$<modification> Have the application only refresh dddw_contract_company and 
	//$<modification> and dddw_contact_facility.
	/*
	gnv_app.ib_ref_cache = true
	gnv_app.of_setcontraccache( )
	//istr_pass.s_u_dw.object.app_facility[istr_pass.s_u_dw.getrow()] = dw_1.object.facility_id[dw_1.getrow()]
	//istr_pass.s_u_dw.accepttext( )
	*/
	
	string ls_dw[]
	long ll_i
	string ls_cach_path
	ls_cach_path = gnv_app.is_application_path + '\cachedata'
	
	ls_dw[upperbound(ls_dw) + 1 ] = 'dddw_contact_company'     
	ls_dw[upperbound(ls_dw) + 1 ] = 'dddw_contact_facility'     
	
	FOR ll_i = 1 TO upperbound(ls_dw)
		gnv_app.inv_dwcache.of_unRegister(ls_dw[ll_i])
		gnv_app.inv_dwcache.of_Register(ls_dw[ll_i], ls_dw[ll_i], SQLCA, true)
	NEXT

	//---------------------------- APPEON END ----------------------------
END IF 


return success
end event

type cb_delete from u_cb within w_app_facility
integer x = 2341
integer y = 1216
integer taborder = 30
string text = "&Delete"
end type

event clicked;call super::clicked;dw_2.event pfc_deleterow( )
parent.event pfc_save()
dw_1.event pfc_retrieve( )
parent.title = "Company Facility"
end event

type cb_2 from u_cb within w_app_facility
integer x = 2706
integer y = 1216
integer width = 361
integer taborder = 40
string text = "&Select/Close"
end type

event clicked;call super::clicked;
long ll_return

dw_1.accepttext( )

if dw_1.event pfc_validation( ) = failure then return failure

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.19.2006 By: Liang QingShi
//$<reason> Fix a defect.
/*
ll_return = parent.event pfc_save( )
if ll_return = success then 

end if 

ib_disableclosequery = true

if dw_1.rowcount() > 0 then
  CloseWithReturn ( parent, dw_1.getitemnumber(DW_1.GETROW(),'FACILITY_ID') ) 
end if 
*/
long ll_FACILITY_ID
if dw_1.getrow() <= 0 then return

ll_return = parent.event pfc_save( )

ib_disableclosequery = true

ll_FACILITY_ID = dw_1.getitemnumber(DW_1.GETROW(),'FACILITY_ID')
CloseWithReturn ( parent, ll_FACILITY_ID ) 

//---------------------------- APPEON END ----------------------------


end event

type cb_1 from u_cb within w_app_facility
integer x = 1975
integer y = 1216
integer taborder = 30
string text = "&New"
end type

event clicked;call super::clicked;

parent.event pfc_save( )

dw_1.reset()

dw_1.event pfc_insertrow( )
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.08.2007 By: Jack (Document Manager)
//$<reason> 
ib_new = True
//---------------------------- APPEON END ----------------------------

parent.title = "Company Facility (New Mode)"
end event

type dw_2 from u_dw within w_app_facility
integer width = 1134
integer height = 1184
integer taborder = 20
string dataobject = "d_facility_browse"
end type

event constructor;ib_rmbmenu	= False

settransobject( sqlca)
of_SetRowSelect(TRUE)
this.of_setrowmanager( true)
this.inv_rowmanager.of_setconfirmondelete( true)
//this.inv_rowmanager.of_setrestorerow( true)
this.inv_rowselect.of_SetStyle(inv_rowselect.single )

end event

event rowfocuschanged;call super::rowfocuschanged;
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.08.2007 By: Jack 
//$<reason> 
integer li_mes
If ib_new then
	li_mes = messagebox('IntelliSoftGroup','Do you want to save changes?',Question!,YesNo!)
	If li_mes = 1 Then
		parent.event pfc_save( )
	End If
End If
//---------------------------- APPEON END ----------------------------



dw_1.event pfc_retrieve( )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.08.2007 By: Jack 
ib_new = False
//---------------------------- APPEON END ----------------------------

end event

event pfc_retrieve;call super::pfc_retrieve;this.retrieve( )

return success
end event

event clicked;call super::clicked;dw_1.event pfc_retrieve( )
end event

type cb_ok from u_cb within w_app_facility
integer x = 3081
integer y = 1216
integer taborder = 20
string text = "&Close"
end type

event clicked;call super::clicked;
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<modify> 03.29.2006 By: Liang QingShi
//$<reason> Perofrmance tuning
//$<modification> Pass ii_save that store the status of w_app_facility when it is closed to the windows. 
//$<modification> Due to our modification, the application only refresh the corresponding dw(s) in those
//$<modification> windows that share data with w_app_facility.  
/*
parent.event pfc_close( )
*/
CloseWithReturn(parent,ii_save)
//---------------------------- APPEON END ----------------------------
end event

type dw_1 from u_dw within w_app_facility
string tag = "Facility Detail"
integer x = 1170
integer width = 2267
integer height = 1184
integer taborder = 10
string title = "Facility Detail"
string dataobject = "d_facility_detail"
end type

event pfc_retrieve;call super::pfc_retrieve;

long ll_row
ll_row = dw_2.getrow()
if ll_row < 1 then
	this.Reset()
	this.InsertRow(0)
else
	this.retrieve( dw_2.object.facility_id[ll_row] )
end if
parent.title = "Company Facility (Edit Mode)"
return success
end event

event pfc_preupdate;call super::pfc_preupdate;
/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

	
	
	Long li_next_id
	
	
	
	
	
	
	if NOT f_validstr(STRING(this.object.facility_id[this.getrow()])) THEN
	
		
		SELECT Max( facility_id )  
		INTO :li_next_id  
		FROM app_facility;
	
		IF IsNull( li_next_id ) OR li_next_id = 0 THEN
			li_next_id = 1
		ELSE
			li_next_id ++
		END IF
	
	
		dw_1.SetItem( 1, "facility_id", li_next_id )
	END IF 
	
	return success
end event

event pfc_validation;call super::pfc_validation;

if not f_validstr(this.object.facility_name[getrow()]) then
	messagebox(parent.title, 'Organization Name is a required column' )
	setcolumn('facility_name' )
	return failure
end if 
return success
end event

event itemchanged;call super::itemchanged;
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<add> 03.29.2006 By: Liang QingShi
//$<reason> Perofrmance tuning.
//$<modification> Set ii_save to 1 to denote that the status of w_app_facility has been changed.
//$<modification> Refer to PT-01/03 for more information.
ii_save = 1
//---------------------------- APPEON END ----------------------------


end event

type cb_save from u_cb within w_app_facility
boolean visible = false
integer x = 2711
integer y = 1216
integer width = 361
integer taborder = 40
string text = "&Save"
end type

event clicked;call super::clicked;dw_1.accepttext( )

if dw_1.event pfc_validation( ) = failure then return failure

if dw_1.getrow() <= 0 then return

parent.event pfc_save( )

end event

