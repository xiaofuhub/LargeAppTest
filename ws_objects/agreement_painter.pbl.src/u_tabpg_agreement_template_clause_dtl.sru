$PBExportHeader$u_tabpg_agreement_template_clause_dtl.sru
forward
global type u_tabpg_agreement_template_clause_dtl from u_tabpg
end type
type dw_properties from u_dw_contract within u_tabpg_agreement_template_clause_dtl
end type
end forward

global type u_tabpg_agreement_template_clause_dtl from u_tabpg
integer width = 1568
integer height = 1928
long backcolor = 33551856
dw_properties dw_properties
end type
global u_tabpg_agreement_template_clause_dtl u_tabpg_agreement_template_clause_dtl

on u_tabpg_agreement_template_clause_dtl.create
int iCurrent
call super::create
this.dw_properties=create dw_properties
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_properties
end on

on u_tabpg_agreement_template_clause_dtl.destroy
call super::destroy
destroy(this.dw_properties)
end on

type dw_properties from u_dw_contract within u_tabpg_agreement_template_clause_dtl
integer x = 18
integer y = 24
integer width = 1522
integer height = 1856
integer taborder = 10
string dataobject = "d_agreement_template_clause_properties"
boolean vscrollbar = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.of_setupdateable(false)
this.event ue_populatedddws()

//----------Appeon Begin --added by alfee 04.19.2007-----
datawindowchild dwc_export, dwc_reviewby

this.GetChild ("export_id", dwc_export)
this.GetChild ("approved_by", dwc_reviewby)
dwc_export.settransobject(sqlca)
dwc_reviewby.settransobject(sqlca)
//for web performance
gnv_appeondb.of_startqueue() 
	dwc_export.retrieve()
	dwc_reviewby.retrieve()	
gnv_appeondb.of_commitqueue()
//----------Appeon End -----------------

end event

event other;//
end event

event getfocus;//
end event

event losefocus;//
end event

