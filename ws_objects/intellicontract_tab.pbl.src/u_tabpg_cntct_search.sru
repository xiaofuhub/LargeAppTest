$PBExportHeader$u_tabpg_cntct_search.sru
$PBExportComments$[intellicontract_tab]  The contract locations Tab Page
forward
global type u_tabpg_cntct_search from u_tabpg
end type
type rb_id from radiobutton within u_tabpg_cntct_search
end type
type cb_search from commandbutton within u_tabpg_cntct_search
end type
type sle_search from singlelineedit within u_tabpg_cntct_search
end type
type dw_facility_search from u_dw within u_tabpg_cntct_search
end type
type gb_5 from groupbox within u_tabpg_cntct_search
end type
type cb_selectall from u_cb within u_tabpg_cntct_search
end type
type cb_close from commandbutton within u_tabpg_cntct_search
end type
type rb_4 from radiobutton within u_tabpg_cntct_search
end type
type rb_3 from radiobutton within u_tabpg_cntct_search
end type
type rb_2 from radiobutton within u_tabpg_cntct_search
end type
type rb_1 from radiobutton within u_tabpg_cntct_search
end type
type cb_4 from commandbutton within u_tabpg_cntct_search
end type
type cb_select from u_cb within u_tabpg_cntct_search
end type
type st_1 from u_st within u_tabpg_cntct_search
end type
type rb_multiple from u_rb within u_tabpg_cntct_search
end type
type rb_single from u_rb within u_tabpg_cntct_search
end type
type cb_2 from u_cb within u_tabpg_cntct_search
end type
type cb_1 from u_cb within u_tabpg_cntct_search
end type
type cb_54 from u_cb within u_tabpg_cntct_search
end type
type cb_52 from u_cb within u_tabpg_cntct_search
end type
type cb_51 from u_cb within u_tabpg_cntct_search
end type
type cb_49 from u_cb within u_tabpg_cntct_search
end type
type cb_48 from u_cb within u_tabpg_cntct_search
end type
type cb_47 from u_cb within u_tabpg_cntct_search
end type
type cb_46 from u_cb within u_tabpg_cntct_search
end type
type cb_45 from u_cb within u_tabpg_cntct_search
end type
type cb_44 from u_cb within u_tabpg_cntct_search
end type
type cb_43 from u_cb within u_tabpg_cntct_search
end type
type cb_42 from u_cb within u_tabpg_cntct_search
end type
type cb_41 from u_cb within u_tabpg_cntct_search
end type
type cb_40 from u_cb within u_tabpg_cntct_search
end type
type cb_39 from u_cb within u_tabpg_cntct_search
end type
type cb_37 from u_cb within u_tabpg_cntct_search
end type
type cb_35 from u_cb within u_tabpg_cntct_search
end type
type cb_33 from u_cb within u_tabpg_cntct_search
end type
type cb_29 from u_cb within u_tabpg_cntct_search
end type
type cb_26 from u_cb within u_tabpg_cntct_search
end type
type cb_38 from u_cb within u_tabpg_cntct_search
end type
type cb_36 from u_cb within u_tabpg_cntct_search
end type
type cb_34 from u_cb within u_tabpg_cntct_search
end type
type cb_32 from u_cb within u_tabpg_cntct_search
end type
type cb_31 from u_cb within u_tabpg_cntct_search
end type
type cb_30 from u_cb within u_tabpg_cntct_search
end type
type cb_27 from u_cb within u_tabpg_cntct_search
end type
type cb_new from commandbutton within u_tabpg_cntct_search
end type
type sle_srch_val from singlelineedit within u_tabpg_cntct_search
end type
type ddlb_search_type from dropdownlistbox within u_tabpg_cntct_search
end type
type gb_search from groupbox within u_tabpg_cntct_search
end type
type gb_1 from u_gb within u_tabpg_cntct_search
end type
type gb_2 from u_gb within u_tabpg_cntct_search
end type
type dw_search from u_dw_contract within u_tabpg_cntct_search
end type
type gb_3 from u_gb within u_tabpg_cntct_search
end type
type gb_4 from groupbox within u_tabpg_cntct_search
end type
type rb_6 from radiobutton within u_tabpg_cntct_search
end type
type rb_5 from radiobutton within u_tabpg_cntct_search
end type
end forward

global type u_tabpg_cntct_search from u_tabpg
integer width = 3904
integer height = 2080
long backcolor = 33551856
event ue_new ( string as_mode )
event ue_add_contacts ( )
rb_id rb_id
cb_search cb_search
sle_search sle_search
dw_facility_search dw_facility_search
gb_5 gb_5
cb_selectall cb_selectall
cb_close cb_close
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
cb_4 cb_4
cb_select cb_select
st_1 st_1
rb_multiple rb_multiple
rb_single rb_single
cb_2 cb_2
cb_1 cb_1
cb_54 cb_54
cb_52 cb_52
cb_51 cb_51
cb_49 cb_49
cb_48 cb_48
cb_47 cb_47
cb_46 cb_46
cb_45 cb_45
cb_44 cb_44
cb_43 cb_43
cb_42 cb_42
cb_41 cb_41
cb_40 cb_40
cb_39 cb_39
cb_37 cb_37
cb_35 cb_35
cb_33 cb_33
cb_29 cb_29
cb_26 cb_26
cb_38 cb_38
cb_36 cb_36
cb_34 cb_34
cb_32 cb_32
cb_31 cb_31
cb_30 cb_30
cb_27 cb_27
cb_new cb_new
sle_srch_val sle_srch_val
ddlb_search_type ddlb_search_type
gb_search gb_search
gb_1 gb_1
gb_2 gb_2
dw_search dw_search
gb_3 gb_3
gb_4 gb_4
rb_6 rb_6
rb_5 rb_5
end type
global u_tabpg_cntct_search u_tabpg_cntct_search

type variables

n_cst_sql   inv_sql
tab a_parent_tab
userobject a_tab_page

string is_parent_title
string is_search_letter
long ll_current_contact
string is_search_type
string is_orig_sql
boolean ib_ret_dw
boolean ib_trigger_clicked

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.07.2006 By: LeiWei
//$<reason> Performance tuning.
boolean ib_just_open = TRUE
//---------------------------- APPEON END ----------------------------
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.30.2006 By: Jack 
//$<reason> Add a new icon to Menu Bar named Contacts.
string is_search_type1
//---------------------------- APPEON END ----------------------------
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.29.2007 By: Jack 
//$<reason> Fix a defect.
string is_company
//---------------------------- APPEON END ----------------------------

Boolean	ib_IsCompany = false
//--------------------------- APPEON BEGIN ---------------------------
//Added By Alan on  2009-1-14
String	is_filter				
Boolean	ib_noret = False
//---------------------------- APPEON END ----------------------------

long		il_facility_id

end variables

forward prototypes
public function integer of_search (string as_letter)
public function integer of_allow_muliti_select (string as_mode)
public function integer of_search_type (string as_search_type)
public function integer of_select_rb (u_dw adw)
public subroutine of_adjustdwpos (long al_layout)
end prototypes

event ue_new(string as_mode);/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

choose case UPPER(as_mode)
	case 'NEW'
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 09.07.2006 By: LeiWei
		//$<reason> Performance tuning.
		//iw_parent.event dynamic ue_save()
		IF NOT ib_just_open THEN
			iw_parent.event dynamic ue_save()
		END IF
		//---------------------------- APPEON END ----------------------------
		a_parent_tab.FUNCTION DYNAMIC OF_SET_MODE('NEW')
		a_parent_tab.SelectTab(2)
		iw_parent.event dynamic ue_new()
		iw_parent.title =  is_parent_title + ' New Mode'
	case else
		iw_parent.title =  is_parent_title + ' Edit Mode'
		a_parent_tab.FUNCTION DYNAMIC OF_SET_MODE(upper('EDIT'))
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 09.07.2006 By: LeiWei
		//$<reason> Performance tuning.
		//iw_parent.event dynamic ue_save()
		IF NOT ib_just_open THEN
			iw_parent.event dynamic ue_save()
		END IF
		//---------------------------- APPEON END ----------------------------
		IF dw_search.ROWCOUNT() > 0 THEN
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 07.11.2006 By: Rodger Wu
			//$<reason> fix a defect.
			//$<reason> Though the row count of dw_search is more than 0, but it is
			//$<reason> possible that its current row equals 0.
			
			/*
			//a_parent_tab.SelectTab(2)
			a_parent_tab.FUNCTION DYNAMIC OF_SET_CONTACT_ID( dw_search.OBJECt.contact_id[dw_search.getrow()]  )
			//iw_parent.FUNCTION DYNAMIC OF_RETRIEVE()
			*/
			
			Long ll_current, ll_contact_id
			ll_current = dw_search.getrow()
			if ll_current > 0 then
				ll_contact_id = dw_search.GetItemNumber( ll_current, "contact_id" )
				a_parent_tab.FUNCTION DYNAMIC OF_SET_CONTACT_ID( ll_contact_id )
			end if
			//---------------------------- APPEON END ----------------------------
			
		END IF
end choose

end event

public function integer of_search (string as_letter);

/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

Event ue_new('EDIT')

if rb_1.Checked then
	is_search_type = 'A'
elseif rb_2.Checked then
	is_search_type = 'O'
elseif rb_3.Checked then
	is_search_type = 'B'
elseif rb_4.Checked then
	is_search_type = ''
end if
//is_search_type = ''
is_search_letter = as_letter 

dw_facility_search.Reset()
dw_search.Reset()

if rb_5.Checked  Or rb_id.checked then //modified by gavins 20120327
	dw_facility_search.event pfc_retrieve( )
else
	dw_search.event pfc_retrieve( )
end if

Return success

end function

public function integer of_allow_muliti_select (string as_mode);//OF_ALLOW_MULITI_SELECT





choose case as_mode
	case string(DW_SEARCH.inv_rowselect.multiple)
			DW_SEARCH.inv_rowselect.of_SetStyle(DW_SEARCH.inv_rowselect.multiple )
	case string(DW_SEARCH.inv_rowselect.single)
		  DW_SEARCH.inv_rowselect.of_SetStyle(DW_SEARCH.inv_rowselect.single )
end choose





RETURN SUCcess
end function

public function integer of_search_type (string as_search_type);
if ib_ret_dw = true then
		is_search_letter = ''
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modified> 2007-04-23 By: Wu ZhiJun
		//$<reason> Fix a bug
		//event ue_new('EDIT')
		a_parent_tab.FUNCTION DYNAMIC OF_SET_MODE(upper('EDIT'))
		//--------------------------- APPEON END -----------------------------
		choose case as_search_type
			case 'N'
				is_search_type = ''
			case else
				is_search_type = as_search_type
		end choose
		//Added By Alan on 2009-1-14
		if ib_noret = false then
			dw_facility_search.Reset()
			dw_search.Reset()
			if rb_5.Checked Or rb_id.checked then //modified by gavins 20120327
				dw_facility_search.event pfc_retrieve( )
				dw_facility_search.Post SetFocus() //jervis 01.24.2010
			else
				dw_search.event pfc_retrieve( )
				dw_search.Post SetFocus() //jervis 01.24.2010
			end if
		end if
		ib_noret = false
		
		ib_ret_dw = false
end if

Return success

end function

public function integer of_select_rb (u_dw adw);//Start Code Change ---- 12.12.2006 #V7 maha
//removed because it seemed to serve no purpose
//return 1
//End Code Change---12.12.2006

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.30.2006 By: Jack 
//$<reason> Add a new icon to Menu Bar named Contacts.
if not isvalid(adw) then
	rb_4.checked = true
	if ib_trigger_clicked then
		rb_4.event clicked( )
		ib_trigger_clicked = false
	end if
	is_search_type1 = 'All'
	return success
end if
//---------------------------- APPEON END ----------------------------

String	ls_Type2

if adw.rowcount() > 0 then
	ls_Type2 = adw.object.contact_type2[adw.getrow()]
	choose case ls_Type2
		case 'B'
			rb_3.checked = true
			if ib_trigger_clicked then
				rb_3.event clicked( )
				ib_trigger_clicked = false
		   end if
		case 'A'
			rb_1.checked = true
			if ib_trigger_clicked then
			   rb_1.event clicked( )
				ib_trigger_clicked = false
		   end if
		case 'O'
			rb_2.checked = true
			if ib_trigger_clicked then
				rb_2.event clicked( )
				ib_trigger_clicked = false
		   end if
		case else
			rb_4.checked = true
			if ib_trigger_clicked then
				rb_4.event clicked( )
				ib_trigger_clicked = false
		   end if
			
	end choose 
end if 
return success
end function

public subroutine of_adjustdwpos (long al_layout);//====================================================================
// Function: u_tabpg_cntct_search.of_adjustdwpos()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	long	al_Layout	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-01-06
//--------------------------------------------------------------------
//	Copyright (c) 2002-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

if al_Layout = 1 then
	dw_search.Move(1029,16)
	dw_search.Resize(2848,1900)
	
	dw_facility_search.Visible = false
elseif al_Layout = 2 then
	dw_facility_search.Move(1029,16)
	dw_facility_search.Resize(2848,832)
		
	dw_search.Move(1029,868)
	dw_search.Resize(2848,1048)
	
	dw_facility_search.Visible = true
end if

end subroutine

on u_tabpg_cntct_search.create
int iCurrent
call super::create
this.rb_id=create rb_id
this.cb_search=create cb_search
this.sle_search=create sle_search
this.dw_facility_search=create dw_facility_search
this.gb_5=create gb_5
this.cb_selectall=create cb_selectall
this.cb_close=create cb_close
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_4=create cb_4
this.cb_select=create cb_select
this.st_1=create st_1
this.rb_multiple=create rb_multiple
this.rb_single=create rb_single
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_54=create cb_54
this.cb_52=create cb_52
this.cb_51=create cb_51
this.cb_49=create cb_49
this.cb_48=create cb_48
this.cb_47=create cb_47
this.cb_46=create cb_46
this.cb_45=create cb_45
this.cb_44=create cb_44
this.cb_43=create cb_43
this.cb_42=create cb_42
this.cb_41=create cb_41
this.cb_40=create cb_40
this.cb_39=create cb_39
this.cb_37=create cb_37
this.cb_35=create cb_35
this.cb_33=create cb_33
this.cb_29=create cb_29
this.cb_26=create cb_26
this.cb_38=create cb_38
this.cb_36=create cb_36
this.cb_34=create cb_34
this.cb_32=create cb_32
this.cb_31=create cb_31
this.cb_30=create cb_30
this.cb_27=create cb_27
this.cb_new=create cb_new
this.sle_srch_val=create sle_srch_val
this.ddlb_search_type=create ddlb_search_type
this.gb_search=create gb_search
this.gb_1=create gb_1
this.gb_2=create gb_2
this.dw_search=create dw_search
this.gb_3=create gb_3
this.gb_4=create gb_4
this.rb_6=create rb_6
this.rb_5=create rb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_id
this.Control[iCurrent+2]=this.cb_search
this.Control[iCurrent+3]=this.sle_search
this.Control[iCurrent+4]=this.dw_facility_search
this.Control[iCurrent+5]=this.gb_5
this.Control[iCurrent+6]=this.cb_selectall
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.rb_4
this.Control[iCurrent+9]=this.rb_3
this.Control[iCurrent+10]=this.rb_2
this.Control[iCurrent+11]=this.rb_1
this.Control[iCurrent+12]=this.cb_4
this.Control[iCurrent+13]=this.cb_select
this.Control[iCurrent+14]=this.st_1
this.Control[iCurrent+15]=this.rb_multiple
this.Control[iCurrent+16]=this.rb_single
this.Control[iCurrent+17]=this.cb_2
this.Control[iCurrent+18]=this.cb_1
this.Control[iCurrent+19]=this.cb_54
this.Control[iCurrent+20]=this.cb_52
this.Control[iCurrent+21]=this.cb_51
this.Control[iCurrent+22]=this.cb_49
this.Control[iCurrent+23]=this.cb_48
this.Control[iCurrent+24]=this.cb_47
this.Control[iCurrent+25]=this.cb_46
this.Control[iCurrent+26]=this.cb_45
this.Control[iCurrent+27]=this.cb_44
this.Control[iCurrent+28]=this.cb_43
this.Control[iCurrent+29]=this.cb_42
this.Control[iCurrent+30]=this.cb_41
this.Control[iCurrent+31]=this.cb_40
this.Control[iCurrent+32]=this.cb_39
this.Control[iCurrent+33]=this.cb_37
this.Control[iCurrent+34]=this.cb_35
this.Control[iCurrent+35]=this.cb_33
this.Control[iCurrent+36]=this.cb_29
this.Control[iCurrent+37]=this.cb_26
this.Control[iCurrent+38]=this.cb_38
this.Control[iCurrent+39]=this.cb_36
this.Control[iCurrent+40]=this.cb_34
this.Control[iCurrent+41]=this.cb_32
this.Control[iCurrent+42]=this.cb_31
this.Control[iCurrent+43]=this.cb_30
this.Control[iCurrent+44]=this.cb_27
this.Control[iCurrent+45]=this.cb_new
this.Control[iCurrent+46]=this.sle_srch_val
this.Control[iCurrent+47]=this.ddlb_search_type
this.Control[iCurrent+48]=this.gb_search
this.Control[iCurrent+49]=this.gb_1
this.Control[iCurrent+50]=this.gb_2
this.Control[iCurrent+51]=this.dw_search
this.Control[iCurrent+52]=this.gb_3
this.Control[iCurrent+53]=this.gb_4
this.Control[iCurrent+54]=this.rb_6
this.Control[iCurrent+55]=this.rb_5
end on

on u_tabpg_cntct_search.destroy
call super::destroy
destroy(this.rb_id)
destroy(this.cb_search)
destroy(this.sle_search)
destroy(this.dw_facility_search)
destroy(this.gb_5)
destroy(this.cb_selectall)
destroy(this.cb_close)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_4)
destroy(this.cb_select)
destroy(this.st_1)
destroy(this.rb_multiple)
destroy(this.rb_single)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_54)
destroy(this.cb_52)
destroy(this.cb_51)
destroy(this.cb_49)
destroy(this.cb_48)
destroy(this.cb_47)
destroy(this.cb_46)
destroy(this.cb_45)
destroy(this.cb_44)
destroy(this.cb_43)
destroy(this.cb_42)
destroy(this.cb_41)
destroy(this.cb_40)
destroy(this.cb_39)
destroy(this.cb_37)
destroy(this.cb_35)
destroy(this.cb_33)
destroy(this.cb_29)
destroy(this.cb_26)
destroy(this.cb_38)
destroy(this.cb_36)
destroy(this.cb_34)
destroy(this.cb_32)
destroy(this.cb_31)
destroy(this.cb_30)
destroy(this.cb_27)
destroy(this.cb_new)
destroy(this.sle_srch_val)
destroy(this.ddlb_search_type)
destroy(this.gb_search)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.dw_search)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.rb_6)
destroy(this.rb_5)
end on

event constructor;// override
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 03.22.2006 By: LeiWei
//$<reason> Performance tuning.
//$<modification> Add a condition to ensure that constructor will not be executed, since
//$<modification> the execution of inv_resize negatively affects the performance very much

If appeongetclienttype() = 'WEB' Then
	this.of_getparentwindow( iw_parent)
	i_parent_tab = this.GetParent( )
Else
	CALL super::constructor
End If
//---------------------------- APPEON END ----------------------------

a_parent_tab = GetParent()

is_parent_title = iw_parent.title

of_AdjustdwPos(2)

end event

type rb_id from radiobutton within u_tabpg_cntct_search
integer x = 119
integer y = 284
integer width = 343
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "ID #"
end type

event clicked;long	ll_OldRow,ll_NewRow

if This.Checked then
	gb_1.Text = "First Letter of ID # Search"
	gb_3.Text = "Company Category Search"
	
	of_AdjustdwPos(2)
	
	//Added By Alan on 2009-1-13 notes:contact filter
	if dw_search.Describe("DataWindow.Table.Filter")<>'' and dw_search.Describe("DataWindow.Table.Filter")<>'?' then is_filter = dw_search.Describe("DataWindow.Table.Filter")
	
	ll_OldRow = dw_facility_search.GetRow()
	dw_facility_search.Event pfc_retrieve()
	ll_NewRow = dw_facility_search.GetRow()
	
	if ll_NewRow = ll_OldRow then
		dw_facility_search.Event RowFocusChanged(ll_NewRow)
	end if
end if

end event

type cb_search from commandbutton within u_tabpg_cntct_search
integer x = 736
integer y = 1772
integer width = 229
integer height = 88
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Search"
boolean default = true
end type

event clicked;string 	ls_orig_sql,ls_where,ls_Type
string 	ls_SearchText
long		ll_Row,ll_Pos

ls_SearchText = Lower(Trim(sle_search.Text))

ll_Pos = Pos(ls_SearchText,"'")
do while ll_Pos > 0
	ls_SearchText = Replace(ls_SearchText,ll_Pos,1,"''")
	ll_Pos = Pos(ls_SearchText,"'",ll_Pos + 2)
loop

if rb_1.Checked then
	ls_Type = 'A'
elseif rb_2.Checked then
	ls_Type = 'O'
elseif rb_3.Checked then
	ls_Type = 'B'
elseif rb_4.Checked then
	ls_Type = ''
end if

if rb_5.Checked then
	ll_Row = dw_facility_search.GetRow()
	dw_search.Reset()
	
	ls_orig_sql = dw_facility_search.GetSQLSelect()
	//Add group access for company -- jervis 12.01.2010
	/*
	ls_where = "where " + "(lower(app_facility.facility_name) like" + " '%" + ls_SearchText + "%'"  + ")"
	
	if ls_Type <> '' then
		ls_where += " and (app_facility.contact_type2='" + ls_Type + "')"
	end if
	
	dw_facility_search.SetSQLSelect(ls_orig_sql + ls_where)
	dw_facility_search.retrieve( )
	*/
	ls_where = "where " + "(lower(facility_name) like" + " '%" + ls_SearchText + "%'"  + ")"
	
	if ls_Type <> '' then
		ls_where += " and (contact_type2='" + ls_Type + "')"
	end if
	
	dw_facility_search.Modify('datawindow.table.select ="' + ls_orig_sql + ls_where + '"')
	dw_facility_search.retrieve( Upper(gs_user_id))
	
	if dw_facility_search.RowCount() > 0 then
		dw_facility_search.SetRow(1)
		dw_facility_search.SelectRow(0,false)
		dw_facility_search.SelectRow(1,true)
		dw_facility_search.Event RowFocusChanged(1)
	else
		a_parent_tab.FUNCTION DYNAMIC of_set_facility_id(0,'F') //add 'F' --jervis 12.1.2010 
		iw_parent.title = ' Company: '
	end if
	
	//dw_facility_search.SetSQLSelect(ls_orig_sql)
	dw_facility_search.Modify('datawindow.table.select ="' + ls_orig_sql  + '"')
	dw_facility_search.Post SetFocus() //jervis 01.24.2010
elseIf rb_ID.Checked Then//modified by gavins 20120327
	ll_Row = dw_facility_search.GetRow()
	dw_search.Reset()
	
	ls_orig_sql = dw_facility_search.GetSQLSelect()
	
	ls_where = "where " + "(lower(contact) like" + " '%" + ls_SearchText + "%'"  + ")"
	
	if ls_Type <> '' then
		ls_where += " and (contact_type2='" + ls_Type + "')"
	end if
	
	dw_facility_search.Modify('datawindow.table.select ="' + ls_orig_sql + ls_where + '"')
	dw_facility_search.retrieve( Upper(gs_user_id))
	
	if dw_facility_search.RowCount() > 0 then
		dw_facility_search.SetRow(1)
		dw_facility_search.SelectRow(0,false)
		dw_facility_search.SelectRow(1,true)
		dw_facility_search.Event RowFocusChanged(1)
	else
		a_parent_tab.FUNCTION DYNAMIC of_set_facility_id(0,'F') //add 'F' --jervis 12.1.2010 
		iw_parent.title = ' ID #: '
	end if
	
	//dw_facility_search.SetSQLSelect(ls_orig_sql)
	dw_facility_search.Modify('datawindow.table.select ="' + ls_orig_sql  + '"')
	dw_facility_search.Post SetFocus() //jervis 01.24.2010	
else
	ls_orig_sql = dw_search.GetSQLSelect()

	
	//Add group access for contact -- jervis 11.24.2010
	/*
	ls_where = " and " + "(lower(ctx_contacts.last_name + ', '  + ctx_contacts.first_name + ' ' + ISNULL(ctx_contacts.middle_name,'')) like" + " '%" + ls_SearchText + "%'"  + ")"
	
	if ls_Type <> '' then
		ls_where += " and (app_facility.contact_type2='" + ls_Type + "')"
	end if
	*/
	ls_where = " and " + "(lower(last_name + ', '  + first_name + ' ' + ISNULL(middle_name,'')) like" + " '%" + ls_SearchText + "%'"  + ")"
	
	if ls_Type <> '' then
		ls_where += " and (contact_type2='" + ls_Type + "')"
	end if
	
	//dw_search.SetSQLSelect(ls_orig_sql + ls_where)
	dw_search.Modify( 'datawindow.table.select="' + ls_orig_sql + ls_where + '"')
	
	//dw_search.retrieve( )
	dw_search.retrieve( Upper(gs_user_id)) 

	if dw_search.RowCount() > 0 then
		parent.il_facility_id = 0	//Reset facility id - jervis 03.03.2010
		dw_search.SetRow(1)
		dw_search.SelectRow(0,false)
		dw_search.SelectRow(1,true)
	else
		a_parent_tab.FUNCTION DYNAMIC of_set_facility_id(0,'F')	//add 'F' --jervis 12.1.2010 
		a_parent_tab.FUNCTION DYNAMIC of_Set_Contact_id(0)
	end if
	
	//dw_search.SetSQLSelect(ls_orig_sql)	
	dw_search.Modify( 'datawindow.table.select="' + ls_orig_sql + '"')
	dw_search.post SetFocus( )  //Default to type down feature-jervis 07.21.2010
end if

end event

type sle_search from singlelineedit within u_tabpg_cntct_search
integer x = 55
integer y = 1772
integer width = 677
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
borderstyle borderstyle = stylelowered!
end type

type dw_facility_search from u_dw within u_tabpg_cntct_search
string tag = "Company Search List"
integer x = 1029
integer y = 16
integer width = 2848
integer height = 832
integer taborder = 30
boolean titlebar = true
string title = "Company Search List"
string dataobject = "d_facility_master"
boolean hscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: WuZhiJun
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

string 	ls_orig_sql
string 	ls_where
Long	li_facility_id
long		ll_Count

if CurrentRow < 1 then 
	dw_search.Reset()
	return 
end if

//Added By Alan on 2009-1-13 notes:contact filter
dw_search.setfilter("")
//end


ls_orig_sql = dw_search.GetSQLSelect()

if currentrow > 0 and currentrow <= this.RowCount() then
	li_facility_id = This.GetItemNumber(currentrow,'facility_id')
	
	
	//Add group access for contact -- jervis 11.24.2010
	ls_where = " and " + "(facility_id=" + String(li_facility_id) + ")"
	//dw_search.SetSqlSelect( ls_orig_sql + ls_where)
	dw_search.Modify('DataWindow.Table.Select = "' +ls_orig_sql + ls_where + '"')  
	
	//ll_Count = dw_search.retrieve( )
	ll_Count = dw_search.retrieve( Upper(gs_user_id)) 
	
	if ll_Count > 0 then
		dw_search.SetRow(1)
		dw_search.SelectRow(0,false)
		dw_search.SelectRow(1,true)
		dw_search.Event RowFocusChanged(1)
	end if
	//dw_search.setsqlselect(ls_orig_sql)
	dw_search.Modify('DataWindow.Table.Select = "' +ls_orig_sql + '"')  
	
	This.SelectRow(0, false)
   This.SelectRow(currentrow, true)
	if a_parent_tab.Selectedtab = 1 then
		a_parent_tab.FUNCTION DYNAMIC of_set_facility_id(this.Object.facility_id[currentrow],this.Object.Access[currentrow])	//Add Access - jervis 12.10.2010
		iw_parent.title = ' Company: ' + This.getitemstring(currentrow,'facility_name') + '  ' + String(This.Object.facility_id[currentrow])
	end if
else
	a_parent_tab.FUNCTION DYNAMIC of_set_facility_id(0,'F') //add group access - 12.1.2010
end if

end event

event pfc_retrieve;call super::pfc_retrieve;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: WuZhiJun
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

string ls_orig_sql
string ls_where

ls_orig_sql = GetSQLSelect()

//Add group access for company - jervis 12.01.2010
/*
if Not f_validstr(is_search_type) and f_validstr(is_search_letter)  then
	ls_where = "where (app_facility.facility_name like '" + is_search_letter + "%')"
end if

if f_validstr(is_search_type) and Not f_validstr(is_search_letter)  then
	ls_where = "where (app_facility.contact_type2 like '" + is_search_type + "%')"
end if

if il_facility_id > 0 then
	if Trim(ls_where) = "" then ls_where += " where " else ls_where += " and "
	ls_where += " (app_facility.facility_id = " + String(il_facility_id) + ")"
end if

if Trim(ls_where) <> "" then This.SetSQLSelect(ls_orig_sql + ls_where)
This.Retrieve()
*/

//Begin modified By Ken 08/17/2011. Fixed bug
/*
if Not f_validstr(is_search_type) and f_validstr(is_search_letter)  then
	ls_where = "where (facility_name like '" + is_search_letter + "%')"
end if

if f_validstr(is_search_type) and Not f_validstr(is_search_letter)  then
	ls_where = "where (contact_type2 like '" + is_search_type + "%')"
end if

if il_facility_id > 0 then
	if Trim(ls_where) = "" then ls_where += " where " else ls_where += " and "
	ls_where += " (facility_id = " + String(il_facility_id) + ")"
end if
*/
ls_where  = ' where 1 = 1 '
if f_validstr(is_search_type) Then ls_where += " and  (contact_type2 like '" + is_search_type + "%')"
If rb_id.checked Then //added by gavins 20120327
	if f_validstr(is_search_letter)  Then ls_where += " and (Ltrim(contact) like '" + is_search_letter + "%')"
Else
	if f_validstr(is_search_letter)  Then ls_where += " and (Ltrim(facility_name) like '" + is_search_letter + "%')"
End If
if il_facility_id > 0 then ls_where += " and (facility_id = " + String(il_facility_id) + ")"
//End modified By Ken 08/17/2011. Fixed bug


if Trim(ls_where) <> "" then This.Modify('Datawindow.table.select ="' + ls_orig_sql + ls_where + '"')
This.Retrieve(Upper(gs_user_id))


if This.RowCount() > 0 then
	This.SetRow(1)
	This.SelectRow(0,false)
	This.SelectRow(1,true)
	This.Trigger Event RowFocusChanged(1)		//Added by Scofield on 2009-04-28
else
	a_parent_tab.FUNCTION DYNAMIC of_set_facility_id(0,'F') //Add group access- jervis 12.01.2010
	iw_parent.title = ' Company: '
end if

ib_just_open = FALSE

//if Trim(ls_where) <> "" then This.SetSQLSelect(ls_orig_sql)	//jervis 12.01.2010
if Trim(ls_where) <> "" then This.Modify('datawindow.table.select ="' + ls_orig_sql + '"')

Return SUCCESS

end event

event doubleclicked;call super::doubleclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-03-08 By: Wu ZhiJun
//$<reason> Open detail tab when double the facility_search

if row > 0 then
	a_parent_tab.FUNCTION DYNAMIC of_set_facility_id(this.Object.facility_id[row],this.object.access[row]) //add group access - jervis 12.01.2010
	a_parent_tab.FUNCTION DYNAMIC OF_SET_MODE(upper('EDIT'))
	IF NOT Isvalid(iw_parent) OR Isnull(iw_parent) THEN
		of_getparentwindow(iw_parent )
	END IF
   iw_parent.event dynamic ue_select_details_tab()
else
	a_parent_tab.FUNCTION DYNAMIC of_set_facility_id(0,'F')  //add group access - jervis 12.01.2010
end if

//--------------------------- APPEON END -----------------------------


end event

event constructor;call super::constructor;if Not Isvalid(iw_parent) or IsNull(iw_parent) then
	of_getparentwindow(iw_parent)
end if

of_SetSort(True)
inv_sort.of_SetColumnHeader(True)

this.of_setupdateable(false)

ib_RMBMenu = true								//Added by Scofield on 2009-09-21

end event

event getfocus;call super::getfocus;ib_IsCompany = true
//Added By Mark Lee 03/22/2013
//this.title = ' >>>>>>>>>> ' + this.Tag + ' <<<<<<<<<<< '
this.title = gs_left_title_sign + this.Tag + gs_right_title_sign

end event

event losefocus;call super::losefocus;this.title = this.tag
end event

event retrieveend;call super::retrieveend;if RowCount > 0 then a_parent_tab.FUNCTION DYNAMIC of_Set_Mode(Upper('EDIT'))		//Added by Scofield on 2008-12-26

end event

event pfc_addrow;//BEGIN---Modify by Scofield on 2009-09-21
if IsValid(w_contract_contact) then
	w_contract_contact.cb_add.TriggerEvent(Clicked!)
end if

Return 1
//END---Modify by Scofield on 2009-09-21

end event

event pfc_deleterow;call super::pfc_deleterow;//BEGIN---Modify by Scofield on 2009-09-21
if IsValid(w_contract_contact) then
	w_contract_contact.cb_delete.TriggerEvent(Clicked!)
end if

Return 1
//END---Modify by Scofield on 2009-09-21

end event

event rbuttonup;//////////////////////////////////////////////////////////////////////////////
//	Event:  			rbuttonup
//	Description:		Popup menu
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0   	Initial version
//						5.0.04 Modified script to avoid 64K segment problem with 16bit machine code executables
// 						6.0		Added DataWindow Property to the popup menu.
// 						6.0 	Added check for the new RowManager.of_GetRestoreRow() switch.
// 						6.0.01 Added call to pfc_prermbmenuproperty to isolate calls to shared variable.
// 						6.0.01 Corrected so that dwo.protect works properly for protect expressions.
//////////////////////////////////////////////////////////////////////////////
//	Copyright ? 1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
Boolean		lb_frame
Boolean		lb_desired
Boolean		lb_readonly
Boolean		lb_editstyleattrib
Integer		li_tabsequence
Long			ll_getrow,ll_Right
String		ls_editstyle
String		ls_val
String		ls_protect
String		ls_colname
String		ls_currcolname
String		ls_type
String		ls_expression
n_cst_conversion	lnv_conversion
m_dw					lm_dw
window				lw_parent
window				lw_frame
window				lw_sheet
window				lw_childparent

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-05-29 By: Scofield
//$<Reason> Forbid popup menu if it has read only right

ll_Right = w_mdi.of_security_access(6930)				//Access Rights
if ll_Right = 0 or ll_Right = 1 then Return 1
//---------------------------- APPEON END ----------------------------

// No RMB support for OLE objects and graphs
ls_type = dwo.Type
If ls_type = "ole" Or ls_type = "tableblob" Or ls_type = "graph" Then Return 1

// No RMB support for print preview mode
If This.Object.DataWindow.Print.Preview = "yes" Then Return 1

// Determine parent window for PointerX, PointerY offset
This.of_GetParentWindow (lw_parent)
If IsValid (lw_parent) Then
	// Get the MDI frame window if available
	lw_frame = lw_parent
	Do While IsValid (lw_frame)
		If lw_frame.WindowType = MDI! Or lw_frame.WindowType = MDIHelp! Then
			lb_frame = True
			Exit
		Else
			lw_frame = lw_frame.ParentWindow()
		End If
	Loop
	
	If lb_frame Then
		// If MDI frame window is available, use it as the reference point for the
		// popup menu for sheets (windows opened with OpenSheet function) or child windows
		If lw_parent.WindowType = Child! Then
			lw_parent = lw_frame
		Else
			lw_sheet = lw_frame.GetFirstSheet()
			If IsValid (lw_sheet) Then
				Do
					// Use frame reference for popup menu if the parentwindow is a sheet
					If lw_sheet = lw_parent Then
						lw_parent = lw_frame
						Exit
					End If
					lw_sheet = lw_frame.GetNextSheet (lw_sheet)
				Loop Until IsNull(lw_sheet) Or Not IsValid (lw_sheet)
			End If
		End If
	Else
		// SDI application.  All windows except for child windows will use the parent
		// window of the control as the reference point for the popmenu
		If lw_parent.WindowType = Child! Then
			lw_childparent = lw_parent.ParentWindow()
			If IsValid (lw_childparent) Then
				lw_parent = lw_childparent
			End If
		End If
	End If
Else
	Return 1
End If

// Create popup menu
lm_dw = Create m_dw
lm_dw.of_SetParent (This)

//////////////////////////////////////////////////////////////////////////////
// Main popup menu operations
//////////////////////////////////////////////////////////////////////////////
ll_getrow = This.GetRow()

ls_val = This.Object.DataWindow.Readonly
lb_readonly = lnv_conversion.of_Boolean (ls_val)

Choose Case ls_type
	Case "datawindow", "column", "compute", "text", "report", &
		"bitmap", "line", "ellipse", "rectangle", "roundrectangle"
	
	// Row operations based on readonly status
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', Not lb_readonly)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_addrow,'Enabled', Not lb_readonly)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', Not lb_readonly)
	
	// Menu item enablement for current row
	If Not lb_readonly Then
		lb_desired = False
		If ll_getrow > 0 Then lb_desired = True
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', lb_desired)
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', lb_desired)
	End If
	
Case Else
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', False)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', False)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_addrow,'Enabled', False)
End Choose

// Get column properties
ls_currcolname = This.GetColumnName()
If ls_type = "column" Then
	ls_editstyle = dwo.Edit.Style
	ls_colname = dwo.Name
	ls_protect = dwo.Protect
	If Not IsNumber(ls_protect) Then
		// Since it is not a number, it must be an expression.
		ls_expression = Right(ls_protect, Len(ls_protect) - Pos(ls_protect, "~t"))
		ls_expression = "Evaluate(~""+ls_expression+","+String(row)+")"
		ls_protect = This.Describe(ls_expression)
	End If
	ls_val = dwo.TabSequence
	If IsNumber (ls_val) Then
		li_tabsequence = Integer (ls_val)
	End If
End If

//////////////////////////////////////////////////////////////////////////////
// Transfer operations.  Only enable for editable column edit styles
//////////////////////////////////////////////////////////////////////////////
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_copy,'Enabled', False)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_cut,'Enabled', False)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_paste,'Enabled', False)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_selectall,'Enabled', False)

// Get the column/editystyle specific editable flag.
If ls_type = "column" And Not lb_readonly Then
	Choose Case ls_editstyle
		Case "edit"
			ls_val = dwo.Edit.DisplayOnly
		Case "editmask"
			ls_val = dwo.EditMask.Readonly
		Case "ddlb"
			ls_val = dwo.DDLB.AllowEdit
		Case "dddw"
			ls_val = dwo.DDDW.AllowEdit
		Case Else
			ls_val = ""
	End Choose
	lb_editstyleattrib = lnv_conversion.of_Boolean (ls_val)
	If IsNull(lb_editstyleattrib) Then lb_editstyleattrib = False
End If

//////////////////////////////////////////////////////////////////////////////
// Services
//////////////////////////////////////////////////////////////////////////////
// Row Manager
If IsValid (inv_RowManager) Then
	// Undelete capability
	If inv_RowManager.of_IsRestoreRow() Then
		lm_dw.m_table.m_restorerow.Visible = True
		If This.DeletedCount() > 0 And Not lb_readonly Then
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', True)
		Else
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', False)
		End If
	End If
Else
	lm_dw.m_table.m_restorerow.Visible = False
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', False)
End If

// QueryMode
// Default to false
lm_dw.m_table.m_operators.Visible = False
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_operators,'Enabled', False)
lm_dw.m_table.m_values.Visible = False
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_values,'Enabled', False)
lm_dw.m_table.m_dash12.Visible = False

If IsValid (inv_QueryMode) Then
	If inv_QueryMode.of_GetEnabled() Then
		// Do not allow undelete while in querymode
		lm_dw.m_table.m_restorerow.Visible = False
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', False)
		
		// Default visible to true if in querymode
		lm_dw.m_table.m_values.Visible = True
		lm_dw.m_table.m_operators.Visible = True
		lm_dw.m_table.m_dash12.Visible = True
	End If
End If

// DataWindow property entries. (isolate calls to shared variable)
This.Event pfc_prermbmenuproperty (lm_dw)

// Allow for any other changes to the popup menu before it opens
This.Event pfc_prermbmenu (lm_dw)

// Send rbuttonup notification to row selection service
If IsValid (inv_RowSelect) Then inv_RowSelect.Event pfc_rbuttonup (xpos, ypos, row, dwo)

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-18 By: Scofield
//$<Reason> Don't display the mailaspdf and saveaspdf menu item
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', False)
lm_dw.m_table.m_mailaspdf.Visible = False
lm_dw.m_table.m_saveaspdf.Visible = False
//---------------------------- APPEON END ----------------------------

// Popup menu
lm_dw.m_table.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)

Destroy lm_dw

Return 1

end event

type gb_5 from groupbox within u_tabpg_cntct_search
integer x = 55
integer y = 88
integer width = 910
integer height = 400
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Contact Search Type"
end type

type cb_selectall from u_cb within u_tabpg_cntct_search
boolean visible = false
integer x = 2034
integer y = 1952
integer width = 320
integer taborder = 130
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Select All"
end type

event clicked;call super::clicked;//Start Code Change ---- 12.12.2006 #V7 maha added

LONG i
LONG ll_selected_row

for i = i to dw_search.rowcount()
	dw_search.setitem(i,"selected",1 )
next

cb_select.triggerevent(clicked!)

end event

type cb_close from commandbutton within u_tabpg_cntct_search
boolean visible = false
integer x = 2683
integer y = 1952
integer width = 320
integer height = 92
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;//Start Code Change ---- 12.12.2006 #V7 maha added
close(iw_parent)

end event

type rb_4 from radiobutton within u_tabpg_cntct_search
event lbuttonclick pbm_lbuttondown
integer x = 119
integer y = 900
integer width = 192
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "All"
end type

event lbuttonclick;//Added By Alan on 2009-1-14
if classname()='rb_4' then ib_noret = true
end event

event clicked;ib_ret_dw = true
of_search_type("N")

end event

event getfocus;//Added By Alan on 2009-1-14
if classname()='rb_4' then ib_noret = true
end event

type rb_3 from radiobutton within u_tabpg_cntct_search
event lbuttonclick pbm_lbuttondown
integer x = 119
integer y = 732
integer width = 681
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Contracted Company"
end type

event lbuttonclick;//Added By Alan on 2009-1-14
if classname()='rb_3' then ib_noret = true
end event

event clicked;ib_ret_dw = true
of_search_type("B")

end event

event getfocus;//Added By Alan on 2009-1-14
if classname()='rb_3' then ib_noret = true
end event

type rb_2 from radiobutton within u_tabpg_cntct_search
event lbuttonclick pbm_lbuttondown
integer x = 119
integer y = 816
integer width = 256
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Other"
end type

event lbuttonclick;//Added By Alan on 2009-1-14
if classname()='rb_2' then ib_noret = true
end event

event clicked;ib_ret_dw = true
of_search_type("O")

end event

event getfocus;//Added By Alan on 2009-1-14
if classname()='rb_2' then ib_noret = true
end event

type rb_1 from radiobutton within u_tabpg_cntct_search
event lbuttonclick pbm_lbuttondown
integer x = 119
integer y = 636
integer width = 443
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Our Company"
end type

event lbuttonclick;//Added By Alan on 2009-1-14
if classname()='rb_1' then ib_noret = true

end event

event clicked;ib_ret_dw = true
of_search_type("A")

end event

event getfocus;//Added By Alan on 2009-1-14
if classname()='rb_1' then ib_noret = true
end event

type cb_4 from commandbutton within u_tabpg_cntct_search
boolean visible = false
integer x = 1710
integer y = 1952
integer width = 320
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Detail"
end type

event clicked;

long llr
llr = dw_search.GetSelectedRow(0)


dw_search.event doubleclicked( 0, 0, llr, dw_search.object.contact_type  )
end event

type cb_select from u_cb within u_tabpg_cntct_search
boolean visible = false
integer x = 1385
integer y = 1952
integer width = 320
integer taborder = 120
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Select"
end type

event clicked;call super::clicked;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

LONG 		LL_I
LONG 		ll_selected_row

long		ll_EndRow,ll_SelRow,ll_contact_id
String	ls_contact_id

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.30.2006 By: Jack 
//$<reason> Add a new icon to Menu Bar named Contacts.
String ls_email, ls_temp

if is_search_type1 = 'All' then
	if w_contract_contact.istr_pass.l_facility_id = -999 then
		FOR ll_i = 1 TO dw_search.RowCount()
			if dw_search.getitemnumber(ll_i,'selected')	 = 1 then
				ls_temp = dw_search.object.contact_email[ll_i]
				if ls_temp = "" OR IsNull(ls_temp) then
					
				else
					ls_email +=  ls_temp + ";"
				end if
			END IF
		NEXT
		if Len(ls_email) > 0 then
			ls_email = Left(ls_email, Len(ls_email) - 1)
		else
			ls_email = ""
		end if
		w_contract_contact.of_add_contacts_email(ls_email)
		Return
	else
		ll_EndRow = dw_search.RowCount()
		ll_SelRow = dw_search.Find("selected = 1",ll_SelRow + 1,ll_EndRow)
		
		do while ll_SelRow > 0
			ll_contact_id = dw_search.GetItemNumber(ll_SelRow,'contact_id')
			ls_contact_id += String(ll_contact_id) + ","
//			If ll_SelRow = dw_search.RowCount() Then Exit //Added By Ken.Guo 2009-10-15.
			ll_SelRow = dw_search.Find("selected = 1",ll_SelRow + 1,ll_EndRow)
		loop
		
		if IsNull(ls_contact_id) or Trim(ls_contact_id) = "" then ls_contact_id = ","
		
		CloseWithReturn(iw_parent,ls_contact_id)
		
		Return
	end if
	
	Close(iw_parent)
	Return
end if
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-17 By: Liu Hongxin
//$<reason> Get Email info.
IF IsValid(w_contract_contact) THEN
	IF w_contract_contact.istr_pass.l_facility_id = -999 THEN
		FOR ll_i = 1 TO dw_search.RowCount()
			IF dw_search.getitemnumber(ll_i,'selected')	 = 1 THEN
				ls_temp = dw_search.object.contact_email[ll_i]
				IF ls_temp = "" OR IsNull(ls_temp) THEN
				ELSE
					ls_email +=  ls_temp + ";"
				END IF
			END IF
		NEXT
		IF Len(ls_email) > 0 THEN
			ls_email = Left(ls_email, Len(ls_email) - 1)
		ELSE
			ls_email = ""
		END IF
		w_contract_contact.of_add_contacts_email(ls_email)

		Return
	END IF
END IF
//---------------------------- APPEON END ----------------------------

str_contact lstr_contact
for ll_I = 1 to dw_search.RowCount()
	if dw_search.getitemnumber(ll_I,'selected')	 = 1 then
		ll_contact_id = dw_search.object.contact_id[ll_I]  // Add 04.27.2007 By: Jack
			
			//Added By Ken.Guo 11/01/2012
			lstr_contact.as_last_name = dw_search.object.last_name[ll_I]
			lstr_contact.as_first_name = dw_search.object.first_name[ll_I]
			lstr_contact.as_middle_name = dw_search.object.middle_name[ll_I]
			lstr_contact.al_contact_id = dw_search.object.contact_id[ll_I] 
			lstr_contact.al_contact_type = dw_search.object.contact_type[ll_I] 
			lstr_contact.as_user_id = dw_search.object.user_d[ll_I] 
			lstr_contact.as_phone_number = dw_search.object.contact_phone[ll_I]
			lstr_contact.as_contact_title = dw_search.object.contact_title[ll_I] 
			lstr_contact.al_contact_department = dw_search.object.contact_department[ll_I] 
			lstr_contact.as_email = dw_search.object.contact_email[ll_I] 
		
		if iw_parent.ClassName() = "w_contract_contact" then
			//Modified By Ken.Guo 11/01/2012
			//iw_parent.function dynamic of_add_email_contact(dw_search.object.last_name[ll_I],dw_search.object.first_name[ll_I],dw_search.object.middle_name[ll_I],dw_search.object.contact_id[ll_I],dw_search.object.contact_type[ll_I],dw_search.object.user_d[ll_I],dw_search.object.contact_phone[ll_I],dw_search.object.contact_email[ll_I])
			iw_parent.function dynamic of_add_email_contact( lstr_contact )
		else
			//Modified By Ken.Guo 11/01/2012
			//iw_parent.function dynamic of_add_contacts(dw_search.object.last_name[ll_I],dw_search.object.first_name[ll_I],dw_search.object.middle_name[ll_I],dw_search.object.contact_id[ll_I],dw_search.object.contact_type[ll_I],dw_search.object.user_d[ll_I],dw_search.object.contact_phone[ll_I])
			iw_parent.function dynamic of_add_contacts(lstr_contact)
		end if
	end if
next
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.27.2007 By: Jack
//$<reason> Fix a defect.
/*
close(iw_parent)
*/
If isnull(ll_contact_id) = False And ll_contact_id <> 0 Then
	closewithreturn(iw_parent,ll_contact_id)
Else
	close(iw_parent)
End If	
//---------------------------- APPEON END ----------------------------


end event

type st_1 from u_st within u_tabpg_cntct_search
boolean visible = false
integer x = 1207
integer y = 328
integer width = 800
string text = "(Used for inserting multiple contacts.)"
end type

type rb_multiple from u_rb within u_tabpg_cntct_search
boolean visible = false
integer x = 1125
integer y = 260
integer width = 713
integer height = 64
string text = "Multi Row Selection "
end type

event clicked;call super::clicked;

PARENT.OF_allow_muliti_select(string(dw_search.inv_rowselect.multiple ) )
end event

type rb_single from u_rb within u_tabpg_cntct_search
boolean visible = false
integer x = 1125
integer y = 168
integer width = 713
integer height = 64
string text = "Single Row Selection"
boolean checked = true
end type

event clicked;call super::clicked;

PARENT.OF_allow_muliti_select(string(dw_search.inv_rowselect.single) )
end event

type cb_2 from u_cb within u_tabpg_cntct_search
boolean visible = false
integer x = 2359
integer y = 1952
integer width = 320
integer taborder = 130
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;call super::clicked;

iw_parent.event dynamic ue_save()
end event

type cb_1 from u_cb within u_tabpg_cntct_search
integer x = 727
integer y = 1536
integer width = 201
integer height = 120
integer taborder = 90
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "All"
end type

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01.09.2007 By: Jack 
//$<reason> Fix a defect.
/*
string ls_null

setnull(ls_null)
of_search(ls_null)
*/

//rb_4.setfocus()
//---------------------------- APPEON END ----------------------------


//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-04-26 By: Wu ZhiJun
//$<reason> Fix a bug
rb_4.Checked = true
rb_4.Event Clicked()
//--------------------------- APPEON END -----------------------------


end event

type cb_54 from u_cb within u_tabpg_cntct_search
integer x = 727
integer y = 1336
integer width = 201
integer height = 64
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "X"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_52 from u_cb within u_tabpg_cntct_search
integer x = 727
integer y = 1464
integer width = 201
integer height = 64
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Z"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_51 from u_cb within u_tabpg_cntct_search
integer x = 727
integer y = 1400
integer width = 201
integer height = 64
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Y"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_49 from u_cb within u_tabpg_cntct_search
integer x = 727
integer y = 1272
integer width = 201
integer height = 64
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "W"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_48 from u_cb within u_tabpg_cntct_search
integer x = 727
integer y = 1208
integer width = 201
integer height = 64
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "V"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_47 from u_cb within u_tabpg_cntct_search
integer x = 512
integer y = 1208
integer width = 197
integer height = 64
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "O"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_46 from u_cb within u_tabpg_cntct_search
integer x = 512
integer y = 1272
integer width = 197
integer height = 64
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "P"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_45 from u_cb within u_tabpg_cntct_search
integer x = 512
integer y = 1592
integer width = 197
integer height = 64
integer taborder = 80
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "U"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_44 from u_cb within u_tabpg_cntct_search
integer x = 512
integer y = 1400
integer width = 197
integer height = 64
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "R"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_43 from u_cb within u_tabpg_cntct_search
integer x = 512
integer y = 1464
integer width = 197
integer height = 64
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "S"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_42 from u_cb within u_tabpg_cntct_search
integer x = 512
integer y = 1528
integer width = 197
integer height = 64
integer taborder = 70
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "T"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_41 from u_cb within u_tabpg_cntct_search
integer x = 512
integer y = 1336
integer width = 197
integer height = 64
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Q"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_40 from u_cb within u_tabpg_cntct_search
integer x = 297
integer y = 1336
integer width = 197
integer height = 64
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "J"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_39 from u_cb within u_tabpg_cntct_search
integer x = 297
integer y = 1528
integer width = 197
integer height = 64
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "M"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_37 from u_cb within u_tabpg_cntct_search
integer x = 297
integer y = 1464
integer width = 197
integer height = 64
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "L"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_35 from u_cb within u_tabpg_cntct_search
integer x = 297
integer y = 1400
integer width = 197
integer height = 64
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "K"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_33 from u_cb within u_tabpg_cntct_search
integer x = 297
integer y = 1592
integer width = 197
integer height = 64
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "N"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_29 from u_cb within u_tabpg_cntct_search
integer x = 297
integer y = 1272
integer width = 197
integer height = 64
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "I"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_26 from u_cb within u_tabpg_cntct_search
integer x = 297
integer y = 1208
integer width = 197
integer height = 64
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "H"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_38 from u_cb within u_tabpg_cntct_search
integer x = 82
integer y = 1208
integer width = 197
integer height = 64
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "A"
end type

event clicked;call super::clicked;dw_search.setfilter('')
dw_search.filter()
of_search(This.Text)
end event

type cb_36 from u_cb within u_tabpg_cntct_search
integer x = 82
integer y = 1272
integer width = 197
integer height = 64
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "B"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_34 from u_cb within u_tabpg_cntct_search
integer x = 82
integer y = 1592
integer width = 197
integer height = 64
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "G"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_32 from u_cb within u_tabpg_cntct_search
integer x = 82
integer y = 1400
integer width = 197
integer height = 64
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "D"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_31 from u_cb within u_tabpg_cntct_search
integer x = 82
integer y = 1464
integer width = 197
integer height = 64
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "E"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_30 from u_cb within u_tabpg_cntct_search
integer x = 82
integer y = 1528
integer width = 197
integer height = 64
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "F"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_27 from u_cb within u_tabpg_cntct_search
integer x = 82
integer y = 1336
integer width = 197
integer height = 64
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "C"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_new from commandbutton within u_tabpg_cntct_search
boolean visible = false
integer x = 1065
integer y = 1952
integer width = 320
integer height = 92
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "New"
end type

event clicked;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


parent.event ue_new('NEW')

end event

type sle_srch_val from singlelineedit within u_tabpg_cntct_search
boolean visible = false
integer x = 18
integer y = 1916
integer width = 320
integer height = 92
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type ddlb_search_type from dropdownlistbox within u_tabpg_cntct_search
boolean visible = false
integer x = 366
integer y = 1916
integer width = 320
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean vscrollbar = true
string item[] = {"Last Name","I.D.","SS #","Apps Needing Printed","Provider ID","Primary Department","Custom Search"}
borderstyle borderstyle = stylelowered!
end type

event constructor;This.Text = "Last Name"
end event

type gb_search from groupbox within u_tabpg_cntct_search
boolean visible = false
integer x = 699
integer y = 1916
integer width = 320
integer height = 92
integer taborder = 440
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "Options"
end type

type gb_1 from u_gb within u_tabpg_cntct_search
integer x = 55
integer y = 1124
integer width = 910
integer height = 580
integer taborder = 11
integer weight = 400
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "First Letter of Company Name Search"
end type

type gb_2 from u_gb within u_tabpg_cntct_search
boolean visible = false
integer x = 1088
integer y = 72
integer width = 951
integer height = 352
integer taborder = 11
string text = "Row Selection Mode"
end type

type dw_search from u_dw_contract within u_tabpg_cntct_search
string tag = "Contact Search List"
integer x = 1029
integer y = 868
integer width = 2848
integer height = 1048
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Contact Search List"
string dataobject = "d_contract_contact_search"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_use_row_selection = true
end type

event constructor;call super::constructor;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

if Not Isvalid(iw_parent) or IsNull(iw_parent) then
	of_getparentwindow(iw_parent)
end if

of_SetSort(True)
inv_sort.of_SetColumnHeader(True)

ib_rmbmenu = false

this.of_setupdateable(false)

//Add type down capability feature - jervis 06.25.2010
this.ib_typedown = true
this.is_typedown_name = "full_name"

end event

event pfc_retrieve;call super::pfc_retrieve;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

string ls_where

if Not f_validstr(is_orig_sql) then is_orig_sql = GetSQLSelect()

//Begin modified By Ken 08/17/2011. Fixed bug
/*
//Add Gropu Access fot contact -- jervis 11.24.2010
if Not f_validstr(is_search_type) and f_validstr(is_search_letter) then
	ls_where += " and (last_name like '" + is_search_letter + "%')"
end if 
if f_validstr(is_search_type)  and Not f_validstr(is_search_letter)  then 
	ls_where += " and (contact_type2 like '" + is_search_type + "%')"
end if
if il_facility_id > 0 then
	ls_where += " and (facility_id = " + String(il_facility_id) + ")"
end if
*/

if f_validstr(is_search_type) Then ls_where +=  " and (contact_type2 like '" + is_search_type + "%')"
if f_validstr(is_search_letter)  Then ls_where += " and (LTrim(last_name) like '" + is_search_letter + "%')"
if il_facility_id > 0 then ls_where +=" and (facility_id = " + String(il_facility_id) + ")"
//End modified By Ken 08/17/2011. Fixed bug



//This.SetSQLSelect(is_orig_sql + ls_where)
this.Modify('DataWindow.Table.Select = "' +is_orig_sql + ls_where + '"')  
//This.Retrieve()
This.Retrieve(Upper(gs_user_id)) 

if This.RowCount() > 0 then
	This.SetRow(1)
	This.SelectRow(0,false)
	This.SelectRow(1,true)
	if ib_just_open then
		a_parent_tab.FUNCTION DYNAMIC of_set_facility_id(This.Object.facility_id[1],this.object.access[1])  //add group access - jervis 12.01.2010
		a_parent_tab.FUNCTION DYNAMIC of_Set_Contact_id(This.object.contact_id[1])
	end if
else
	a_parent_tab.FUNCTION DYNAMIC of_set_facility_id(0,'F') //add group access - jervis 12.01.2010
	a_parent_tab.FUNCTION DYNAMIC of_Set_Contact_id(0)
end if

ib_just_open = FALSE

//This.SetSQLSelect(is_orig_sql)
this.Modify('DataWindow.Table.Select = "' +is_orig_sql + '"') 

dw_search.SetFocus( )  //Default to type down feature-jervis 07.21.2010
	
Return success

end event

event doubleclicked;call super::doubleclicked;
if row > 0 then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modified> 2007-03-27 By: Wu ZhiJun
	//$<reason> Update the facility_id value 
	a_parent_tab.FUNCTION DYNAMIC of_set_facility_id(this.Object.facility_id[row],this.object.access[row]) //add group access - jervis 12.01.2010
	//--------------------------- APPEON END -----------------------------

	a_parent_tab.FUNCTION DYNAMIC of_set_contact_id(this.OBJECT.CONTACT_ID[row])
   //of_select_rb(this)
	a_parent_tab.FUNCTION DYNAMIC OF_SET_MODE(upper('EDIT'))
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 09.01.2006 By: LeiWei
	//$<reason> Fix a defect.
	IF NOT Isvalid(iw_parent) OR Isnull(iw_parent) THEN
		of_getparentwindow(iw_parent )
	END IF
	//---------------------------- APPEON END ----------------------------

   iw_parent.event dynamic ue_select_details_tab()
else
	a_parent_tab.FUNCTION DYNAMIC of_set_facility_id(0,'F')  //add group access - jervis 12.01.2010
	a_parent_tab.FUNCTION DYNAMIC of_set_contact_id(0)
end if
end event

event itemchanged;call super::itemchanged;


if long (data) = 1 then 
	 This.SelectRow(row, TRUE)
else 
    This.SelectRow(row, false)
end if 


end event

event retrieveend;call super::retrieveend;if RowCount > 0 then a_parent_tab.FUNCTION DYNAMIC of_Set_Mode(Upper('EDIT'))		//Added by Scofield on 2008-12-26

return success

end event

event rowfocuschanged;call super::rowfocuschanged;if rowcount() < 1 then return 
if CurrentRow < 1 then return
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.07.2006 By: LeiWei
//$<reason> Performance tuning.
//IF ib_just_open THEN RETURN
//---------------------------- APPEON END ----------------------------

String	ls_FullName
Long	li_Contact_id,li_facility_id  //change integer to Long type.
string ls_access

if CurrentRow > 0 then
	This.SelectRow(0, FALSE)
   This.SelectRow(CurrentRow, TRUE)
	
	if a_parent_tab.Selectedtab = 1 then
		ls_FullName = This.GetItemString(CurrentRow,'full_name')
		li_Contact_id = This.GetItemNumber(CurrentRow,'contact_id')
		li_facility_id = This.GetItemNumber(CurrentRow,'facility_id')
		ls_access = this.GetItemString( currentrow, 'access')

		a_parent_tab.FUNCTION DYNAMIC of_set_facility_id(li_facility_id,ls_access) //add group access - jervis 12.01.2010
		a_parent_tab.FUNCTION DYNAMIC of_Set_Contact_id(li_Contact_id)
		
		iw_parent.title = ' Contract Contact: ' + ls_FullName + '  ' +STRING(li_Contact_id)
	end if
else
	a_parent_tab.FUNCTION DYNAMIC of_set_facility_id(0,'F') //add group access - jervis 12.01.2010
	a_parent_tab.FUNCTION DYNAMIC of_Set_Contact_id(0)
end if

return success

end event

event getfocus;call super::getfocus;this.border = true

ib_IsCompany = false

end event

event pfc_deleterow;//BEGIN---Modify by Scofield on 2009-09-21
if IsValid(w_contract_contact) then
	w_contract_contact.cb_delete.TriggerEvent(Clicked!)
end if

Return 1
//END---Modify by Scofield on 2009-09-21

end event

event pfc_addrow;//BEGIN---Modify by Scofield on 2009-09-21
if IsValid(w_contract_contact) then
	w_contract_contact.cb_add.TriggerEvent(Clicked!)
end if

Return 1
//END---Modify by Scofield on 2009-09-21

end event

event rbuttonup;//////////////////////////////////////////////////////////////////////////////
//	Event:  			rbuttonup
//	Description:		Popup menu
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0   	Initial version
//						5.0.04 Modified script to avoid 64K segment problem with 16bit machine code executables
// 						6.0		Added DataWindow Property to the popup menu.
// 						6.0 	Added check for the new RowManager.of_GetRestoreRow() switch.
// 						6.0.01 Added call to pfc_prermbmenuproperty to isolate calls to shared variable.
// 						6.0.01 Corrected so that dwo.protect works properly for protect expressions.
//////////////////////////////////////////////////////////////////////////////
//	Copyright ? 1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
Boolean		lb_frame
Boolean		lb_desired
Boolean		lb_readonly
Boolean		lb_editstyleattrib
Integer		li_tabsequence
Long			ll_getrow,ll_Right
String		ls_editstyle
String		ls_val
String		ls_protect
String		ls_colname
String		ls_currcolname
String		ls_type
String		ls_expression
n_cst_conversion	lnv_conversion
m_dw					lm_dw
window				lw_parent
window				lw_frame
window				lw_sheet
window				lw_childparent

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-05-29 By: Scofield
//$<Reason> Forbid popup menu if it has read only right

ll_Right = w_mdi.of_security_access(6930)				//Access Rights
if ll_Right = 0 or ll_Right = 1 then Return 1
//---------------------------- APPEON END ----------------------------

// No RMB support for OLE objects and graphs
ls_type = dwo.Type
If ls_type = "ole" Or ls_type = "tableblob" Or ls_type = "graph" Then Return 1

// No RMB support for print preview mode
If This.Object.DataWindow.Print.Preview = "yes" Then Return 1

// Determine parent window for PointerX, PointerY offset
This.of_GetParentWindow (lw_parent)
If IsValid (lw_parent) Then
	// Get the MDI frame window if available
	lw_frame = lw_parent
	Do While IsValid (lw_frame)
		If lw_frame.WindowType = MDI! Or lw_frame.WindowType = MDIHelp! Then
			lb_frame = True
			Exit
		Else
			lw_frame = lw_frame.ParentWindow()
		End If
	Loop
	
	If lb_frame Then
		// If MDI frame window is available, use it as the reference point for the
		// popup menu for sheets (windows opened with OpenSheet function) or child windows
		If lw_parent.WindowType = Child! Then
			lw_parent = lw_frame
		Else
			lw_sheet = lw_frame.GetFirstSheet()
			If IsValid (lw_sheet) Then
				Do
					// Use frame reference for popup menu if the parentwindow is a sheet
					If lw_sheet = lw_parent Then
						lw_parent = lw_frame
						Exit
					End If
					lw_sheet = lw_frame.GetNextSheet (lw_sheet)
				Loop Until IsNull(lw_sheet) Or Not IsValid (lw_sheet)
			End If
		End If
	Else
		// SDI application.  All windows except for child windows will use the parent
		// window of the control as the reference point for the popmenu
		If lw_parent.WindowType = Child! Then
			lw_childparent = lw_parent.ParentWindow()
			If IsValid (lw_childparent) Then
				lw_parent = lw_childparent
			End If
		End If
	End If
Else
	Return 1
End If

// Create popup menu
lm_dw = Create m_dw
lm_dw.of_SetParent (This)

//////////////////////////////////////////////////////////////////////////////
// Main popup menu operations
//////////////////////////////////////////////////////////////////////////////
ll_getrow = This.GetRow()

ls_val = This.Object.DataWindow.Readonly
lb_readonly = lnv_conversion.of_Boolean (ls_val)

Choose Case ls_type
	Case "datawindow", "column", "compute", "text", "report", &
		"bitmap", "line", "ellipse", "rectangle", "roundrectangle"
	
	// Row operations based on readonly status
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', Not lb_readonly)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_addrow,'Enabled', Not lb_readonly)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', Not lb_readonly)
	
	// Menu item enablement for current row
	If Not lb_readonly Then
		lb_desired = False
		If ll_getrow > 0 Then lb_desired = True
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', lb_desired)
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', lb_desired)
	End If
	
Case Else
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', False)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_delete,'Enabled', False)
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_addrow,'Enabled', False)
End Choose

// Get column properties
ls_currcolname = This.GetColumnName()
If ls_type = "column" Then
	ls_editstyle = dwo.Edit.Style
	ls_colname = dwo.Name
	ls_protect = dwo.Protect
	If Not IsNumber(ls_protect) Then
		// Since it is not a number, it must be an expression.
		ls_expression = Right(ls_protect, Len(ls_protect) - Pos(ls_protect, "~t"))
		ls_expression = "Evaluate(~""+ls_expression+","+String(row)+")"
		ls_protect = This.Describe(ls_expression)
	End If
	ls_val = dwo.TabSequence
	If IsNumber (ls_val) Then
		li_tabsequence = Integer (ls_val)
	End If
End If

//////////////////////////////////////////////////////////////////////////////
// Transfer operations.  Only enable for editable column edit styles
//////////////////////////////////////////////////////////////////////////////
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_copy,'Enabled', False)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_cut,'Enabled', False)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_paste,'Enabled', False)
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_selectall,'Enabled', False)

// Get the column/editystyle specific editable flag.
If ls_type = "column" And Not lb_readonly Then
	Choose Case ls_editstyle
		Case "edit"
			ls_val = dwo.Edit.DisplayOnly
		Case "editmask"
			ls_val = dwo.EditMask.Readonly
		Case "ddlb"
			ls_val = dwo.DDLB.AllowEdit
		Case "dddw"
			ls_val = dwo.DDDW.AllowEdit
		Case Else
			ls_val = ""
	End Choose
	lb_editstyleattrib = lnv_conversion.of_Boolean (ls_val)
	If IsNull(lb_editstyleattrib) Then lb_editstyleattrib = False
End If

//////////////////////////////////////////////////////////////////////////////
// Services
//////////////////////////////////////////////////////////////////////////////
// Row Manager
If IsValid (inv_RowManager) Then
	// Undelete capability
	If inv_RowManager.of_IsRestoreRow() Then
		lm_dw.m_table.m_restorerow.Visible = True
		If This.DeletedCount() > 0 And Not lb_readonly Then
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', True)
		Else
			gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', False)
		End If
	End If
Else
	lm_dw.m_table.m_restorerow.Visible = False
	gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', False)
End If

// QueryMode
// Default to false
lm_dw.m_table.m_operators.Visible = False
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_operators,'Enabled', False)
lm_dw.m_table.m_values.Visible = False
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_values,'Enabled', False)
lm_dw.m_table.m_dash12.Visible = False

If IsValid (inv_QueryMode) Then
	If inv_QueryMode.of_GetEnabled() Then
		// Do not allow undelete while in querymode
		lm_dw.m_table.m_restorerow.Visible = False
		gnv_app.of_modify_menu_attr( lm_dw.m_table.m_restorerow,'Enabled', False)
		
		// Default visible to true if in querymode
		lm_dw.m_table.m_values.Visible = True
		lm_dw.m_table.m_operators.Visible = True
		lm_dw.m_table.m_dash12.Visible = True
	End If
End If

// DataWindow property entries. (isolate calls to shared variable)
This.Event pfc_prermbmenuproperty (lm_dw)

// Allow for any other changes to the popup menu before it opens
This.Event pfc_prermbmenu (lm_dw)

// Send rbuttonup notification to row selection service
If IsValid (inv_RowSelect) Then inv_RowSelect.Event pfc_rbuttonup (xpos, ypos, row, dwo)

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-18 By: Scofield
//$<Reason> Don't display the mailaspdf and saveaspdf menu item
gnv_app.of_modify_menu_attr( lm_dw.m_table.m_insert,'Enabled', False)
lm_dw.m_table.m_mailaspdf.Visible = False
lm_dw.m_table.m_saveaspdf.Visible = False
//---------------------------- APPEON END ----------------------------

// Popup menu
lm_dw.m_table.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)

Destroy lm_dw

Return 1

end event

type gb_3 from u_gb within u_tabpg_cntct_search
integer x = 55
integer y = 556
integer width = 910
integer height = 452
integer taborder = 21
integer weight = 400
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Company Category Search"
end type

type gb_4 from groupbox within u_tabpg_cntct_search
integer x = 14
integer width = 992
integer height = 1920
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 134217856
long backcolor = 33551856
string text = "Search by:"
end type

type rb_6 from radiobutton within u_tabpg_cntct_search
integer x = 119
integer y = 376
integer width = 462
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Contact Person"
end type

event clicked;long	ll_OldRow,ll_NewRow

if This.Checked then
	gb_1.Text = "First Letter of Last Name Search"
	gb_3.Text = "Contact Category Search"
	
	of_AdjustdwPos(1)
	//Added By Alan on 2009-1-13 notes:contact filter
	if dw_search.Describe("DataWindow.Table.Filter")<>'' and dw_search.Describe("DataWindow.Table.Filter")<>'?' then is_filter = dw_search.Describe("DataWindow.Table.Filter")
	dw_search.setfilter(is_filter)		
	//end
	ll_OldRow = dw_search.GetRow()
	dw_search.event pfc_retrieve()
	ll_NewRow = dw_search.GetRow()
	//Added By Alan on 2009-1-13 notes:contact filter
	dw_search.setfilter("")
	//end
	if ll_NewRow = ll_OldRow then
		dw_search.Event RowFocusChanged(ll_NewRow)
	end if
end if

end event

type rb_5 from radiobutton within u_tabpg_cntct_search
integer x = 119
integer y = 192
integer width = 343
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Company"
boolean checked = true
end type

event clicked;long	ll_OldRow,ll_NewRow

if This.Checked then
	gb_1.Text = "First Letter of Company Name Search"
	gb_3.Text = "Company Category Search"
	
	of_AdjustdwPos(2)
	
	//Added By Alan on 2009-1-13 notes:contact filter
	if dw_search.Describe("DataWindow.Table.Filter")<>'' and dw_search.Describe("DataWindow.Table.Filter")<>'?' then is_filter = dw_search.Describe("DataWindow.Table.Filter")
	
	ll_OldRow = dw_facility_search.GetRow()
	dw_facility_search.Event pfc_retrieve()
	ll_NewRow = dw_facility_search.GetRow()
	
	if ll_NewRow = ll_OldRow then
		dw_facility_search.Event RowFocusChanged(ll_NewRow)
	end if
end if

end event

