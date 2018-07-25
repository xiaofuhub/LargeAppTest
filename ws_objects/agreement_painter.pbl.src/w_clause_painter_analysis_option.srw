$PBExportHeader$w_clause_painter_analysis_option.srw
forward
global type w_clause_painter_analysis_option from w_response
end type
type st_1 from statictext within w_clause_painter_analysis_option
end type
type cbx_msg from checkbox within w_clause_painter_analysis_option
end type
type st_msg from statictext within w_clause_painter_analysis_option
end type
type cb_cancel from commandbutton within w_clause_painter_analysis_option
end type
type cb_ok from commandbutton within w_clause_painter_analysis_option
end type
type cb_contract_selected from commandbutton within w_clause_painter_analysis_option
end type
type rb_contract_selected from radiobutton within w_clause_painter_analysis_option
end type
type rb_contract_all from radiobutton within w_clause_painter_analysis_option
end type
type rb_clause_selected from radiobutton within w_clause_painter_analysis_option
end type
type st_contract from statictext within w_clause_painter_analysis_option
end type
type st_clauses from statictext within w_clause_painter_analysis_option
end type
type rb_clauses_all from radiobutton within w_clause_painter_analysis_option
end type
type cbx_negotiated from checkbox within w_clause_painter_analysis_option
end type
type cbx_dm_usage from checkbox within w_clause_painter_analysis_option
end type
type cbx_template_usage from checkbox within w_clause_painter_analysis_option
end type
type cbx_custom_analysis from checkbox within w_clause_painter_analysis_option
end type
type cbx_full_analysis from checkbox within w_clause_painter_analysis_option
end type
type gb_option from groupbox within w_clause_painter_analysis_option
end type
type gb_contracts from groupbox within w_clause_painter_analysis_option
end type
type gb_custom_analysis from groupbox within w_clause_painter_analysis_option
end type
type gb_other from groupbox within w_clause_painter_analysis_option
end type
end forward

global type w_clause_painter_analysis_option from w_response
integer width = 2281
integer height = 1344
boolean titlebar = false
boolean controlmenu = false
boolean border = false
long backcolor = 33551856
st_1 st_1
cbx_msg cbx_msg
st_msg st_msg
cb_cancel cb_cancel
cb_ok cb_ok
cb_contract_selected cb_contract_selected
rb_contract_selected rb_contract_selected
rb_contract_all rb_contract_all
rb_clause_selected rb_clause_selected
st_contract st_contract
st_clauses st_clauses
rb_clauses_all rb_clauses_all
cbx_negotiated cbx_negotiated
cbx_dm_usage cbx_dm_usage
cbx_template_usage cbx_template_usage
cbx_custom_analysis cbx_custom_analysis
cbx_full_analysis cbx_full_analysis
gb_option gb_option
gb_contracts gb_contracts
gb_custom_analysis gb_custom_analysis
gb_other gb_other
end type
global w_clause_painter_analysis_option w_clause_painter_analysis_option

type variables
String 				is_ctx_id
end variables

forward prototypes
public function integer of_selectcontract (ref string as_ctx_id)
public function long of_ctx_id_conut ()
end prototypes

public function integer of_selectcontract (ref string as_ctx_id);//====================================================================
// Function: of_selectcontract
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                as_ctx_id
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 03/25/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
string ls_Temp
string ls_ctxid
string ls_Return
long ll_Count
integer li_Position, i

as_ctx_id = ""
Open(w_rpt_contract_search)
ls_Return = Message.StringParm
if ls_Return = "" then Return -1

do
	ls_Temp = f_get_token(ls_Return, "|")
	li_Position = Pos(ls_Temp, "~t")
	ls_ctxid = Left(ls_Temp, li_Position - 1)
		
	if as_ctx_id <> "" then as_ctx_id += ","
	as_ctx_id += ls_ctxid
	
	ll_Count ++
loop while ls_Return <> ""

st_msg.text = String(ll_Count) + " Contract(s) Selected."

Return ll_Count
end function

public function long of_ctx_id_conut ();//====================================================================
// Function: of_ctx_id_conut
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 04/08/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long		ll_count

Select count(1) 
Into :ll_count
From ctx_basic_info
Where  ctx_id > 0 ;

Return ll_count

end function

on w_clause_painter_analysis_option.create
int iCurrent
call super::create
this.st_1=create st_1
this.cbx_msg=create cbx_msg
this.st_msg=create st_msg
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cb_contract_selected=create cb_contract_selected
this.rb_contract_selected=create rb_contract_selected
this.rb_contract_all=create rb_contract_all
this.rb_clause_selected=create rb_clause_selected
this.st_contract=create st_contract
this.st_clauses=create st_clauses
this.rb_clauses_all=create rb_clauses_all
this.cbx_negotiated=create cbx_negotiated
this.cbx_dm_usage=create cbx_dm_usage
this.cbx_template_usage=create cbx_template_usage
this.cbx_custom_analysis=create cbx_custom_analysis
this.cbx_full_analysis=create cbx_full_analysis
this.gb_option=create gb_option
this.gb_contracts=create gb_contracts
this.gb_custom_analysis=create gb_custom_analysis
this.gb_other=create gb_other
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cbx_msg
this.Control[iCurrent+3]=this.st_msg
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.cb_ok
this.Control[iCurrent+6]=this.cb_contract_selected
this.Control[iCurrent+7]=this.rb_contract_selected
this.Control[iCurrent+8]=this.rb_contract_all
this.Control[iCurrent+9]=this.rb_clause_selected
this.Control[iCurrent+10]=this.st_contract
this.Control[iCurrent+11]=this.st_clauses
this.Control[iCurrent+12]=this.rb_clauses_all
this.Control[iCurrent+13]=this.cbx_negotiated
this.Control[iCurrent+14]=this.cbx_dm_usage
this.Control[iCurrent+15]=this.cbx_template_usage
this.Control[iCurrent+16]=this.cbx_custom_analysis
this.Control[iCurrent+17]=this.cbx_full_analysis
this.Control[iCurrent+18]=this.gb_option
this.Control[iCurrent+19]=this.gb_contracts
this.Control[iCurrent+20]=this.gb_custom_analysis
this.Control[iCurrent+21]=this.gb_other
end on

on w_clause_painter_analysis_option.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cbx_msg)
destroy(this.st_msg)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cb_contract_selected)
destroy(this.rb_contract_selected)
destroy(this.rb_contract_all)
destroy(this.rb_clause_selected)
destroy(this.st_contract)
destroy(this.st_clauses)
destroy(this.rb_clauses_all)
destroy(this.cbx_negotiated)
destroy(this.cbx_dm_usage)
destroy(this.cbx_template_usage)
destroy(this.cbx_custom_analysis)
destroy(this.cbx_full_analysis)
destroy(this.gb_option)
destroy(this.gb_contracts)
destroy(this.gb_custom_analysis)
destroy(this.gb_other)
end on

event open;call super::open;String 		ls_tmp
Date 			ld_temp_usage, ld_dm_usage, ld_negotiated
Long			ll_ctx_count

cbx_full_analysis.checked = True
rb_clause_selected.checked = True
rb_contract_all.checked = True

//cbx_template_usage.checked  = True
//cbx_dm_usage.checked = True
rb_clauses_all.enabled = False
rb_clause_selected.enabled = False
rb_contract_all.enabled = False
rb_contract_selected.enabled = False

st_msg.text = ""

ls_tmp = gnv_user_option.of_Get_option_value( gs_user_id, "w_clause_painter_analysis_option_template_usage" )
If isnull(ls_tmp) or ls_tmp = '' or ls_tmp = 'Y' Then
	cbx_template_usage.checked  = True	
Else
	cbx_template_usage.checked  = False
End IF 

ls_tmp = gnv_user_option.of_Get_option_value( gs_user_id, "w_clause_painter_analysis_option_dm_usage" )
If isnull(ls_tmp) or ls_tmp = '' or ls_tmp = 'Y' Then
	cbx_dm_usage.checked  = True	
Else
	cbx_dm_usage.checked  = False
End IF 

ls_tmp = gnv_user_option.of_Get_option_value( gs_user_id, "w_clause_painter_analysis_option_negotiated" )
If isnull(ls_tmp) or ls_tmp = '' or ls_tmp = 'N' Then
	cbx_negotiated.checked  = False	
Else
	cbx_negotiated.checked  = True
End IF 

IF cbx_negotiated.checked  = True and cbx_dm_usage.checked  = False Then
	cbx_dm_usage.checked  = True
End IF 

//default
cbx_msg.checked = True

//gnv_appeondb.of_autocommit( )
//// (Last Full Analysis:1/1/2013)    
//Select Max(temp_usage_last_date) , Max(dm_usage_last_date) ,Max(negotiated_last_date) 
//Into :ld_temp_usage, :ld_dm_usage, :ld_negotiated
//From ctx_acp_clause ; 
//
ll_ctx_count = of_ctx_id_conut()			//
//gnv_appeondb.of_commitqueue( )

//If Not(isnull(ld_temp_usage) or ld_temp_usage = date('01/01/1900')) Then
//	cbx_template_usage.text = cbx_template_usage.text +"(Last Full Analysis: "+String(ld_temp_usage,'MM/dd/yyyy')+")"
//End If 
ls_tmp = gnv_user_option.of_Get_option_value( "intellisoft-super-master", "Last_Full_Clause_Analysis_date_for_temp_usage" ) //(Appeon)Harry 05.28.2014 - V142 ISG-CLX  modify "contractlogix-super-master" to "intellisoft-super-master"
If Not(isnull(ls_tmp) or ls_tmp = '') Then
	cbx_template_usage.text = cbx_template_usage.text +"(Last Full Analysis: "+String(ls_tmp)+")"
End If 
ls_tmp = gnv_user_option.of_Get_option_value( "intellisoft-super-master", "Last_Full_Clause_Analysis_date_for_dm_usage" ) //(Appeon)Harry 05.28.2014 - V142 ISG-CLX  modify "contractlogix-super-master" to "intellisoft-super-master"
If Not(isnull(ls_tmp) or ls_tmp = '') Then
	cbx_dm_usage.text = cbx_dm_usage.text +"(Last Full Analysis: "+String(ls_tmp)+")"
End If 
ls_tmp = gnv_user_option.of_Get_option_value( "intellisoft-super-master", "Last_Full_Clause_Analysis_date_for_negotiated" ) //(Appeon)Harry 05.28.2014 - V142 ISG-CLX  modify "contractlogix-super-master" to "intellisoft-super-master"
If Not(isnull(ls_tmp) or ls_tmp = '') Then
	cbx_negotiated.text = cbx_negotiated.text +"(Last Full Analysis: "+String(ls_tmp)+")"
End If 
 
st_msg.text = String(ll_ctx_count) + " Contract(s) Selected."
end event

type st_1 from statictext within w_clause_painter_analysis_option
integer x = 174
integer y = 804
integer width = 1637
integer height = 116
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Please close all MS Word documents before analyzing for Negotiated and do not use MS Word until the analysis is completed."
boolean focusrectangle = false
end type

type cbx_msg from checkbox within w_clause_painter_analysis_option
integer x = 73
integer y = 1080
integer width = 1906
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = " Quit analysis when any error occurs. "
end type

type st_msg from statictext within w_clause_painter_analysis_option
integer x = 640
integer y = 444
integer width = 1563
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_clause_painter_analysis_option
integer x = 1874
integer y = 1228
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_ok from commandbutton within w_clause_painter_analysis_option
integer x = 1472
integer y = 1228
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
boolean default = true
end type

event clicked;str_clause_painter_analysis_option		lstr_option
Integer 							li_return

IF cbx_template_usage.checked = False and cbx_dm_usage.checked = False and cbx_negotiated.checked = False Then
	Messagebox(gnv_app.iapp_object.DisplayName,"Please select the type of analysis you want to perform (Template Usage, Document Manager Usage or Negotiated). ")
	Return 
End IF 

IF cbx_msg.checked Then 
	lstr_option.abn_quit = True
Else 
	lstr_option.abn_quit = False
End IF 

If cbx_full_analysis.checked Then 
	lstr_option.as_full_analysis = 'Y'
Else
	lstr_option.as_full_analysis = 'N'
	IF rb_clauses_all.checked Then 
		lstr_option.as_all_clauses = 'Y'
	End IF
	If  rb_clause_selected.checked Then 
		lstr_option.as_all_clauses = 'N'		
	End If
	
	If rb_contract_all.checked Then 
		lstr_option.as_all_contracts = 'Y'
	End If
	If rb_contract_selected.checked Then
		lstr_option.as_all_contracts = 'N'
		If isnull(is_ctx_id) or trim(is_ctx_id) = '' Then 
			Messagebox(gnv_app.iapp_object.DisplayName,"You have to click the … button next to Selected Contract(s) and select at least one contract after you choose the Selected Contract(s) option. ")
			Return 
		End IF 
		lstr_option.as_ctx_id = is_ctx_id
	Else
		lstr_option.as_ctx_id = ''
	End If
End If 

If cbx_template_usage.checked Then 
	lstr_option.as_template_usage = 'Y'
Else
	lstr_option.as_template_usage = 'N' 
End IF 

If cbx_dm_usage.checked Then 
	lstr_option.as_dm_usage = 'Y'
Else
	lstr_option.as_dm_usage = 'N'
End IF 

If cbx_negotiated.checked Then 
	lstr_option.as_negotiated = 'Y'
	li_return  = Messagebox(gnv_app.iapp_object.DisplayName,"It may take a long time to analyze Negotiated. ~r~nDo you want to continue?", Question! , YesNo! )
	IF li_return = 2 Then 
		Return 
	End IF 
Else
	lstr_option.as_negotiated = 'N'
End IF 

gnv_user_option.of_Set_option_value(gs_user_id, "w_clause_painter_analysis_option_dm_usage",lstr_option.as_dm_usage )
gnv_user_option.of_Set_option_value(gs_user_id, "w_clause_painter_analysis_option_template_usage",lstr_option.as_template_usage )
gnv_user_option.of_Set_option_value(gs_user_id, "w_clause_painter_analysis_option_negotiated",lstr_option.as_negotiated )
//update 
gnv_user_option.of_save( )	

ClosewithReturn(Parent,lstr_option)
end event

type cb_contract_selected from commandbutton within w_clause_painter_analysis_option
integer x = 1646
integer y = 348
integer width = 82
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "..."
end type

event clicked;if of_SelectContract(is_ctx_id) < 1 then 
	Return
End IF
end event

type rb_contract_selected from radiobutton within w_clause_painter_analysis_option
integer x = 1083
integer y = 364
integer width = 562
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = " Selected Contract(s) "
end type

event clicked;If this.checked = True Then 
	st_msg.text = ""
	cb_contract_selected.enabled = True
	cb_contract_selected.event clicked( )
End If
end event

type rb_contract_all from radiobutton within w_clause_painter_analysis_option
integer x = 640
integer y = 364
integer width = 411
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = " All Contracts "
end type

event clicked;Long 			ll_ctx_count

If this.checked = True Then 
	cb_contract_selected.enabled = False
	ll_ctx_count = of_ctx_id_conut()
	st_msg.text = String(ll_ctx_count) + " Contract(s) will be updated."
End If
end event

type rb_clause_selected from radiobutton within w_clause_painter_analysis_option
integer x = 1083
integer y = 268
integer width = 544
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = " Selected Clause(s) "
end type

type st_contract from statictext within w_clause_painter_analysis_option
integer x = 201
integer y = 364
integer width = 411
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = " Contracts:     "
boolean focusrectangle = false
end type

type st_clauses from statictext within w_clause_painter_analysis_option
integer x = 201
integer y = 268
integer width = 411
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = " Clauses:               "
boolean focusrectangle = false
end type

type rb_clauses_all from radiobutton within w_clause_painter_analysis_option
integer x = 640
integer y = 268
integer width = 352
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = " All Clauses "
end type

type cbx_negotiated from checkbox within w_clause_painter_analysis_option
integer x = 73
integer y = 724
integer width = 1906
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = " Negotiated (ignore word format) "
end type

event clicked;If this.checked = True Then
	cbx_dm_usage.checked = True
End If
end event

type cbx_dm_usage from checkbox within w_clause_painter_analysis_option
integer x = 73
integer y = 636
integer width = 1906
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = " Document Manager Usage "
end type

event clicked;IF this.checked = False and cbx_negotiated.checked = True Then 
	cbx_negotiated.checked = False
End IF 
end event

type cbx_template_usage from checkbox within w_clause_painter_analysis_option
integer x = 73
integer y = 548
integer width = 1906
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = " Template Usage "
end type

type cbx_custom_analysis from checkbox within w_clause_painter_analysis_option
integer x = 73
integer y = 180
integer width = 1106
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = " Custom Analysis "
end type

event clicked;IF this.checked = True Then
	cbx_full_analysis.checked = False
	rb_clauses_all.enabled = True
	rb_clause_selected.enabled = True
	rb_contract_all.enabled = True
	rb_contract_selected.enabled = True
	If rb_contract_selected.checked Then 
		cb_contract_selected.enabled = True
	End If
Else
	cbx_full_analysis.checked = True
	rb_clauses_all.enabled = False
	rb_clause_selected.enabled = False
	rb_contract_all.enabled = False
	rb_contract_selected.enabled = False
End IF 
end event

type cbx_full_analysis from checkbox within w_clause_painter_analysis_option
integer x = 73
integer y = 100
integer width = 1161
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = " Full Analysis - for all clauses for all contracts. "
end type

event clicked;IF this.checked = True Then
	cbx_custom_analysis.checked = False
	rb_clauses_all.enabled = False
	rb_clause_selected.enabled = False
	rb_contract_all.enabled = False
	rb_contract_selected.enabled = False
	cb_contract_selected.enabled = False
Else
	cbx_custom_analysis.checked = True
	rb_clauses_all.enabled = True
	rb_clause_selected.enabled = True
	rb_contract_all.enabled = True
	rb_contract_selected.enabled = True
	If rb_contract_selected.checked Then 
		cb_contract_selected.enabled = True
	End If	
End IF 
end event

type gb_option from groupbox within w_clause_painter_analysis_option
integer x = 14
integer width = 2245
integer height = 972
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Options"
end type

type gb_contracts from groupbox within w_clause_painter_analysis_option
integer x = 155
integer y = 340
integer width = 1586
integer height = 116
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
end type

type gb_custom_analysis from groupbox within w_clause_painter_analysis_option
integer x = 155
integer y = 236
integer width = 1504
integer height = 104
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
end type

type gb_other from groupbox within w_clause_painter_analysis_option
integer x = 14
integer y = 992
integer width = 2245
integer height = 200
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Other Options"
end type

