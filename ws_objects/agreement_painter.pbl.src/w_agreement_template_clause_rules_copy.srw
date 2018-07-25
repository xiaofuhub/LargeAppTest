$PBExportHeader$w_agreement_template_clause_rules_copy.srw
forward
global type w_agreement_template_clause_rules_copy from w_response
end type
type st_3 from statictext within w_agreement_template_clause_rules_copy
end type
type dw_view from u_dw within w_agreement_template_clause_rules_copy
end type
type st_2 from statictext within w_agreement_template_clause_rules_copy
end type
type st_1 from statictext within w_agreement_template_clause_rules_copy
end type
type cb_cancel from commandbutton within w_agreement_template_clause_rules_copy
end type
type cb_select from commandbutton within w_agreement_template_clause_rules_copy
end type
type dw_1 from u_dw within w_agreement_template_clause_rules_copy
end type
type dw_parameter from u_dw_ctx_find within w_agreement_template_clause_rules_copy
end type
type mle_notes from multilineedit within w_agreement_template_clause_rules_copy
end type
type cbx_parent_data from checkbox within w_agreement_template_clause_rules_copy
end type
type gb_1 from groupbox within w_agreement_template_clause_rules_copy
end type
type gb_2 from groupbox within w_agreement_template_clause_rules_copy
end type
type gb_3 from groupbox within w_agreement_template_clause_rules_copy
end type
end forward

global type w_agreement_template_clause_rules_copy from w_response
integer width = 4571
integer height = 2024
string title = "Copy Clause Rule "
long backcolor = 33551856
boolean ib_disableclosequery = true
st_3 st_3
dw_view dw_view
st_2 st_2
st_1 st_1
cb_cancel cb_cancel
cb_select cb_select
dw_1 dw_1
dw_parameter dw_parameter
mle_notes mle_notes
cbx_parent_data cbx_parent_data
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_agreement_template_clause_rules_copy w_agreement_template_clause_rules_copy

type variables
str_clause_rules_copy			istr_Rules
DataWindow						idw_Parameter
Long									il_template_id, il_clause_id, il_DestClauseID, il_dataviewid
String									is_ClauseName
end variables

on w_agreement_template_clause_rules_copy.create
int iCurrent
call super::create
this.st_3=create st_3
this.dw_view=create dw_view
this.st_2=create st_2
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_select=create cb_select
this.dw_1=create dw_1
this.dw_parameter=create dw_parameter
this.mle_notes=create mle_notes
this.cbx_parent_data=create cbx_parent_data
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.dw_view
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_cancel
this.Control[iCurrent+6]=this.cb_select
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.dw_parameter
this.Control[iCurrent+9]=this.mle_notes
this.Control[iCurrent+10]=this.cbx_parent_data
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.gb_3
end on

on w_agreement_template_clause_rules_copy.destroy
call super::destroy
destroy(this.st_3)
destroy(this.dw_view)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_select)
destroy(this.dw_1)
destroy(this.dw_parameter)
destroy(this.mle_notes)
destroy(this.cbx_parent_data)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;call super::open;Long				ll_TemplateID, ll_ClauseID, ll_Data_ViewID
String				ls_ViewName
Datawindow		ldw_selected

istr_Rules = Message.PowerObjectParm	


ll_TemplateID = istr_Rules.al_templateid
ll_ClauseID =  istr_Rules.al_clauseid
idw_Parameter = istr_Rules.adw_rules
ls_ViewName = istr_Rules.as_viewname
is_ClauseName = istr_Rules.as_clausename
ll_Data_ViewID = istr_Rules.al_dataviewid

dw_1.SetTransObject( sqlca )
dw_parameter.SetTransObject( sqlca )

//clause of view
il_DestClauseID = ll_ClauseID
//dw_1.Modify( "clause_name_t.Text='Clauses on ~~'" + ls_ViewName + "~~' view'" )
//dw_1.Retrieve( ll_TemplateID, ll_Data_ViewID )
If IsValid( w_agreement_template_add_clause ) Then
	ldw_selected = w_agreement_template_add_clause.dw_selected
	
	ldw_Selected.RowsCopy( 1, ldw_selected.RowCount( ), primary!, dw_1, 1, primary! )
	dw_1.Setfilter( " sum_rules >0 and ctx_acp_clause_id <> "  + string(ll_ClauseID)  )
	dw_1.filter( )
//	dw_1.Setsort( "ctx_acp_template_id, ctx_acp_clause_id, orders")
	dw_1.Sort( )
	If dw_1.RowCount( ) > 0 Then 
		dw_1.SelectRow( 0 , false )
		dw_1.SelectRow( dw_1.GetRow( ), true )
	End If
End If


//rules
il_template_id = ll_TemplateID
If dw_1.RowCount( ) > 0 Then
	il_clause_id = dw_1.GetItemNumber( dw_1.GetRow( ), 'ctx_acp_clause_id' )
	dw_parameter.Event pfc_Retrieve( )
End If
end event

type st_3 from statictext within w_agreement_template_clause_rules_copy
integer x = 3291
integer y = 84
integer width = 128
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 134217746
long backcolor = 67108864
string text = "View"
boolean focusrectangle = false
end type

type dw_view from u_dw within w_agreement_template_clause_rules_copy
integer x = 2341
integer y = 72
integer width = 965
integer height = 96
integer taborder = 20
string dataobject = "d_select_views_dddw_list_contract"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//Added by Alfee on 02.20.2008
This.of_SetTransObject( SQLCA )
This.of_SetUpdateAble( False )

This.Modify( "data_view_id.protect = 1 data_view_id.background.color=79741120 data_view_id.dddw.useasborder='no'" )
If dw_view.RowCount( ) = 0 Then dw_view.InsertRow( 0 )
end event

event itemchanged;call super::itemchanged;
RETURN 0
end event

type st_2 from statictext within w_agreement_template_clause_rules_copy
integer x = 1861
integer y = 84
integer width = 485
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Base Clause Rule on"
boolean focusrectangle = false
end type

type st_1 from statictext within w_agreement_template_clause_rules_copy
integer x = 3991
integer y = 88
integer width = 443
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 67108864
string text = "Use Parent Data"
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_agreement_template_clause_rules_copy
integer x = 4110
integer y = 1832
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;close( Parent)
end event

type cb_select from commandbutton within w_agreement_template_clause_rules_copy
integer x = 3726
integer y = 1832
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select"
end type

event clicked;Integer		li_Return, li_i

If dw_parameter.RowCount( ) = 0  Then Return

If idw_Parameter.RowCount( ) > 0 Then
	li_Return = MessageBox( 'Tips', 'The existing Rules in the destination Clause will be removed. Are you sure you want to proceed?' , Question!, yesnocancel! , 1 )
Else
	li_Return = 1
End If
	
If li_Return = 1 Then
	idw_Parameter.RowsMove( 1, idw_Parameter.RowCount( ), primary!, idw_Parameter, 1, delete! )
	//caution : modify rules datawindow , the 'd_acp_template_clause_rules_preview' is same with rules dataobject
	dw_Parameter.RowsCopy( 1, dw_Parameter.RowCount( ), primary!, idw_Parameter, 1, primary! )
	
	For li_i =1 To idw_Parameter.RowCount( )
		idw_Parameter.SetItem( li_i, 'ctx_acp_clause_id', il_DestClauseID )
		idw_Parameter.SetItem( li_i, 'data_view_id', il_dataviewid )
	Next
End If

If li_Return =1 Or li_Return = 2 Then
	CloseWithReturn( Parent , 'ok')
	
End If
end event

type dw_1 from u_dw within w_agreement_template_clause_rules_copy
integer x = 32
integer y = 132
integer width = 1120
integer height = 1656
integer taborder = 10
string dataobject = "d_acp_clause_rule_copy_select"
boolean hscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;If RowCount( ) > 0 And CurrentRow > 0 Then
	il_clause_id = dw_1.GetItemNumber( currentrow, 'ctx_acp_clause_id' )
	dw_parameter.Event pfc_Retrieve( )
	
End If
	
end event

event constructor;call super::constructor;of_SetRowManager(TRUE)
of_SetRowSelect(TRUE)
end event

type dw_parameter from u_dw_ctx_find within w_agreement_template_clause_rules_copy
integer x = 1239
integer y = 356
integer width = 3273
integer height = 1428
integer taborder = 30
string dataobject = "d_acp_template_clause_rules_preview"
boolean ib_rmbmenu = true
end type

event pfc_retrieve;call super::pfc_retrieve;long ll_count
DatawindowChild		ldwc_child

ll_count = Retrieve(il_template_id, il_clause_id)
if ll_count < 1 then
	Return 0
else
	//Set Notes field in window
	parent.mle_notes.text = this.GetItemString(1, "rule_name")
	//Set View field accordingly
	dw_view.object.data_view_id[1] = this.object.data_view_id[1] //Alfee 02.20.2008
	il_dataviewid = dw_view.object.data_view_id[1] 
	getchild( 'screen_id', ldwc_child )
	ldwc_child.Retrieve( il_dataviewid )
	
	
end if
	

//Added By Ken.Guo 2009-07-29.
If dw_parameter.GetItemNumber(1,'used_master_ctx') = 1 Then
	cbx_parent_data.checked = True
Else
	cbx_parent_data.checked = False
End If

return ll_count 
end event

event dropdown;call super::dropdown;//moved to itemfocuschanged event - Alfee 03.26.2008
end event

event clicked;//
end event

type mle_notes from multilineedit within w_agreement_template_clause_rules_copy
integer x = 1257
integer y = 200
integer width = 3218
integer height = 124
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
integer limit = 255
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cbx_parent_data from checkbox within w_agreement_template_clause_rules_copy
integer x = 3918
integer y = 84
integer width = 64
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
boolean enabled = false
string text = "Use Parent Data"
end type

event clicked;Integer li_value0[],li_value1[]
long ll_cnt,i

//ll_cnt = dw_parameter.RowCount()
//If ll_cnt = 0 Then Return
//
//For i = 1 To ll_cnt
//	li_value0[i] = 0
//	li_value1[i] = 1
//Next

//If This.Checked Then
//	dw_parameter.object.used_master_ctx[1,ll_cnt] = li_value1[]
//Else	
//	dw_parameter.object.used_master_ctx[1,ll_cnt] = li_value0[]
//End If
//

return 1
end event

type gb_1 from groupbox within w_agreement_template_clause_rules_copy
integer x = 1234
integer y = 144
integer width = 3278
integer height = 196
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Notes"
borderstyle borderstyle = stylebox!
end type

type gb_2 from groupbox within w_agreement_template_clause_rules_copy
integer x = 1198
integer y = 32
integer width = 3342
integer height = 1776
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Clauses Rules Preview"
end type

type gb_3 from groupbox within w_agreement_template_clause_rules_copy
integer x = 9
integer y = 32
integer width = 1175
integer height = 1780
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Clauses"
end type

