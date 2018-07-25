$PBExportHeader$pfc_cst_u_cert_periods.sru
forward
global type pfc_cst_u_cert_periods from userobject
end type
type dw_cme from u_dw within pfc_cst_u_cert_periods
end type
type dw_certs from u_dw within pfc_cst_u_cert_periods
end type
type dw_screens from u_dw within pfc_cst_u_cert_periods
end type
end forward

global type pfc_cst_u_cert_periods from userobject
integer width = 2779
integer height = 1812
long backcolor = 16711935
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_cme dw_cme
dw_certs dw_certs
dw_screens dw_screens
end type
global pfc_cst_u_cert_periods pfc_cst_u_cert_periods

on pfc_cst_u_cert_periods.create
this.dw_cme=create dw_cme
this.dw_certs=create dw_certs
this.dw_screens=create dw_screens
this.Control[]={this.dw_cme,&
this.dw_certs,&
this.dw_screens}
end on

on pfc_cst_u_cert_periods.destroy
destroy(this.dw_cme)
destroy(this.dw_certs)
destroy(this.dw_screens)
end on

type dw_cme from u_dw within pfc_cst_u_cert_periods
integer y = 1292
integer width = 2775
integer height = 516
integer taborder = 20
end type

type dw_certs from u_dw within pfc_cst_u_cert_periods
integer x = 768
integer width = 2007
integer height = 1288
integer taborder = 10
end type

type dw_screens from u_dw within pfc_cst_u_cert_periods
integer width = 768
integer height = 1288
integer taborder = 10
end type

