$PBExportHeader$w_priv_expand_form.srw
forward
global type w_priv_expand_form from w_response
end type
type mle_text from multilineedit within w_priv_expand_form
end type
type cb_print from commandbutton within w_priv_expand_form
end type
type cb_close from commandbutton within w_priv_expand_form
end type
type dw_report from u_dw within w_priv_expand_form
end type
end forward

global type w_priv_expand_form from w_response
integer width = 4055
integer height = 2940
string title = "Privilege Form"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = popup!
long backcolor = 33551856
mle_text mle_text
cb_print cb_print
cb_close cb_close
dw_report dw_report
end type
global w_priv_expand_form w_priv_expand_form

on w_priv_expand_form.create
int iCurrent
call super::create
this.mle_text=create mle_text
this.cb_print=create cb_print
this.cb_close=create cb_close
this.dw_report=create dw_report
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_text
this.Control[iCurrent+2]=this.cb_print
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.dw_report
end on

on w_priv_expand_form.destroy
call super::destroy
destroy(this.mle_text)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.dw_report)
end on

event open;call super::open;//Start Code Change ----06.22.2011 #V11 maha - added window

gs_variable_array lgs_structure
string s
long ll_facil
long ll_clin

lgs_structure = message.powerobjectparm

s =  lgs_structure.as_string[1] 
ll_facil =  lgs_structure.as_number[1] 
ll_clin =  lgs_structure.as_number[2] 

dw_report.dataobject = s
dw_report.settransobject(sqlca)
dw_report.retrieve(ll_facil,ll_clin)

dw_report.Modify("DataWindow.Print.Preview=Yes")   //Start Code Change ----11.19.2012 #V12 maha - put in preview mode

//------------------- APPEON BEGIN -------------------
//<$>Delete:Stephen 04.03.2013
//<$>Reason:Issues with Privileging -bug 3447
//$<add> Michael 05.28.2012
//$<reason>set header field height 
/*
n_cst_priv_height lu_set_height
lu_set_height = create n_cst_priv_height
lu_set_height.of_set_height(dw_report,mle_text)
destroy lu_set_height
*/
//------------------- APPEON END ---------------------


//------------------- APPEON BEGIN -------------------
//$<delete> Michael 05.28.2012
//$<reason> set header field height
/*
//------------------- APPEON BEGIN -------------------
//$<add> Michael 04.26.2012
//$<reason> Privilege Template Headers being cut off
//add d_form_priv_by_clin_area_d_f3,d_form_priv_by_clin_area_d_f4,d_form_priv_request_master_f2,d_form_priv_request_master_f3,d_form_priv_request_master_f4 Michael 04.10.2012
string ls_text
integer li_cnt, li_height, li_width
datawindowchild ldwc_1

If Upper(appeongetclienttype()) <> "PB" Then
	if dw_report.dataobject  = "d_form_clin_priv_request_master_h" or dw_report.dataobject  = "d_form_clin_priv_request_master_d"  or  dw_report.dataobject  = "d_form_priv_request_master_f2" or  dw_report.dataobject  = "d_form_priv_request_master_f3" or  dw_report.dataobject  = "d_form_priv_request_master_f4"  then
		
		dw_report.getchild("dw_1",ldwc_1)
		li_width = integer(ldwc_1.describe("priv_template_header_text.width"))
		mle_text.width = li_width		
		if ldwc_1.rowcount() >0 then 
			ls_text = ldwc_1.getitemstring(1,"priv_template_header_text")
			mle_text.text = ls_text
			li_cnt = mle_text.linecount() - 1
			li_height = integer(ldwc_1.describe("datawindow.header.height")) + li_cnt * 68 + 10
			ldwc_1.modify("datawindow.header.height = '"+string(li_height)+"'")
		end if		
	end if
	if dw_report.dataobject  = "d_form_priv_by_clin_area_d_f2" or dw_report.dataobject  = "d_form_priv_by_clin_area_f2" or dw_report.dataobject  = "d_form_priv_by_clin_area_d" or dw_report.dataobject  = "d_form_priv_by_clin_area_h"  or  dw_report.dataobject  ="d_form_priv_by_clin_area_d_f3"  or  dw_report.dataobject  ="d_form_priv_by_clin_area_d_f4" then
		li_width = integer(dw_report.describe("priv_template_header_text.width"))
		mle_text.width = li_width		
		if  dw_report.rowcount() > 0 then
			ls_text =  dw_report.getitemstring(1,"priv_template_header_text")
			mle_text.text = ls_text
			li_cnt = mle_text.linecount() - 1
			
			li_height = integer(dw_report.describe("datawindow.header.height")) + li_cnt * 68 + 10
			dw_report.modify("datawindow.header.height = '"+string(li_height)+"'")
		end if
	end if
end if
//------------------- APPEON END -------------------

//------------------- APPEON BEGIN -------------------
//$<add> Michael 04.26.2012
//$<reason>Apha id 2988 - Exclusive Contract text doesn't preview correctly in reports
If Upper(appeongetclienttype()) <> "PB" Then
	if dw_report.dataobject  = "d_form_priv_request_master_f4" or dw_report.dataobject  = "d_form_priv_request_master_f3" or dw_report.dataobject  = "d_form_priv_request_master_f2"  or dw_report.dataobject  ="d_form_priv_request_master_f2" then		
		dw_report.getchild("dw_1",ldwc_1)
		if ldwc_1.getitemnumber(ldwc_1.getrow(),"use_exclusive") = 1 then
			li_width = integer(ldwc_1.describe("priv_template_excl_cont_text.width"))
			mle_text.width = li_width		
			if ldwc_1.rowcount() >0 then 
				ls_text = ldwc_1.getitemstring(1,"priv_template_excl_cont_text")
				mle_text.text = ls_text
				li_cnt = mle_text.linecount() - 1
				li_height = integer(ldwc_1.describe("datawindow.header.height")) + li_cnt * 68 + 10
				ldwc_1.modify("datawindow.header.height = '"+string(li_height)+"'")
			end if	
		end if
	end if
	if dw_report.dataobject  = "d_form_priv_by_clin_area_d_f4" or dw_report.dataobject  = "d_form_priv_by_clin_area_d_f3" or dw_report.dataobject  = "d_form_priv_by_clin_area_d_f2" or dw_report.dataobject  = "d_form_priv_by_clin_area_f2" 	then																				  			
		if dw_report.getitemnumber(dw_report.getrow() ,"use_exclusive") = 1  then
			li_width = integer(dw_report.describe("priv_template_excl_cont_text.width"))
			mle_text.width = li_width		
			if  dw_report.rowcount() > 0 then
				ls_text =  dw_report.getitemstring(1,"priv_template_excl_cont_text")
				mle_text.text = ls_text
				li_cnt = mle_text.linecount() - 1
				
				li_height = integer(dw_report.describe("datawindow.header.height")) + li_cnt * 68 + 10
				dw_report.modify("datawindow.header.height = '"+string(li_height)+"'")
			end if
		end if
	end if
end if
//------------------- APPEON END -------------------
*/
//------------------- APPEON END ---------------------
end event

event resize;call super::resize;//Start Code Change ----11.19.2012 #V12 maha - added with change to window type to popup
long lx
long ly

lx = this.width - 192
ly = this.height - 320

dw_report.Resize(lx, ly)
end event

type mle_text from multilineedit within w_priv_expand_form
boolean visible = false
integer x = 1367
integer y = 48
integer width = 411
integer height = 324
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_print from commandbutton within w_priv_expand_form
integer x = 3232
integer y = 20
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

event clicked;dw_report.print( )
end event

type cb_close from commandbutton within w_priv_expand_form
integer x = 3607
integer y = 20
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;Close (parent)
end event

type dw_report from u_dw within w_priv_expand_form
integer y = 128
integer width = 4014
integer height = 2704
integer taborder = 20
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

