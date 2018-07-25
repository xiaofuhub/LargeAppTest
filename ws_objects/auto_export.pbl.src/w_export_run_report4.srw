$PBExportHeader$w_export_run_report4.srw
forward
global type w_export_run_report4 from window
end type
type cb_1 from commandbutton within w_export_run_report4
end type
type st_1 from statictext within w_export_run_report4
end type
type sle_1 from singlelineedit within w_export_run_report4
end type
type dw_export_file from datawindow within w_export_run_report4
end type
type cb_quit from u_cb within w_export_run_report4
end type
type cb_test from commandbutton within w_export_run_report4
end type
type dw_select from datawindow within w_export_run_report4
end type
type gb_1 from groupbox within w_export_run_report4
end type
end forward

global type w_export_run_report4 from window
integer x = 1056
integer y = 484
integer width = 2267
integer height = 656
boolean titlebar = true
string title = "Export Report"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 79741120
cb_1 cb_1
st_1 st_1
sle_1 sle_1
dw_export_file dw_export_file
cb_quit cb_quit
cb_test cb_test
dw_select dw_select
gb_1 gb_1
end type
global w_export_run_report4 w_export_run_report4

type variables
long il_export_id
end variables

on w_export_run_report4.create
this.cb_1=create cb_1
this.st_1=create st_1
this.sle_1=create sle_1
this.dw_export_file=create dw_export_file
this.cb_quit=create cb_quit
this.cb_test=create cb_test
this.dw_select=create dw_select
this.gb_1=create gb_1
this.Control[]={this.cb_1,&
this.st_1,&
this.sle_1,&
this.dw_export_file,&
this.cb_quit,&
this.cb_test,&
this.dw_select,&
this.gb_1}
end on

on w_export_run_report4.destroy
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.dw_export_file)
destroy(this.cb_quit)
destroy(this.cb_test)
destroy(this.dw_select)
destroy(this.gb_1)
end on

type cb_1 from commandbutton within w_export_run_report4
integer x = 1760
integer y = 320
integer width = 247
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = " &Browse"
end type

event clicked;string docname, named

integer value
//---------Begin Modified by (Appeon)Toney 06.20.2013 for V141 ISG-CLX--------
  /*
	value = GetFileSaveName("Select File", &
	docname, named, "DOC", &
		"Text Files (*.TXT),*.TXT," + &
		" Doc Files (*.DOC), *.DOC")
	ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008      
  */
gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
value = GetFileSaveName("Select File", &
docname, named, "DOC", &
	"Text Files (*.TXT),*.TXT," + &
	" Doc Files (*.DOC), *.DOC")
gf_save_dir_path(docname) //Added by Ken.Guo on 2009-03-10
//---------End Modfiied ------------------------------------------------------------------

IF value = 1 THEN 
	sle_1.text = docname
end if
end event

type st_1 from statictext within w_export_run_report4
integer x = 96
integer y = 252
integer width = 247
integer height = 56
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Save to:"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_export_run_report4
integer x = 96
integer y = 316
integer width = 1605
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "Default"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type dw_export_file from datawindow within w_export_run_report4
boolean visible = false
integer x = 50
integer y = 656
integer width = 2272
integer height = 384
integer taborder = 40
string dataobject = "d_export_hdr"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_quit from u_cb within w_export_run_report4
integer x = 1760
integer y = 100
integer width = 421
integer height = 84
integer taborder = 30
boolean bringtotop = true
string text = "&Close"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_test from commandbutton within w_export_run_report4
integer x = 1289
integer y = 100
integer width = 421
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Run Export"
end type

event clicked;Long prac_ids[]
string ls_presentation_str
string ls_sny_retrieve
string ls_dwsyntax_str
string ERRORS
string ls_path
string ls_prompt1 //Start Code Change ---- 11-30.2006 #V7 maha
string ls_prompt2 //Start Code Change ---- 11-30.2006 #V7 maha
string ls_prompt3 //Start Code Change ---- 11-30.2006 #V7 maha
string ls_prompt //Start Code Change ---- 11-30.2006 #V7 maha
string ls_parm1 //Start Code Change ---- 11-30.2006 #V7 maha
string ls_parm2 //Start Code Change ---- 11-30.2006 #V7 maha
string ls_parm3 //Start Code Change ---- 11-30.2006 #V7 maha
string ls_arg //Start Code Change ---- 11-30.2006 #V7 maha
integer p1 //Start Code Change ---- 11-30.2006 #V7 maha
integer p2 //Start Code Change ---- 11-30.2006 #V7 maha
long ll_prac_row
n_ds lds_export_retrieve
long ll_from
long ll_to
string ls_return
long i
long ic
long ll_pracid
integer li_savedata = 0
integer li_type1
String  ls_SQL = ''
Long    ll_pracidold
Long    ll_Num
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<modify> 01.13.2006 By: Wang Chao
//$<reason> It is currently unsupported to dynamically create a visual object.
//$<modification> Replaced the visual object with a non-visual object.
//pfc_n_cst_ai_export  n_export
pfc_n_cst_ai_export_apb  n_export
//---------------------------- APPEON END ----------------------------
integer li_prompt
integer li_save_data = 0
string ls_where
//debugbreak()

if isnull(il_export_id) or il_export_id < 1 then
	messagebox("Select error","Please select an export.")
	return
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-02
//$<modify> 01.13.2006 By: Wang Chao
//$<reason> It is currently unsupported to dynamically create a visual object.
//$<modification> Replaced the visual object with a non-visual object.
//n_export = CREATE pfc_n_cst_ai_export
n_export = CREATE pfc_n_cst_ai_export_apb
//---------------------------- APPEON END ----------------------------

//Start Code Change ---- 06.05.2007 #V7maha
if LenA(sle_1.text) < 3  or upper(MidA(sle_1.text,1,7)) = "DEFAULT" then
	ls_path = dw_export_file.getitemstring(1,"save_path")
else
	ls_path = sle_1.text
end if
//End Code Change---06.05.2007

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-11-28 By: Rodger Wu (doc painter)
integer li_type

li_type = dw_export_file.GetItemNumber( 1, "export_type" )
//---------------------------- APPEON END ----------------------------

//get prac list
ls_sny_retrieve = dw_export_file.getitemstring(1,"prac_sql")

//Start Code Change ---- 11.30.2006 #V7 maha
ls_prompt1 = dw_export_file.getitemstring(1,"prompt_type1")
ls_prompt2 = dw_export_file.getitemstring(1,"prompt_type2")
ls_prompt3 =dw_export_file.getitemstring(1,"prompt_type3")
choose case ls_prompt1
	case "C","D","N"
		ls_prompt = ls_prompt1
end choose
choose case ls_prompt2
	case "C","D","N"
		ls_prompt += "*" + ls_prompt2
end choose
choose case ls_prompt3
	case "C","D","N"
		ls_prompt += "*" + ls_prompt3
end choose
li_prompt = LenA( ls_prompt)
//End Code Change---11.30.2006

IF isnull(ls_sny_retrieve) or ls_sny_retrieve = "" then
	open(w_export_test_param)
	ls_return = message.stringparm
	
	if ls_return = "Cancel" then
		if IsValid(n_export) then destroy n_export
		return
	end if
	
	ll_from = long(MidA(ls_return,1,PosA(ls_return,"@") - 1))
	//messagebox("ls_from",ll_from)
	ll_to = long(MidA(ls_return,PosA(ls_return,"@") + 1))
	//messagebox("ll_to",ll_to)
	ic = ll_to - ll_from + 1
	//messagebox("ic",ic)
	if ic < 0 then
		//messagebox("Input Error","The To: value cannot be less that the From: value.")
		messagebox("Input Error","The To value must be greater than the From value.")
		if IsValid(n_export) then destroy n_export
		return
	end if
		
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 05.18.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	ll_pracid = ll_from
	for i = 1 to ic
		prac_ids[i] = ll_pracid
		ll_pracid++
	next
	*/
	//Modify 07/13/2007 by: Andy
	//ls_sny_retrieve = 'Select distinct ctx_id from ctx_basic_info where ctx_id between ' + string(ll_from) + ' and ' + string(ll_to) + ';'
	//if li_type = 3 or li_type = 4 then
	if li_type = 3 or li_type = 4 or li_type = 6 then 	//(Appeon)long.zhang 05.17.2014 (v14.2 Provider-Contract direct linking)
		ls_sny_retrieve = 'Select distinct ctx_id from ctx_basic_info where ctx_id between ' + string(ll_from) + ' and ' + string(ll_to) + ';'
	else
		ls_sny_retrieve = 'Select distinct prac_id from pd_basic where prac_id between ' + string(ll_from) + ' and ' + string(ll_to) + ';'
	end if
	//end of modify
	
	ls_presentation_str = "style(type=grid)"		
	
	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sny_retrieve, ls_presentation_str, ERRORS)
	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"SyntaxFromSQL caused these errors: " + ERRORS)
		if IsValid(n_export) then destroy n_export		
		RETURN -1
	END IF
	
	lds_export_retrieve = CREATE n_ds
	lds_export_retrieve.Create( ls_dwsyntax_str, ERRORS)
	lds_export_retrieve.SetTransObject( SQLCA )
	ll_prac_row = lds_export_retrieve.retrieve()
	if ll_prac_row < 1 then 
		//if li_type = 3 or li_type = 4 then
		if li_type = 3 or li_type = 4 or li_type = 6 then	//(Appeon)long.zhang 05.17.2014 (v14.2 Provider-Contract direct linking)
			messagebox("No contract rows returned",ll_prac_row)
		else
			messagebox("No practitioner rows returned",ll_prac_row)
		end if
		if IsValid(n_export) then destroy n_export
		if IsValid(lds_export_retrieve) then destroy lds_export_retrieve
		return -2
	end if
	
	//<add> 07/12/2007 by: Andy
	lds_export_retrieve.Setsort( "#1 A")
	lds_export_retrieve.Sort()
	//end of add
		
	for i = 1 to ll_prac_row
		prac_ids[i] = lds_export_retrieve.getitemnumber(i,1)
	next
	
	//<add> 07/17/2007 by: Andy
	li_type1 = 3
	//end of add
	
	//---------------------------- APPEON END ----------------------------
else
	//<add> 07/17/2007 by: Andy
	li_type1 = 1
	ls_SQL = ls_sny_retrieve
	//end of add
	
	if li_prompt > 0 then
		openwithparm(w_export_prompt,ls_prompt)
		ls_prompt = message.stringparm//maha 
		if ls_prompt = "Cancel" then return 1
		//parse through the string
		//ls_where = 
		ls_arg = ls_prompt
		
		p1 = PosA(ls_arg,"*",1)
		ls_parm1 = MidA(ls_arg,1,p1 - 1)
		
		p2 = PosA(ls_arg,"*",p1 + 1)
		if p2 > 0 then 
			ls_parm2 = MidA(ls_arg,p1 + 1,p2 - p1 - 1)
		
			if p2 < LenA(ls_arg) then //check for third param
				ls_parm3 = MidA(ls_arg,p2 + 1)
			end if
		end if
		//syntax for prac list
		ls_sny_retrieve = n_export.of_prompt_syntax(ls_sny_retrieve,ls_parm1,ls_parm2,ls_parm3)
	end if
	
	
	ls_presentation_str = "style(type=grid)"		
	
	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sny_retrieve, ls_presentation_str, ERRORS)
	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"SyntaxFromSQL caused these errors: " + ERRORS)
		RETURN -1
	END IF
	
	lds_export_retrieve = CREATE n_ds
	lds_export_retrieve.Create( ls_dwsyntax_str, ERRORS)
	lds_export_retrieve.SetTransObject( SQLCA )
	ll_prac_row = lds_export_retrieve.retrieve()
	if ll_prac_row < 1 then 

		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 2006-11-28 By: Rodger Wu (doc painter)
		//$<reason> 
		//if li_type = 3 or li_type = 4 then
		if li_type = 3 or li_type = 4 or li_type = 6 then //(Appeon)long.zhang 05.17.2014 (v14.2 Provider-Contract direct linking)
			messagebox("No contract rows returned",ll_prac_row)
		else
			messagebox("No practitioner rows returned",ll_prac_row)
		end if
		//---------------------------- APPEON END ----------------------------
		if IsValid(n_export) then destroy n_export
		if IsValid(lds_export_retrieve) then destroy lds_export_retrieve
		return -2
	end if
	
	//<add> 07/12/2007 by: Andy
	lds_export_retrieve.Setsort( "#1 A")
	lds_export_retrieve.Sort()
	//end of add
	
	//lds_export_retrieve.retrieve()
	//Modify 07/13/2007 by: Andy Reason:filter repeated data
	for i = 1 to ll_prac_row
		ll_pracid   = lds_export_retrieve.getitemnumber(i,1)
		if ll_pracid <> ll_pracidold then
			ll_Num ++
			prac_ids[ll_Num] = ll_pracid
			ll_pracidold= ll_pracid
		end if
	next
	//end of modify
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-11-28 By: Rodger Wu (doc painter)
//<reason> Support contract data export.
/* n_export.of_export_data_with_text( il_export_id, prac_ids,ls_path,li_save_data,"","","" ) */

//if li_type = 3 or li_type = 4 then 
if li_type = 3 or li_type = 4 or li_type = 6 then  //(Appeon)long.zhang 05.17.2014 (v14.2 Provider-Contract direct linking)
	n_export.of_export_data_with_text_ctx( il_export_id, prac_ids,ls_path,li_save_data, "", "", "",li_type1,ls_sql )
else
	n_export.of_export_data_with_text( il_export_id, prac_ids,ls_path,li_save_data,"","","",li_type1,ls_sql )
end if
//---------------------------- APPEON END ----------------------------
//<add> 07/13/2007 by: Andy
destroy n_export;
destroy lds_export_retrieve

return 1

//+++++++++++++++++++The old code is:++++++++++++++++
//Long prac_ids[]
//string ls_presentation_str
//string ls_sny_retrieve
//string ls_dwsyntax_str
//string ERRORS
//string ls_path
//long ll_prac_row
//n_ds lds_export_retrieve
//long ll_from
//long ll_to
//string ls_return
//long i
//long ic
//long ll_pracid
//integer li_savedata = 0
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> UM-01
////$<modify> 01.13.2006 By: Wang Chao
////$<reason> It is currently unsupported to dynamically create a visual object.
////$<modification> Replaced the visual object with a non-visual object.
////pfc_n_cst_ai_export  n_export
//pfc_n_cst_ai_export_apb  n_export
////---------------------------- APPEON END ----------------------------
//integer li_prompt
//integer li_save_data = 0
//string ls_prompt
//string ls_where
////debugbreak()
//
//if isnull(il_export_id) or il_export_id < 1 then
//	messagebox("Select error","Please select an export.")
//	return
//end if
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> UM-02
////$<modify> 01.13.2006 By: Wang Chao
////$<reason> It is currently unsupported to dynamically create a visual object.
////$<modification> Replaced the visual object with a non-visual object.
////n_export = CREATE pfc_n_cst_ai_export
//n_export = CREATE pfc_n_cst_ai_export_apb
////---------------------------- APPEON END ----------------------------
//
//if len(sle_1.text) < 3  or upper(mid(sle_1.text,1,7)) = "DEFAULT" then
//	ls_path = dw_export_file.getitemstring(1,"save_path")
//end if
//
//ls_sny_retrieve = dw_export_file.getitemstring(1,"prac_sql")
//li_prompt = dw_export_file.getitemnumber(1,"prompt_type")
//
//IF isnull(ls_sny_retrieve) or ls_sny_retrieve = "" then
//	open(w_export_test_param)
//	ls_return = message.stringparm
//	
//	if ls_return = "Cancel" then return
//	
//	ll_from = long(mid(ls_return,1,pos(ls_return,"@") - 1))
//	//messagebox("ls_from",ll_from)
//	ll_to = long(mid(ls_return,pos(ls_return,"@") + 1))
//	//messagebox("ll_to",ll_to)
//	ic = ll_to - ll_from + 1
//	//messagebox("ic",ic)
//	if ic < 0 then
//		messagebox("Input Error","The To: value cannot be less that the From: value.")
//		return
//	end if
//	
//	ll_pracid = ll_from
//	
//	for i = 1 to ic
//		prac_ids[i] = ll_pracid
//		ll_pracid++
//	next
//
//else	
//	if li_prompt > 0 then
//		openwithparm(w_export_prompt,li_prompt)
//		ls_prompt = message.stringparm
//		if ls_prompt = "Cancel" then return 1
//		//parse through the string
//		//ls_where = 
//		
//	end if
//	
//	ls_presentation_str = "style(type=grid)"		
//	
//	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sny_retrieve, ls_presentation_str, ERRORS)
//	IF Len(ERRORS) > 0 THEN
//		MessageBox("Caution", &
//		"SyntaxFromSQL caused these errors: " + ERRORS)
//		RETURN -1
//	END IF
//	
//	lds_export_retrieve = CREATE n_ds
//	lds_export_retrieve.Create( ls_dwsyntax_str, ERRORS)
//	lds_export_retrieve.SetTransObject( SQLCA )
//	ll_prac_row = lds_export_retrieve.retrieve()
//	if ll_prac_row < 1 then 
//		messagebox("No practitioner rows returned",ll_prac_row)
//		return -2
//	end if
//	
//	//lds_export_retrieve.retrieve()
//	for i = 1 to ll_prac_row
//		ll_pracid   = lds_export_retrieve.getitemnumber(i,1)
//	next
//end if
//
//
//
//n_export.of_export_data_with_text( il_export_id, prac_ids,ls_path,li_save_data,"","","" )
//
//
//
//return 1

end event

type dw_select from datawindow within w_export_run_report4
integer x = 101
integer y = 104
integer width = 1093
integer height = 80
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_export_hdr_list"
boolean border = false
boolean livescroll = true
end type

event itemchanged;integer cnt
il_export_id = Integer( data )

dw_export_file.settransobject(sqlca)
dw_export_file.Retrieve( il_export_id )


end event

event constructor;this.settransobject(sqlca)
this.retrieve()
this.insertrow(1)
end event

type gb_1 from groupbox within w_export_run_report4
integer x = 50
integer y = 40
integer width = 1157
integer height = 184
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 67108864
string text = "Select Export File"
end type

