$PBExportHeader$u_tabpg_org_search.sru
$PBExportComments$[intellicontract_tab] The contract locations Tab Page
forward
global type u_tabpg_org_search from u_tabpg_contract_master
end type
type cb_ok from u_cb within u_tabpg_org_search
end type
type st_2 from u_st within u_tabpg_org_search
end type
type rb_multiple from u_rb within u_tabpg_org_search
end type
type rb_single from u_rb within u_tabpg_org_search
end type
type cb_2 from u_cb within u_tabpg_org_search
end type
type cb_1 from u_cb within u_tabpg_org_search
end type
type cb_54 from u_cb within u_tabpg_org_search
end type
type cb_52 from u_cb within u_tabpg_org_search
end type
type cb_51 from u_cb within u_tabpg_org_search
end type
type cb_49 from u_cb within u_tabpg_org_search
end type
type cb_48 from u_cb within u_tabpg_org_search
end type
type cb_47 from u_cb within u_tabpg_org_search
end type
type cb_46 from u_cb within u_tabpg_org_search
end type
type cb_45 from u_cb within u_tabpg_org_search
end type
type cb_44 from u_cb within u_tabpg_org_search
end type
type cb_43 from u_cb within u_tabpg_org_search
end type
type cb_42 from u_cb within u_tabpg_org_search
end type
type cb_41 from u_cb within u_tabpg_org_search
end type
type cb_40 from u_cb within u_tabpg_org_search
end type
type cb_39 from u_cb within u_tabpg_org_search
end type
type cb_37 from u_cb within u_tabpg_org_search
end type
type cb_35 from u_cb within u_tabpg_org_search
end type
type cb_33 from u_cb within u_tabpg_org_search
end type
type cb_29 from u_cb within u_tabpg_org_search
end type
type cb_26 from u_cb within u_tabpg_org_search
end type
type cb_38 from u_cb within u_tabpg_org_search
end type
type cb_36 from u_cb within u_tabpg_org_search
end type
type cb_34 from u_cb within u_tabpg_org_search
end type
type cb_32 from u_cb within u_tabpg_org_search
end type
type cb_31 from u_cb within u_tabpg_org_search
end type
type cb_30 from u_cb within u_tabpg_org_search
end type
type cb_27 from u_cb within u_tabpg_org_search
end type
type cb_new from commandbutton within u_tabpg_org_search
end type
type sle_srch_val from singlelineedit within u_tabpg_org_search
end type
type ddlb_search_type from dropdownlistbox within u_tabpg_org_search
end type
type cb_3 from commandbutton within u_tabpg_org_search
end type
type gb_1 from u_gb within u_tabpg_org_search
end type
type gb_2 from u_gb within u_tabpg_org_search
end type
type dw_search from u_dw within u_tabpg_org_search
end type
type gb_3 from groupbox within u_tabpg_org_search
end type
end forward

global type u_tabpg_org_search from u_tabpg_contract_master
integer width = 3726
integer height = 1704
string text = "Search"
event ue_new_org ( string as_mode )
event type long ue_save ( )
cb_ok cb_ok
st_2 st_2
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
cb_3 cb_3
gb_1 gb_1
gb_2 gb_2
dw_search dw_search
gb_3 gb_3
end type
global u_tabpg_org_search u_tabpg_org_search

type variables
n_cst_sql   inv_sql
tab a_parent_tab
userobject a_tab_page
u_tabpg_org_details i_detail_tab
string is_parent_title
string is_search_letter
end variables

forward prototypes
public function integer of_search (string as_letter)
public function integer of_allow_muliti_select (string as_mode)
end prototypes

event ue_new_org(string as_mode);/******************************************************************************************************************
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
		iw_parent.event dynamic ue_save()
		a_parent_tab.FUNCTION DYNAMIC OF_SET_MODE('NEW')
		a_parent_tab.SelectTab(2)
		iw_parent.event dynamic ue_new()
		iw_parent.title =  is_parent_title + ' New Mode'
	case else
		iw_parent.title =  is_parent_title + ' Edit Mode'
		a_parent_tab.FUNCTION DYNAMIC OF_SET_MODE(upper('EDIT'))
		iw_parent.event dynamic ue_save()
		IF dw_search.ROWCOUNT() > 0 THEN
			//a_parent_tab.SelectTab(2)
			a_parent_tab.FUNCTION DYNAMIC OF_SET_CONTACT_ID( dw_search.OBJECt.contact_id[dw_search.getrow()]  )
			//iw_parent.FUNCTION DYNAMIC OF_RETRIEVE()
		END IF
end choose
end event

event type long ue_save();

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
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


long li_rc,ll_rc2
powerobject lpo[]
lpo = iw_parent.control


li_rc =   iw_parent.event dynamic pfc_updatespending(lpo )
//this.tab_contract_details.tabpage_details.tab_1.of_accepttext( true)
//ll_rc2 = this.tab_contract_details.tabpage_details.tab_1.of_UpdatesPending( )


//li_rc =  THIS.tab_contract_details.tabpage_details.tab_1.tabpage_1.of_updatechecks( )

//choose case li_rc
//	case -1 
//		of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, "AcceptText error - Please contact Intelisoft Support", exclamation!, ok!, 1)
//		return failure
//	case -2
//		of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, "UpdatesPending error - Please contact Intelisoft Support", exclamation!, ok!, 1)
//		return failure
//	case -3
//		of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, "Validation error - Please contact Intelisoft Support", exclamation!, ok!, 1)
//		return failure
//end choose 

if li_rc > 0  then 
			li_rc =  of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, "Do you want to save changes?", exclamation!, YesNoCancel!, 1)
	Choose Case li_rc
		Case 1
			// YES - Update
			// If the update fails, prevent the window from closing
	       iw_parent.Event dynamic pfc_save()
		
		
		Case 2
			// do nothing reset the datawindows			
		Case 3
			// CANCEL -  Prevent the window from closing
			return success
	End Choose
else
	a_parent_tab.function dynamic of_set_retrieve_status()

end if


return success
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

a_parent_tab.function dynamic of_set_mode('EDIT')

//event ue_new('EDIT')

is_search_letter = as_letter 

dw_search.event pfc_retrieve( )

return success
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

on u_tabpg_org_search.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.st_2=create st_2
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
this.cb_3=create cb_3
this.gb_1=create gb_1
this.gb_2=create gb_2
this.dw_search=create dw_search
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.rb_multiple
this.Control[iCurrent+4]=this.rb_single
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.cb_54
this.Control[iCurrent+8]=this.cb_52
this.Control[iCurrent+9]=this.cb_51
this.Control[iCurrent+10]=this.cb_49
this.Control[iCurrent+11]=this.cb_48
this.Control[iCurrent+12]=this.cb_47
this.Control[iCurrent+13]=this.cb_46
this.Control[iCurrent+14]=this.cb_45
this.Control[iCurrent+15]=this.cb_44
this.Control[iCurrent+16]=this.cb_43
this.Control[iCurrent+17]=this.cb_42
this.Control[iCurrent+18]=this.cb_41
this.Control[iCurrent+19]=this.cb_40
this.Control[iCurrent+20]=this.cb_39
this.Control[iCurrent+21]=this.cb_37
this.Control[iCurrent+22]=this.cb_35
this.Control[iCurrent+23]=this.cb_33
this.Control[iCurrent+24]=this.cb_29
this.Control[iCurrent+25]=this.cb_26
this.Control[iCurrent+26]=this.cb_38
this.Control[iCurrent+27]=this.cb_36
this.Control[iCurrent+28]=this.cb_34
this.Control[iCurrent+29]=this.cb_32
this.Control[iCurrent+30]=this.cb_31
this.Control[iCurrent+31]=this.cb_30
this.Control[iCurrent+32]=this.cb_27
this.Control[iCurrent+33]=this.cb_new
this.Control[iCurrent+34]=this.sle_srch_val
this.Control[iCurrent+35]=this.ddlb_search_type
this.Control[iCurrent+36]=this.cb_3
this.Control[iCurrent+37]=this.gb_1
this.Control[iCurrent+38]=this.gb_2
this.Control[iCurrent+39]=this.dw_search
this.Control[iCurrent+40]=this.gb_3
end on

on u_tabpg_org_search.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.st_2)
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
destroy(this.cb_3)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.dw_search)
destroy(this.gb_3)
end on

event constructor;call super::constructor;a_parent_tab = GetParent()
this.of_getparentwindow(iw_parent )
is_parent_title = iw_parent.title


end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_org_search
integer y = 1408
integer height = 64
end type

type cb_ok from u_cb within u_tabpg_org_search
integer x = 608
integer y = 788
integer width = 334
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string text = "S&elect"
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

LONG LL_I
LONG LL_selecred_row
long ll_org_id //Add by Jack 05/22/2007

if not isvalid(iw_parent) then 
	messagebox(iw_parent.title ,'Parent window is not valid')
end if
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.15.2006 By: Liang QingShi
//$<reason> Fix a defect.
/*
for ll_I = 0 TO DW_search.ROWCOUNT()
		LL_selecred_row = DW_search.GetSelectedRow(ll_I)
	
		if LL_selecred_row > 0 then 
			

					iw_parent.function dynamic OF_ADD_orgs(DW_search.object.org_id[LL_selecred_row] ,&
																		DW_search.object.org_name[LL_selecred_row] ,&
																		DW_search.object.status[LL_selecred_row]  ,&
																		DW_search.object.org_type[LL_selecred_row]  ,&
																		DW_search.object.street_1[LL_selecred_row]  ,&
																		DW_search.object.street_2[LL_selecred_row]  ,&
																		DW_search.object.street_3[LL_selecred_row]  ,& 
																		DW_search.object.city[LL_selecred_row]      ,&
																		DW_search.object.state[LL_selecred_row]     ,&
																		DW_search.object.zip[LL_selecred_row] 		)														 
		end if
	
next 
*/

for ll_I = 1 TO DW_search.ROWCOUNT()
	LL_selecred_row = DW_search.getitemnumber(ll_i,'selected')
	if LL_selecred_row = 1 then 		
		iw_parent.function dynamic OF_ADD_orgs(DW_search.object.org_id[ll_I] ,&
																		DW_search.object.org_name[ll_I] ,&
																		DW_search.object.status[ll_I]  ,&
																		DW_search.object.org_type[ll_I]  ,&
																		DW_search.object.street_1[ll_I]  ,&
																		DW_search.object.street_2[ll_I]  ,&
																		DW_search.object.street_3[ll_I]  ,& 
																		DW_search.object.city[ll_I]      ,&
																		DW_search.object.state[ll_I]     ,&
																		DW_search.object.zip[ll_I] 		)
		ll_org_id = DW_search.object.org_id[ll_I] //Add by Jack 05/22/2007
	end if
	
next 
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05.22.2007 By: Jack
//$<reason> Fxi a defect.
/*
close(iw_parent)
*/
closewithreturn(iw_parent,ll_org_id)
//---------------------------- APPEON END ----------------------------

end event

type st_2 from u_st within u_tabpg_org_search
boolean visible = false
integer x = 1179
integer y = 204
integer width = 800
boolean bringtotop = true
string text = "(Used for inserting multiple contacts.)"
end type

type rb_multiple from u_rb within u_tabpg_org_search
boolean visible = false
integer x = 1157
integer y = 252
integer width = 713
integer height = 64
boolean bringtotop = true
string text = "Multi Row Selection "
end type

event clicked;call super::clicked;

PARENT.OF_allow_muliti_select(string(dw_search.inv_rowselect.multiple ) )
end event

type rb_single from u_rb within u_tabpg_org_search
boolean visible = false
integer x = 1157
integer y = 188
integer width = 713
integer height = 64
boolean bringtotop = true
string text = "Single Row Selection"
boolean checked = true
end type

event clicked;call super::clicked;

PARENT.OF_allow_muliti_select(string(dw_search.inv_rowselect.single) )
end event

type cb_2 from u_cb within u_tabpg_org_search
integer x = 613
integer y = 904
integer width = 334
integer taborder = 10
boolean bringtotop = true
string text = "&Save"
end type

event clicked;call super::clicked;

iw_parent.event dynamic ue_save()
end event

type cb_1 from u_cb within u_tabpg_org_search
integer x = 759
integer y = 484
integer width = 210
integer height = 116
integer taborder = 10
boolean bringtotop = true
string text = "All"
end type

event clicked;call super::clicked;
string ls_null

setnull(ls_null)

of_search(ls_null)
end event

type cb_54 from u_cb within u_tabpg_org_search
integer x = 763
integer y = 284
integer width = 206
integer height = 64
integer taborder = 10
boolean bringtotop = true
string text = "x"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_52 from u_cb within u_tabpg_org_search
integer x = 763
integer y = 412
integer width = 206
integer height = 64
integer taborder = 80
boolean bringtotop = true
string text = "z"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_51 from u_cb within u_tabpg_org_search
integer x = 763
integer y = 348
integer width = 206
integer height = 64
integer taborder = 70
boolean bringtotop = true
string text = "y"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_49 from u_cb within u_tabpg_org_search
integer x = 763
integer y = 220
integer width = 206
integer height = 64
integer taborder = 10
boolean bringtotop = true
string text = "w"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_48 from u_cb within u_tabpg_org_search
integer x = 763
integer y = 156
integer width = 206
integer height = 64
integer taborder = 10
boolean bringtotop = true
string text = "v"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_47 from u_cb within u_tabpg_org_search
integer x = 544
integer y = 152
integer width = 197
integer height = 64
integer taborder = 10
boolean bringtotop = true
string text = "o"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_46 from u_cb within u_tabpg_org_search
integer x = 544
integer y = 216
integer width = 197
integer height = 64
integer taborder = 50
boolean bringtotop = true
string text = "p"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_45 from u_cb within u_tabpg_org_search
integer x = 544
integer y = 536
integer width = 197
integer height = 64
integer taborder = 90
boolean bringtotop = true
string text = "u"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_44 from u_cb within u_tabpg_org_search
integer x = 544
integer y = 344
integer width = 197
integer height = 64
integer taborder = 70
boolean bringtotop = true
string text = "r"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_43 from u_cb within u_tabpg_org_search
integer x = 544
integer y = 408
integer width = 197
integer height = 64
integer taborder = 80
boolean bringtotop = true
string text = "s"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_42 from u_cb within u_tabpg_org_search
integer x = 544
integer y = 472
integer width = 197
integer height = 64
integer taborder = 90
boolean bringtotop = true
string text = "t"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_41 from u_cb within u_tabpg_org_search
integer x = 544
integer y = 280
integer width = 197
integer height = 64
integer taborder = 60
boolean bringtotop = true
string text = "q"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_40 from u_cb within u_tabpg_org_search
integer x = 325
integer y = 280
integer width = 197
integer height = 64
integer taborder = 70
boolean bringtotop = true
string text = "j"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_39 from u_cb within u_tabpg_org_search
integer x = 325
integer y = 472
integer width = 197
integer height = 64
integer taborder = 90
boolean bringtotop = true
string text = "m"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_37 from u_cb within u_tabpg_org_search
integer x = 325
integer y = 408
integer width = 197
integer height = 64
integer taborder = 80
boolean bringtotop = true
string text = "l"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_35 from u_cb within u_tabpg_org_search
integer x = 325
integer y = 344
integer width = 197
integer height = 64
integer taborder = 80
boolean bringtotop = true
string text = "k"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_33 from u_cb within u_tabpg_org_search
integer x = 325
integer y = 536
integer width = 197
integer height = 64
integer taborder = 100
boolean bringtotop = true
string text = "n"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_29 from u_cb within u_tabpg_org_search
integer x = 325
integer y = 216
integer width = 197
integer height = 64
integer taborder = 60
boolean bringtotop = true
string text = "i"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_26 from u_cb within u_tabpg_org_search
integer x = 325
integer y = 152
integer width = 197
integer height = 64
integer taborder = 10
boolean bringtotop = true
string text = "h"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_38 from u_cb within u_tabpg_org_search
integer x = 105
integer y = 152
integer width = 197
integer height = 64
integer taborder = 10
boolean bringtotop = true
string text = "a"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_36 from u_cb within u_tabpg_org_search
integer x = 105
integer y = 216
integer width = 197
integer height = 64
integer taborder = 60
boolean bringtotop = true
string text = "b"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_34 from u_cb within u_tabpg_org_search
integer x = 105
integer y = 536
integer width = 197
integer height = 64
integer taborder = 100
boolean bringtotop = true
string text = "g"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_32 from u_cb within u_tabpg_org_search
integer x = 105
integer y = 344
integer width = 197
integer height = 64
integer taborder = 80
boolean bringtotop = true
string text = "d"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_31 from u_cb within u_tabpg_org_search
integer x = 105
integer y = 408
integer width = 197
integer height = 64
integer taborder = 80
boolean bringtotop = true
string text = "e"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_30 from u_cb within u_tabpg_org_search
integer x = 105
integer y = 472
integer width = 197
integer height = 64
integer taborder = 90
boolean bringtotop = true
string text = "f"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_27 from u_cb within u_tabpg_org_search
integer x = 105
integer y = 280
integer width = 197
integer height = 64
integer taborder = 70
boolean bringtotop = true
string text = "c"
end type

event clicked;call super::clicked;of_search(This.Text)
end event

type cb_new from commandbutton within u_tabpg_org_search
integer x = 119
integer y = 788
integer width = 334
integer height = 92
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&New"
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


parent.event ue_new_org('NEW')

end event

type sle_srch_val from singlelineedit within u_tabpg_org_search
boolean visible = false
integer x = 73
integer y = 1068
integer width = 942
integer height = 80
integer taborder = 130
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

type ddlb_search_type from dropdownlistbox within u_tabpg_org_search
boolean visible = false
integer x = 69
integer y = 1068
integer width = 946
integer height = 160
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"Last Name","I.D.","SS #","Apps Needing Printed","Provider ID","Primary Department","Custom Search"}
borderstyle borderstyle = stylelowered!
end type

event constructor;This.Text = "Last Name"
end event

type cb_3 from commandbutton within u_tabpg_org_search
integer x = 119
integer y = 904
integer width = 334
integer height = 92
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Detail"
end type

event clicked;

if dw_search.rowcount( ) < 1 then return 
a_parent_tab.function dynamic of_set_org_id(dw_search.getitemNumber(dw_search.getrow(),'org_id'))
a_parent_tab.function dynamic  of_retrieve( )
a_parent_tab.selecttab( 2)
end event

type gb_1 from u_gb within u_tabpg_org_search
integer x = 69
integer y = 56
integer width = 951
integer height = 616
integer taborder = 10
integer weight = 400
fontcharset fontcharset = ansi!
long backcolor = 33551856
string text = "First Letter of Organization Name"
end type

type gb_2 from u_gb within u_tabpg_org_search
boolean visible = false
integer x = 1120
integer y = 92
integer width = 951
integer height = 352
integer taborder = 10
string text = "Row Selection Mode"
end type

type dw_search from u_dw within u_tabpg_org_search
string tag = "Search List"
integer x = 1093
integer y = 68
integer width = 2578
integer height = 1552
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Search List"
string dataobject = "d_org_search"
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

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

string ls_sql

n_cst_sqlattrib   lnv_sqlattrib[ ]
inv_sql.of_Parse(GetSQLSelect(), lnv_sqlattrib)

if not f_validstr(is_search_letter) then 
	setnull(is_search_letter)
	// enforce a restriction on the number of rows retrieved
	lnv_sqlattrib[1].s_where = ""
	//Start code changes - #1 1.5.2007 Henry.
	//In web application, 'set rowcount' will impact the other retrieves. 
	//need to search a solution to replace with 'set rowcount' in web application...
	//execute immediate 'set rowcount 200' using sqlca;
	/*
	Jervis 05/10/2007
	If appeongetclienttype() = 'PB' Then 
		execute immediate 'set rowcount 200' using sqlca;
	End If
	*/
	//End code changes - 1.5.2007 Henry
else 
	lnv_sqlattrib[1].s_where = "(ctx_orgs.org_name like" + " '" + is_search_letter + "%'"  + ")"
	//execute immediate 'set rowcount 0' using sqlca; 05/10/2007 By Jervis
end if


ls_sql = inv_sql.of_Assemble(lnv_sqlattrib)
SETSQLSELECT(ls_sql)

this.retrieve( is_search_letter)

return success
end event

event doubleclicked;call super::doubleclicked;



if GetSelectedRow(0) < 1 then return success

a_parent_tab.function dynamic of_set_org_id(this.getitemNumber(GetSelectedRow(0),'org_id'))
a_parent_tab.function dynamic  of_retrieve( )
a_parent_tab.selecttab( 2)
end event

event constructor;call super::constructor;of_SetSort(True)
inv_sort.of_SetStyle(3)
of_SetReqColumn(True)
inv_sort.of_SetColumnHeader(True)
dw_search.of_SetRowSelect(TRUE)

//DW_SEARCH.inv_rowselect.of_SetStyle(DW_SEARCH.inv_rowselect.multiple )


long ll_count 
 
 select count(*)
 into :ll_count
 FROM ctx_orgs;
 
 if ll_count < 101 then retrieve( )
  


end event

event rowfocuschanging;call super::rowfocuschanging;

if rowcount() < 1 then return 
a_parent_tab.FUNCTION DYNAMIC OF_SET_org_id( THIS.OBJECT.org_id[newrow])


 	
end event

event itemchanged;call super::itemchanged;

if long (data) = 1 then 
	 This.SelectRow(row, TRUE)
else 
    This.SelectRow(row, false)
end if 


end event

type gb_3 from groupbox within u_tabpg_org_search
integer x = 59
integer y = 724
integer width = 951
integer height = 308
integer taborder = 450
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Options"
end type

