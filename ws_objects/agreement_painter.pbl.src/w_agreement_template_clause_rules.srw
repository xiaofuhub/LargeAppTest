$PBExportHeader$w_agreement_template_clause_rules.srw
forward
global type w_agreement_template_clause_rules from w_response
end type
type cb_copy from commandbutton within w_agreement_template_clause_rules
end type
type cb_resize from commandbutton within w_agreement_template_clause_rules
end type
type cbx_parent_data from checkbox within w_agreement_template_clause_rules
end type
type dw_view from u_dw within w_agreement_template_clause_rules
end type
type st_1 from statictext within w_agreement_template_clause_rules
end type
type cb_verify from commandbutton within w_agreement_template_clause_rules
end type
type dw_1 from u_dw within w_agreement_template_clause_rules
end type
type mle_notes from multilineedit within w_agreement_template_clause_rules
end type
type dw_parameter from u_dw_ctx_find within w_agreement_template_clause_rules
end type
type cb_cancel from commandbutton within w_agreement_template_clause_rules
end type
type cb_ok from commandbutton within w_agreement_template_clause_rules
end type
type cb_delete from commandbutton within w_agreement_template_clause_rules
end type
type cb_add from commandbutton within w_agreement_template_clause_rules
end type
type gb_1 from groupbox within w_agreement_template_clause_rules
end type
type gb_2 from groupbox within w_agreement_template_clause_rules
end type
type st_2 from statictext within w_agreement_template_clause_rules
end type
end forward

global type w_agreement_template_clause_rules from w_response
integer width = 3479
integer height = 1232
string title = "Add Clause Rule"
boolean controlmenu = false
long backcolor = 33551856
event ue_nclbuttondblclk pbm_nclbuttondblclk
cb_copy cb_copy
cb_resize cb_resize
cbx_parent_data cbx_parent_data
dw_view dw_view
st_1 st_1
cb_verify cb_verify
dw_1 dw_1
mle_notes mle_notes
dw_parameter dw_parameter
cb_cancel cb_cancel
cb_ok cb_ok
cb_delete cb_delete
cb_add cb_add
gb_1 gb_1
gb_2 gb_2
st_2 st_2
end type
global w_agreement_template_clause_rules w_agreement_template_clause_rules

type variables
Integer 	ii_viewid //02.20.2008
Long 		il_template_id, il_clause_id
Long 		ii_last_viewid, ii_last_screenid //03.26.2008
String 	is_notes =''

DataStore ids_rules

end variables

forward prototypes
public function long of_selectscreen ()
end prototypes

event ue_nclbuttondblclk;//====================================================================
// Event: ue_nclbuttondblclk
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                hittestcode
//                xpos
//                ypos
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 07/11/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
if This.Windowstate = Maximized! then
	This.Windowstate = Normal!
else
	This.Windowstate = Maximized!
end if

return 1

end event

public function long of_selectscreen ();Long i,ll_screen_id_include[]
str_TabPageScreen         lstr_Screen

For i = 1 To dw_parameter.idwc_screen.RowCount()
	ll_screen_id_include[i] = dw_parameter.idwc_screen.getitemnumber(i,'screen_id')
Next

lstr_Screen.ab_DispEmpty = false
lstr_Screen.al_view_id = ii_viewid
lstr_Screen.as_screen[] = ll_screen_id_include[]


OpenWithParm(w_contract_select_screen,lstr_Screen)

Return Message.DoubleParm

end function

on w_agreement_template_clause_rules.create
int iCurrent
call super::create
this.cb_copy=create cb_copy
this.cb_resize=create cb_resize
this.cbx_parent_data=create cbx_parent_data
this.dw_view=create dw_view
this.st_1=create st_1
this.cb_verify=create cb_verify
this.dw_1=create dw_1
this.mle_notes=create mle_notes
this.dw_parameter=create dw_parameter
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.gb_1=create gb_1
this.gb_2=create gb_2
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_copy
this.Control[iCurrent+2]=this.cb_resize
this.Control[iCurrent+3]=this.cbx_parent_data
this.Control[iCurrent+4]=this.dw_view
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.cb_verify
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.mle_notes
this.Control[iCurrent+9]=this.dw_parameter
this.Control[iCurrent+10]=this.cb_cancel
this.Control[iCurrent+11]=this.cb_ok
this.Control[iCurrent+12]=this.cb_delete
this.Control[iCurrent+13]=this.cb_add
this.Control[iCurrent+14]=this.gb_1
this.Control[iCurrent+15]=this.gb_2
this.Control[iCurrent+16]=this.st_2
end on

on w_agreement_template_clause_rules.destroy
call super::destroy
destroy(this.cb_copy)
destroy(this.cb_resize)
destroy(this.cbx_parent_data)
destroy(this.dw_view)
destroy(this.st_1)
destroy(this.cb_verify)
destroy(this.dw_1)
destroy(this.mle_notes)
destroy(this.dw_parameter)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.st_2)
end on

event open;call super::open;String ls_parm
Integer li_pos

//Get current template and clause id
ls_parm = Message.StringParm
li_pos = Pos(ls_parm,"|")
IF li_pos > 0 THEN
	il_template_id = Long(Left(ls_parm, li_pos -1))
	il_clause_id = Long(Right(ls_parm, Len(ls_parm) - li_pos))
END IF

ids_rules = Create DataStore
ids_rules.DataObject = dw_parameter.DataObject

//-------Begin Modified by Alfee on 02.20.2008-----------
//Get current rules
dw_parameter.event pfc_retrieve()

//Store init values
is_notes = mle_notes.text
IF dw_view.rowcount() > 0 THEN ii_viewid = dw_view.GetItemNumber(1, "data_view_id")

//Initilize the screen dddw

//il_screen_id_include[1] = 1
//il_screen_id_include[2] = 2
//il_screen_id_include[3] = 3
//il_screen_id_include[4] = 4

dw_parameter.Post event ue_init_screen_dddw(ii_viewid)
//dw_parameter.of_init_screen_dddw(ii_viewid,il_screen_id_include[])

//dw_parameter.Post event pfc_retrieve()
//dw_parameter.Post event pfc_retrievedddw('screen_id')
////Store init notes value
//is_notes = mle_notes.text
//-------End Modified -----------------------------------


end event

event close;call super::close;Destroy ids_rules
end event

event closequery;//Overrided by Alfee 01.04.2008
Long ll_cnt, i, li_msg

dw_parameter.AcceptText() //12.10.2008

IF dw_parameter.DeletedCount() > 0 THEN
	li_msg = MessageBox("Validation","The information has been changed. Close without saving changes?", &
					exclamation!, YesNo!, 2)
	IF li_msg = 1 THEN
		RETURN 0
	ELSE
		RETURN 1
	END IF
END IF

//-------Begin Modified by Alfee 12.10.2008 ----------------------
IF dw_parameter.modifiedcount( ) > 0 THEN
	li_msg = MessageBox("Validation","The information has been changed. Close without saving changes?", &
					exclamation!, YesNo!, 2)
	IF li_msg = 1 THEN
		RETURN 0
	ELSE
		RETURN 1
	END IF
END IF
/* ll_cnt = dw_parameter.RowCount() 
FOR i = 1 to ll_cnt
	IF dw_parameter.GetItemStatus(i, 0, Primary!) <> NotModified! THEN
		li_msg = MessageBox("Validation","The information has been changed. Close without saving changes?", &
						exclamation!, YesNo!, 2)
		IF li_msg = 1 THEN
			RETURN 0
		ELSE
			RETURN 1
		END IF
	END IF
NEXT */
//-------End Modified -----------------------------------------------

RETURN 0 //Alfee 01.10.2008
end event

event resize;call super::resize;//Begin - Added By Mark Lee 07/09/12 add for maximized button
if SizeType = 0 then
	cb_resize.text = '&Maximized'
elseif SizeType = 2 then
	cb_resize.text = '&Normal'
end if

//dw_parameter.height = newheight - dw_parameter.y - 130
//dw_parameter.width = newwidth - dw_parameter.x - 30
//
//cb_resize.y =  dw_parameter.height + dw_parameter.y + 10 
//cb_verify.y  = cb_resize.y
//cb_ok.y	    = cb_resize.y	
//cb_cancel.y = cb_resize.y	
//
//cb_cancel.x = dw_parameter.x + dw_parameter.width - 343
//cb_ok.x	    = cb_cancel.x - 10 - 343
//cb_verify.x  = cb_ok.x - 10 - 343
//cb_resize.x = cb_verify.x - 10 - 343
//
//cb_add.y		= cb_resize.y	
//cb_delete.y  = cb_resize.y	
//
//End - Added By Mark Lee 07/09/12

//if isvalid(inv_resize) then
//   this.inv_resize.of_resize( this.control[],handle(this)  )
//end if
//

dw_parameter.of_resize( )
end event

event pfc_preopen;call super::pfc_preopen;//Begin - Added By Mark Lee 07/11/12
this.of_setresize(true)
this.inv_resize.of_setminsize( 800, 600 )
this.inv_resize.of_SetOrigSize(this.WorkSpaceWidth(), this.WorkSpaceHeight())
//this.inv_resize.of_SetMinSize(this.WorkSpaceWidth(), this.WorkSpaceHeight())

this.inv_resize.of_Register(gb_2, this.inv_resize.SCALERIGHT)
this.inv_resize.of_Register(st_1,this.inv_resize.SCALERIGHT)
this.inv_resize.of_Register(st_2,this.inv_resize.SCALERIGHT)
this.inv_resize.of_Register(dw_view,this.inv_resize.SCALERIGHT)
this.inv_resize.of_Register(cbx_parent_data, this.inv_resize.FIXEDRIGHT) 

this.inv_resize.of_Register(gb_1, this.inv_resize.SCALERIGHT)
this.inv_resize.of_Register(mle_notes, this.inv_resize.SCALERIGHT)

this.inv_resize.of_register( dw_parameter,inv_resize.SCALERIGHTBOTTOM)

this.inv_resize.of_Register(cb_add, this.inv_resize.FIXEDBOTTOM)
this.inv_resize.of_Register(cb_delete, this.inv_resize.FIXEDBOTTOM)
this.inv_resize.of_Register(cb_copy, this.inv_resize.FIXEDBOTTOM)

this.inv_resize.of_Register(cb_resize, this.inv_resize.FIXEDRIGHTBOTTOM)
this.inv_resize.of_Register(cb_verify, this.inv_resize.FIXEDRIGHTBOTTOM)
this.inv_resize.of_Register(cb_ok, this.inv_resize.FIXEDRIGHTBOTTOM)
this.inv_resize.of_Register(cb_cancel, this.inv_resize.FIXEDRIGHTBOTTOM)

//End - Added By Mark Lee 07/11/12


end event

type cb_copy from commandbutton within w_agreement_template_clause_rules
integer x = 736
integer y = 1032
integer width = 343
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Copy..."
end type

event clicked;str_clause_rules_copy			lstr_Rules
String									ls_Return

lstr_Rules.adw_rules = dw_Parameter
lstr_Rules.al_clauseid = il_clause_id
lstr_Rules.al_templateid = il_template_id
If dw_View.GetRow( ) > 0 Then
	lstr_Rules.al_dataviewid = dw_view.GetItemNumber( dw_View.GetRow( ), 'data_view_id' )
	lstr_Rules.as_viewname = dw_View.Describe( "Evaluate( 'lookupdisplay(data_view_id)'," + String ( dw_View.GetRow( ) ) + ")" )
End If

OpenWithParm( w_agreement_template_clause_rules_copy, lstr_Rules  )
ls_Return = Message.StringParm
If ls_Return = 'ok' Then
	If dw_parameter.RowCount( ) > 0 Then dw_view.object.data_view_id[1] = dw_parameter.object.data_view_id[1] 
	//do things	
End If
end event

type cb_resize from commandbutton within w_agreement_template_clause_rules
integer x = 2025
integer y = 1032
integer width = 343
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Maximized"
end type

event clicked;//Begin - Added By Mark Lee 07/09/12 add for Maximized button 
if parent.windowstate = maximized! then
	parent.windowstate = normal!
else
	parent.windowstate = maximized!
end if
//End - Added By Mark Lee 07/09/12

end event

type cbx_parent_data from checkbox within w_agreement_template_clause_rules
integer x = 2857
integer y = 76
integer width = 581
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Use Parent Data"
end type

event clicked;Integer li_value0[],li_value1[]
long ll_cnt,i

ll_cnt = dw_parameter.RowCount()
If ll_cnt = 0 Then Return

For i = 1 To ll_cnt
	li_value0[i] = 0
	li_value1[i] = 1
Next

If This.Checked Then
	dw_parameter.object.used_master_ctx[1,ll_cnt] = li_value1[]
Else	
	dw_parameter.object.used_master_ctx[1,ll_cnt] = li_value0[]
End If

end event

type dw_view from u_dw within w_agreement_template_clause_rules
integer x = 553
integer y = 68
integer width = 974
integer height = 96
integer taborder = 10
string dataobject = "d_select_views_dddw_list_contract"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//Added by Alfee on 02.20.2008
This.of_SetTransObject( SQLCA )
This.of_SetUpdateAble( False )


end event

event itemchanged;call super::itemchanged;//Added by Alfee on 02.20.2008
Long ll_cnt, i

ll_cnt = dw_parameter.RowCount() 

FOR i = 1 to ll_cnt 
	IF dw_parameter.Getitemstatus(i, 0, Primary!) <> New! THEN
		MessageBox("Select View","The view can't be changed unless the defined rules are cleared out!")
		RETURN 2
	END IF
NEXT

ii_viewid = Integer(data) // Alfee 03.19.2008

//Initilize the screen dddw
dw_parameter.Post event ue_init_screen_dddw(Integer(data))

RETURN 0
end event

type st_1 from statictext within w_agreement_template_clause_rules
integer x = 64
integer y = 88
integer width = 494
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 134217746
long backcolor = 67108864
string text = "Base Clause Rule on"
boolean focusrectangle = false
end type

type cb_verify from commandbutton within w_agreement_template_clause_rules
integer x = 2382
integer y = 1032
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Verify"
end type

event clicked;//-------Begin Added by Alfee 01.04.2008--------------------
Integer i
string ls_where

IF dw_parameter.AcceptText() = -1 THEN
	MessageBox("Verify Syntax", "The syntax is not valid.")
	RETURN
END IF

//Check new empty lines, on which the FindRequired() won't work
FOR i = 1 to dw_parameter.RowCount() 
	IF dw_parameter.GetItemStatus(i, 0, Primary!) = New! THEN 
		MessageBox("Verify Syntax", "The syntax is not valid.")
		RETURN
	END IF
NEXT

//Check required columns
IF dw_parameter.event pfc_validation( ) = dw_parameter.failure THEN RETURN
//-------End Added -----------------------------------------
string ls_updatacol[]

IF f_ctx_find(1, ids_rules,ls_updatacol,'1',ls_where) = -1 THEN //Modify by jervis - 09142010
	MessageBox("Verify Syntax", "The syntax is not valid.")
ELSE
	MessageBox("Verify Syntax", "The syntax is OK.")
END IF
end event

type dw_1 from u_dw within w_agreement_template_clause_rules
boolean visible = false
integer x = 1074
integer y = 1064
integer width = 544
integer height = 652
integer taborder = 90
end type

type mle_notes from multilineedit within w_agreement_template_clause_rules
integer x = 32
integer y = 232
integer width = 3397
integer height = 124
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
integer limit = 255
borderstyle borderstyle = stylelowered!
end type

type dw_parameter from u_dw_ctx_find within w_agreement_template_clause_rules
integer x = 23
integer y = 388
integer width = 3415
integer height = 628
integer taborder = 30
boolean hscrollbar = true
boolean livescroll = false
boolean ib_rmbmenu = true
end type

event pfc_retrieve;call super::pfc_retrieve;long ll_count

//--------Begin Added by Alfee on 02.20.2008 ---------
IF dw_view.RowCount() < 1 THEN dw_view.InsertRow(0) 
dw_view.SetRow(1)
dw_view.ScrollToRow(1)
//--------End Added -----------------------------------

ll_count = Retrieve(il_template_id, il_clause_id)
if ll_count < 1 then
	ll_count = this.event pfc_insertrow()
	//Added By Mark Lee 07/25/12
	//Set default view initially
//	dw_view.SetItem(1, "data_view_id", 1001 ) //Alfee 02.20.2008
	dw_view.SetItem(1, "data_view_id", Long(gnv_data.of_getItem( 'icred_settings', 'base_clause_rule_on', False)))
else
	//Set Notes field in window
	parent.mle_notes.text = this.GetItemString(1, "rule_name")
	//Set View field accordingly
	dw_view.object.data_view_id[1] = this.object.data_view_id[1] //Alfee 02.20.2008
end if
dw_view.AcceptText() //Alfee 02.20.2008
	
//Share data with ids_rules for verify syntax
dw_parameter.ShareData(ids_rules)

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

event constructor;call super::constructor;this.of_setreqcolumn( true)

end event

event pfc_preupdate;call super::pfc_preupdate;Long ll_cnt, i 
Boolean lb_modified = FALSE

This.AcceptText()

ll_cnt = This.rowcount()
IF ll_cnt < 1 THEN RETURN SUCCESS

//Verify rules' logical
IF NOT of_verify_syntax_logical() THEN 
	MessageBox("Verify Syntax","The syntax is not valid!")
	RETURN FAILURE
END If

//Set key values in DW
FOR i = 1 to ll_cnt
	This.SetItem(i, "ctx_acp_template_id", il_template_id)
	This.SetItem(i, "ctx_acp_clause_id", il_clause_id)
	This.SetItem(i, "rule_row_id", i)
NEXT
This.AcceptText()

RETURN SUCCESS
end event

event itemfocuschanged;call super::itemfocuschanged;//moved here from dropdown event by alfee 03.26.2008
long ll_screen_id, ll_found, ll_row
string ls_dwsyntax

//Initilize the DDDW of the Field column
IF Lower(GetColumnName()) = "field_label" THEN
	ll_screen_id = GetItemNumber( GetRow(), "screen_id")
	//IF Not ll_screen_id > 0 or NOT ii_viewid > 0 THEN	
	IF IsNull(ll_screen_id) or Not ll_screen_id > 0 or NOT ii_viewid > 0 THEN	//03.26.2008
		idwc_field.Reset()
		RETURN
	END IF
	
	//Do nothing if data already existed 
	//IF idwc_field.Rowcount( ) > 0 THEN RETURN
	IF idwc_field.Rowcount( ) > 0 and ii_last_viewid = ii_viewid and ii_last_screenid = ll_screen_id THEN RETURN //03.26.2008

	//Initilize the DDDW of the Field column
	//--------Begin Modified by Alfee 03.19.2008 ------------------------
	
	idwc_field.Reset( ) //03.26.2008
	Parent.SetRedraw( False)	
//	ls_dwsyntax = f_get_screen_sql(ii_viewid, ll_screen_id,false)   //add false argu - jervis 10.11.2011
	ls_dwsyntax = f_get_screen_syntax(ii_viewid, ll_screen_id,false) //modified by gavins 20120313 grid
	
	IF len(Trim(ls_dwsyntax)) > 0 THEN
		Event ue_init_field_dddw(ls_dwsyntax, ii_viewid, ll_screen_id, idwc_field, dw_1)
		ii_last_viewid = ii_viewid //03.26.2008
		ii_last_screenid = ll_screen_id	//03.26.2008
	END IF 	
	Parent.SetReDraw( True)
	/*	ll_found = idwc_screen.find( "screen_id = " + string(ll_screen_id), 1, idwc_screen.RowCount())
	IF ll_found > 0 THEN
		//Dynamically create dataStore, 
		ls_dwsyntax = idwc_screen.GetItemString( ll_found, "dw_sql") 
		//Init the DDDW
		Event ue_init_field_dddw(ls_dwsyntax, ll_screen_id, idwc_field, dw_1)
	END IF */	
	//--------End Modified ------------------------------------------------
END IF
end event

event buttonclicked;call super::buttonclicked;//BEGIN---Modify by Evan 07/25/2008
long ll_screen_id

if dwo.name = "b_selectscreen" then
	//if gf_SelectScreen(ii_ViewID, ll_screen_id) = 1 then
	ll_screen_id = of_SelectScreen()
	if ll_screen_id > 0 then
		this.SetItem(Row, "screen_id", ll_screen_id)
		this.ScrollToRow(Row)
		this.SetColumn("field_label")
		this.Event ItemChanged(Row, this.object.screen_id, String(ll_screen_id))
		this.Event ItemFocusChanged(Row, this.object.screen_id)
	end if
end if
//END---Modify by Evan 07/25/2008

end event

event pfc_addrow;call super::pfc_addrow;If This.GetRow() <= 0 Then Return 0
If cbx_parent_data.checked Then
	dw_parameter.SetItem(1,'used_master_ctx',1)
End If
Return This.GetRow()
end event

event ue_reset_calendar_flag;call super::ue_reset_calendar_flag;//Added By Mark Lee 07/12/12
il_prezoom = 0
post of_resize()
end event

event itemchanged;call super::itemchanged;//Added By Ken.Guo 03/08/2013
If dwo.name = 'operator' and row > 0 Then
	If data = 'is' or data = 'is not' Then
		This.Setitem(row, 'value_display', 'NULL')
		This.Setitem(row, 'value', 'NULL')
	End If
End If
end event

type cb_cancel from commandbutton within w_agreement_template_clause_rules
integer x = 3095
integer y = 1032
integer width = 343
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;ClosewithReturn(parent, -1)
end event

type cb_ok from commandbutton within w_agreement_template_clause_rules
integer x = 2738
integer y = 1032
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;Integer li_current_viewid, li_viewid //02.20.2008
Long ll_cnt, i

//---------Begin Added by Alfee 01.04.2008------------------------
//Check new empty lines on which the FindRequired() won't work
ll_cnt = dw_parameter.RowCount() 
FOR i = 1 to ll_cnt
	IF dw_parameter.GetItemStatus(i, 0, Primary!) = New! THEN 
		MessageBox("Verify Syntax","The syntax is not valid!")
		RETURN 
	END IF
NEXT
//---------End Added ---------------------------------------------

//---------Begin Added by Alfee on 01.20.2008------------------
//Set view id field before dw update
IF dw_view.RowCount() > 0 THEN li_current_viewid = dw_view.GetItemNumber(1,"data_view_id")
ll_cnt = dw_parameter.RowCount() 
FOR i = 1 to ll_cnt
	li_viewid = dw_parameter.GetItemNumber(i,"data_view_id") 
	IF IsNull(li_viewid) or li_viewid <> li_current_viewid THEN 
		dw_parameter.SetItem(i, "data_view_id", li_current_viewid)
	END IF
NEXT
IF ll_cnt > 0 THEN dw_parameter.AcceptText()
//---------End Added ------------------------------------------
//Set notes field before dw update
If IsNull( is_notes ) Then is_notes = ''
IF is_notes <> mle_notes.text  THEN 
	//ll_cnt = dw_parameter.RowCount()  //Alfee 01.20.2008
	FOR i = 1 to ll_cnt
		dw_parameter.SetItem(i, "rule_name", mle_notes.text)
	NEXT
	IF ll_cnt > 0 THEN dw_parameter.AcceptText()
END IF

//Added By Ken.Guo 2009-07-29.
Integer li_value0[],li_value1[]
If ll_cnt > 0 Then
	For i = 1 To ll_cnt
		li_value0[i] = 0
		li_value1[i] = 1
	Next
	If cbx_parent_data.Checked Then
		dw_parameter.object.used_master_ctx[1,ll_cnt] = li_value1[]
	Else	
		dw_parameter.object.used_master_ctx[1,ll_cnt] = li_value0[]
	End If
End If

IF Parent.event pfc_save() >=0 THEN 
	gnv_data.of_retrieve('template_clause_rules') 
	ClosewithReturn(Parent, dw_parameter.rowcount( ))
END IF

end event

type cb_delete from commandbutton within w_agreement_template_clause_rules
integer x = 379
integer y = 1032
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;dw_parameter.event pfc_deleterow()
end event

type cb_add from commandbutton within w_agreement_template_clause_rules
integer x = 23
integer y = 1032
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;dw_parameter.event pfc_addrow()
dw_parameter.setcolumn( 'screen_id') //03.26.2008

end event

type gb_1 from groupbox within w_agreement_template_clause_rules
integer x = 23
integer y = 180
integer width = 3415
integer height = 196
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Notes"
end type

type gb_2 from groupbox within w_agreement_template_clause_rules
integer x = 23
integer y = 20
integer width = 1655
integer height = 152
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select View"
end type

type st_2 from statictext within w_agreement_template_clause_rules
integer x = 1522
integer y = 88
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

