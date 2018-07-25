$PBExportHeader$w_screen_maint.srw
forward
global type w_screen_maint from w_response
end type
type dw_screen_maint from u_dw within w_screen_maint
end type
type cb_1 from u_cb within w_screen_maint
end type
type cb_2 from u_cb within w_screen_maint
end type
end forward

global type w_screen_maint from w_response
integer x = 713
integer y = 612
integer width = 2139
integer height = 904
string title = "Screen/Credentialing Data Setup"
long backcolor = 33551856
dw_screen_maint dw_screen_maint
cb_1 cb_1
cb_2 cb_2
end type
global w_screen_maint w_screen_maint

on w_screen_maint.create
int iCurrent
call super::create
this.dw_screen_maint=create dw_screen_maint
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_screen_maint
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_screen_maint.destroy
call super::destroy
destroy(this.dw_screen_maint)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;Integer li_screen_id
Integer li_data_view_id
DatawindowChild dwchild

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 02.07.2006 By: Wangchao
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue( )

//---------------------------- APPEON END ----------------------------

dw_screen_maint.of_SetTransObject(SQLCA)
//IF Message.StringParm = "New" THEN
//	SELECT Max(data_view_screen.screen_id)  
//   INTO :li_screen_id
//   FROM data_view_screen  
//   WHERE data_view_screen.data_view_id = :li_data_view_id   ;
//	li_screen_id ++
//	
//	dw_screen_maint.InsertRow( 0 )
//	dw_screen_maint.SetItem(1, "data_view_id", li_data_view_id )
//	dw_screen_maint.SetItem(1, "screen_id", li_screen_id )
//ELSE
//	li_screen_id = w_prac_data_design.uo_design.ii_screen_id
//	li_data_view_id = w_prac_data_design.uo_design.il_data_view_id
//	dw_screen_maint.Retrieve( li_screen_id , li_data_view_id)
//END IF

li_screen_id = Message.DoubleParm
dw_screen_maint.Retrieve( li_screen_id , 1)

dw_screen_maint.GetChild("reference_field_1", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve(1, li_screen_id)

dw_screen_maint.GetChild("reference_field_2", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve(1, li_screen_id)

dw_screen_maint.GetChild("exp_field", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve(1, li_screen_id)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 02.07.2006 By: Wangchao
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------

dw_screen_maint.SetFocus()
end event

type dw_screen_maint from u_dw within w_screen_maint
integer width = 2130
integer height = 688
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_screen_maint_dtl"
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
end type

type cb_1 from u_cb within w_screen_maint
integer x = 1349
integer y = 708
integer height = 84
integer taborder = 20
boolean bringtotop = true
string text = "&OK"
boolean default = true
end type

event clicked;IF Parent.Event pfc_Save() < 0 THEN
	Return
ELSE
	Close(Parent)
END IF
end event

type cb_2 from u_cb within w_screen_maint
integer x = 1723
integer y = 708
integer height = 84
integer taborder = 11
boolean bringtotop = true
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent, "Cancel")
end event

