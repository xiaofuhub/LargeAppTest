$PBExportHeader$u_tabpage_report_graph.sru
forward
global type u_tabpage_report_graph from u_tabpg
end type
type dw_graph from u_dw within u_tabpage_report_graph
end type
type cbx_primary_only from checkbox within u_tabpage_report_graph
end type
end forward

global type u_tabpage_report_graph from u_tabpg
integer width = 3991
integer height = 2328
long backcolor = 33551856
string text = "Graph"
string picturename = "Graph!"
dw_graph dw_graph
cbx_primary_only cbx_primary_only
end type
global u_tabpage_report_graph u_tabpage_report_graph

type variables
w_report iw_parent_window
end variables

on u_tabpage_report_graph.create
int iCurrent
call super::create
this.dw_graph=create dw_graph
this.cbx_primary_only=create cbx_primary_only
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_graph
this.Control[iCurrent+2]=this.cbx_primary_only
end on

on u_tabpage_report_graph.destroy
call super::destroy
destroy(this.dw_graph)
destroy(this.cbx_primary_only)
end on

event constructor;call super::constructor;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : constructor
//==================================================================================================================
//  Purpose   	:
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	    
//==================================================================================================================
//  Created By	: Michael Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


this.of_setresize( true)
//Start Code By Jervis 11.08.2007
//Prevent set dw zoom
this.inv_resize.of_setdwzoom( false)
//End Code By Jervis 11.08.2007

this.of_getparentwindow( iw_parent_window)
end event

type dw_graph from u_dw within u_tabpage_report_graph
integer width = 3986
integer height = 2324
integer taborder = 10
boolean bringtotop = true
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;This.of_Setupdateable(False )
end event

event pfc_retrieve;call super::pfc_retrieve;IF This.DataObject = "d_expiring_credentials_graph" THEN
	Return This.Retrieve( Today(), RelativeDate( Today(), 30 ), RelativeDate( Today(), 60 ), RelativeDate( Today(), 90 ))
END IF

Return 0
end event

type cbx_primary_only from checkbox within u_tabpage_report_graph
boolean visible = false
integer x = 2208
integer y = 408
integer width = 1024
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 80269524
string text = "Use Primary Department Only"
end type

event clicked;if this.checked = true then 
	iw_parent_window.ii_prime_dept_only = 1
else
	iw_parent_window.ii_prime_dept_only = 0
end if

//messagebox("ii_prime_dept_only",ii_prime_dept_only)
end event

