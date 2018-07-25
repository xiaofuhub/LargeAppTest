$PBExportHeader$w_web_data_mapping.srw
forward
global type w_web_data_mapping from w_response
end type
type pb_4 from u_pb within w_web_data_mapping
end type
type pb_3 from u_pb within w_web_data_mapping
end type
type pb_2 from u_pb within w_web_data_mapping
end type
type pb_1 from u_pb within w_web_data_mapping
end type
type dw_1 from u_dw within w_web_data_mapping
end type
end forward

global type w_web_data_mapping from w_response
integer width = 2373
integer height = 1544
string title = "Data Mapping"
boolean controlmenu = false
long backcolor = 33551856
pb_4 pb_4
pb_3 pb_3
pb_2 pb_2
pb_1 pb_1
dw_1 dw_1
end type
global w_web_data_mapping w_web_data_mapping

type variables
Integer ii_wc_id
Integer ii_step_order
end variables

event open;call super::open;str_web_crawler lst_web_crawler
DataWindowChild dwchild

lst_web_crawler = Message.PowerObjectParm

ii_wc_id = lst_web_crawler.si_wc_id 
ii_step_order = lst_web_crawler.si_step_order

dw_1.of_SetTransObject( SQLCA )
dw_1.Retrieve(  lst_web_crawler.si_wc_id,  lst_web_crawler.si_step_order )

IF lst_web_crawler.ss_lookup_name = "Professional Suffix" THEN
	 dw_1.GetChild( "intellicred_data", dwchild )
	 dwchild.SetTransObject( SQLCA )
	 dwchild.Retrieve( "Professional Suffix")
	 dwchild.insertrow(1)
ELSEIF lst_web_crawler.ss_lookup_name = "Verification Response" THEN
	 dw_1.GetChild( "intellicred_data", dwchild )
	 dwchild.SetTransObject( SQLCA )
	 dwchild.Retrieve( "Credentials Verification Response")
	  dwchild.insertrow(1)
END IF

dw_1.setcolumn( 2)
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.24.2006 By: Rodger Wu
//$<reason> Fix a defect.
ib_disableclosequery = True
//---------------------------- APPEON END ----------------------------
end event

on w_web_data_mapping.create
int iCurrent
call super::create
this.pb_4=create pb_4
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_1=create pb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_4
this.Control[iCurrent+2]=this.pb_3
this.Control[iCurrent+3]=this.pb_2
this.Control[iCurrent+4]=this.pb_1
this.Control[iCurrent+5]=this.dw_1
end on

on w_web_data_mapping.destroy
call super::destroy
destroy(this.pb_4)
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.dw_1)
end on

type pb_4 from u_pb within w_web_data_mapping
integer x = 1262
integer y = 1348
integer taborder = 40
string text = "&Delete"
end type

event clicked;call super::clicked;dw_1.deleterow(0)  //Start Code Change ----08.08.2014.2014 #V14.2 maha
end event

type pb_3 from u_pb within w_web_data_mapping
integer x = 896
integer y = 1348
integer taborder = 40
string text = "Add"
end type

event clicked;call super::clicked;Integer li_nr

li_nr = dw_1.InsertRow( 0 )
dw_1.SetRow( li_nr)
dw_1.ScrollToRow( li_nr )
dw_1.SetFocus( )

dw_1.SetItem( li_nr, "wc_id", ii_wc_id )
dw_1.SetItem( li_nr, "step_order", ii_step_order )
end event

type pb_2 from u_pb within w_web_data_mapping
integer x = 1993
integer y = 1348
integer taborder = 30
string text = "&Cancel"
boolean cancel = true
end type

event clicked;call super::clicked;CloseWithReturn( Parent, String( dw_1.RowCount( ) ) )
end event

type pb_1 from u_pb within w_web_data_mapping
integer x = 1627
integer y = 1348
integer taborder = 20
string text = "&Ok"
boolean default = true
end type

event clicked;call super::clicked;dw_1.update()

CloseWithReturn( Parent, String( dw_1.RowCount( ) ) )
end event

type dw_1 from u_dw within w_web_data_mapping
integer x = 5
integer width = 2350
integer height = 1316
integer taborder = 10
string dataobject = "d_web_data_comparison"
borderstyle borderstyle = stylebox!
end type

