$PBExportHeader$pfc_cst_nv_net_dev_prac_folder.sru
forward
global type pfc_cst_nv_net_dev_prac_folder from pfc_cst_nv_net_dev_new
end type
type dw_orgs_facilities from u_dw within pfc_cst_nv_net_dev_prac_folder
end type
end forward

global type pfc_cst_nv_net_dev_prac_folder from pfc_cst_nv_net_dev_new
integer width = 3511
integer height = 1716
dw_orgs_facilities dw_orgs_facilities
end type
global pfc_cst_nv_net_dev_prac_folder pfc_cst_nv_net_dev_prac_folder

forward prototypes
public function integer of_retrieve_facilities ()
end prototypes

public function integer of_retrieve_facilities ();dw_orgs_facilities.Reset( )
dw_orgs_facilities.setredraw( false) //Start Code Change ----01.10.2011 #V11 maha 
dw_orgs_facilities.Retrieve( il_prac_id ,gs_user_id)
dw_orgs_facilities.setredraw( true)  //Start Code Change ----01.10.2011 #V11 maha 

IF dw_orgs_facilities.RowCount() > 0 THEN
	//dw_orgs_facilities.SetRow( 1 )
	//dw_orgs_facilities.SelectRow( 1, True )
END IF

Return 0
end function

on pfc_cst_nv_net_dev_prac_folder.create
int iCurrent
call super::create
this.dw_orgs_facilities=create dw_orgs_facilities
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_orgs_facilities
end on

on pfc_cst_nv_net_dev_prac_folder.destroy
call super::destroy
destroy(this.dw_orgs_facilities)
end on

type tab_1 from pfc_cst_nv_net_dev_new`tab_1 within pfc_cst_nv_net_dev_prac_folder
integer x = 768
integer y = 8
integer height = 1672
integer taborder = 30
end type

type tabpage_ai from pfc_cst_nv_net_dev_new`tabpage_ai within tab_1
integer height = 1544
end type

type dw_net_dev from pfc_cst_nv_net_dev_new`dw_net_dev within tabpage_ai
integer y = 4
integer height = 1504
end type

event dw_net_dev::constructor;call super::constructor;This.of_SetUpdateable( True )
end event

event dw_net_dev::rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)

col = this.getclickedcolumn()
colname = this.getcolumnname() 

if this.Describe( colname + ".ColType") = "datetime" or this.Describe( colname + ".ColType") = "date" THEN //data added maha 112904 for due date
	//messagebox("dt","dt")
	ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )
	if ret = 1 then
		this.setitem(row,col,dtn)
	end if
END IF
end event

type tabpage_ids from pfc_cst_nv_net_dev_new`tabpage_ids within tab_1
integer height = 1544
end type

type dw_ids from pfc_cst_nv_net_dev_new`dw_ids within tabpage_ids
integer height = 1480
end type

event dw_ids::rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)

col = this.getclickedcolumn()
colname = this.getcolumnname() 

if this.Describe( colname + ".ColType") = "datetime" THEN
	//messagebox("dt","dt")
	ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )
	if ret = 1 then
		this.setitem(row,col,dtn)
	end if
END IF
end event

type tabpage_notes from pfc_cst_nv_net_dev_new`tabpage_notes within tab_1
integer height = 1544
end type

type dw_notes from pfc_cst_nv_net_dev_new`dw_notes within tabpage_notes
integer y = 100
integer height = 1436
end type

type tabpage_report from pfc_cst_nv_net_dev_new`tabpage_report within tab_1
integer height = 1544
end type

type cb_export from pfc_cst_nv_net_dev_new`cb_export within tabpage_report
end type

type rb_par_sum from pfc_cst_nv_net_dev_new`rb_par_sum within tabpage_report
end type

type rb_ai_wn from pfc_cst_nv_net_dev_new`rb_ai_wn within tabpage_report
end type

type rb_par from pfc_cst_nv_net_dev_new`rb_par within tabpage_report
end type

type rb_ai from pfc_cst_nv_net_dev_new`rb_ai within tabpage_report
end type

type dw_report_data from pfc_cst_nv_net_dev_new`dw_report_data within tabpage_report
integer height = 1412
end type

type dw_orgs_facilities from u_dw within pfc_cst_nv_net_dev_prac_folder
integer x = 5
integer y = 4
integer width = 736
integer height = 1664
integer taborder = 20
boolean titlebar = true
string title = "Select Payor/Hospital"
string dataobject = "d_pd_affil_status_orgs"
end type

event clicked;call super::clicked;Integer li_row

li_row = This.GetClickedRow( )

//DEBUGBREAK()

IF li_row = 0 THEN
	tab_1.tabpage_ai.dw_net_dev.SetFocus( )
	Return -1
END IF

This.SelectRow( 0, False )
This.SelectRow( li_row, True )
This.ScrollToRow( li_row )
This.SetRow( li_row )
end event

event constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject(SQLCA)

//$<Modify> 07.07.2008 by Andy
/*
IF gs_cust_type = "C" THEN
	This.Title = 'Select Client'
ELSEIF gs_cust_type = "I" THEN
	This.Title = 'Select Payor/Hospital'
ELSE
	This.Title = 'Select Facility'
END IF
*/
String ls_label
SELECT TOP 1 app_stat_facility_label INTO :ls_label FROM icred_settings;

if LenA(trim(ls_label)) > 0 then 
	This.Title = ls_label
end if
//end modify 07.07.2008

end event

event retrieveend;call super::retrieveend;//IF ib_first_retrieve THEN
	//of_get_this_facility_data()
//END IF
//ib_first_retrieve = False

end event

event rowfocuschanged;call super::rowfocuschanged;
IF This.RowCount() > 0  THEN
     ii_facility_id = This.GetItemNumber( currentrow, "parent_facility_id")
  	  of_retrieve_detail( ii_facility_id )
END IF

end event

event pfc_addrow;Return 0
end event

