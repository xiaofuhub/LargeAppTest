$PBExportHeader$u_tabpg_cpt_maint.sru
$PBExportComments$[intellicontract_tab]
forward
global type u_tabpg_cpt_maint from u_tabpg_contract_master
end type
type dw_1 from u_dw_contract within u_tabpg_cpt_maint
end type
type gb_1 from groupbox within u_tabpg_cpt_maint
end type
type cb_4 from u_cb within u_tabpg_cpt_maint
end type
type cb_save from commandbutton within u_tabpg_cpt_maint
end type
type cb_clise from commandbutton within u_tabpg_cpt_maint
end type
type cb_1 from u_cb within u_tabpg_cpt_maint
end type
end forward

global type u_tabpg_cpt_maint from u_tabpg_contract_master
integer width = 4101
integer height = 1900
string text = "Maintenance"
string picturename = "Update!"
dw_1 dw_1
gb_1 gb_1
cb_4 cb_4
cb_save cb_save
cb_clise cb_clise
cb_1 cb_1
end type
global u_tabpg_cpt_maint u_tabpg_cpt_maint

forward prototypes
public function integer of_add_like (boolean ab_add)
public function long of_get_maxcptcode ()
end prototypes

public function integer of_add_like (boolean ab_add);/******************************************************************************************************************
**  [PUBLIC]   : of_add_like( /*boolean ab_add */)
**==================================================================================================================
**  Purpose   	: adds like to the query datawindow
**==================================================================================================================
**  Arguments 	: [boolean]   ab_add True add the % , false , do no add the %
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 27 Febuary 2006 © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

integer li_cols, li_i, li_rows, li_j,li_k, li_count, li_k1, li_m
string ls_type, ls_tmp

dw_1.AcceptText()

li_rows = dw_1.RowCount()
li_cols = Integer(dw_1.Describe("DataWindow.Column.Count"))


for li_i = 1 to li_cols
	
  ls_type = Mid(dw_1.Describe("#"+Trim(String(li_i))+".Coltype"),1,4)

	if ls_type = "char" then 		
		
		for li_j = 1 to DW_1.ROWCOUNT() 
			dw_1.SetRow(li_j)
			dw_1.SetColumn(li_i)	
			ls_tmp = dw_1.GetText()
		 
			if Not IsNULL(ls_tmp) and trim(ls_tmp)<>"" and trim(ls_tmp)<> "%" then  
					if ab_add then
							IF Left(ls_Tmp,1) = "'" then  ls_tmp = Right(ls_tmp,len(ls_tmp) -1)
							IF Right(ls_Tmp,1) = "'" then ls_tmp = Left(ls_tmp,len(ls_tmp) -1)
						if Upper(Mid(ls_tmp,1,5)) <> "LIKE " then
							ls_tmp =  "LIKE "+ls_tmp+"%"
							If Right(ls_tmp,2) = "%%" then ls_tmp=Left(ls_tmp,len(ls_tmp)-1) 
							dw_1.SetColumn(li_i)
							dw_1.SetText(ls_tmp)
						end if
					else
	
						if Upper(Mid(ls_tmp,1,5)) = "LIKE " then
							ls_tmp = Mid(ls_tmp,6,250) 
							ls_tmp = Mid(ls_tmp,1,len(ls_tmp)-1)  
							dw_1.SetColumn(li_i)
							dw_1.SetText(ls_tmp)
							
						end if
					end if
				end if
			next
	end if
next


dw_1.accepttext( )

return 1

end function

public function long of_get_maxcptcode ();// (Appeon)Harry 06.07.2013 - V141 ISG-CLX
//added by long.zhang 05.03.2013
long ll_code

select max(cpt_code_id) into :ll_code From ctx_cpt_codes;

if isNUll(ll_code) then ll_code=0

return ll_code
end function

on u_tabpg_cpt_maint.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.gb_1=create gb_1
this.cb_4=create cb_4
this.cb_save=create cb_save
this.cb_clise=create cb_clise
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.cb_4
this.Control[iCurrent+4]=this.cb_save
this.Control[iCurrent+5]=this.cb_clise
this.Control[iCurrent+6]=this.cb_1
end on

on u_tabpg_cpt_maint.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.cb_4)
destroy(this.cb_save)
destroy(this.cb_clise)
destroy(this.cb_1)
end on

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_cpt_maint
integer x = 133
integer y = 1972
end type

type dw_1 from u_dw_contract within u_tabpg_cpt_maint
integer x = 59
integer y = 168
integer width = 3959
integer height = 1676
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_cpt_code_maint"
boolean ib_use_row_selection = true
end type

event constructor;call super::constructor;//dw_1.Object.DataWindow.QueryMode = "yes" 
of_setreqcolumn( true)
this.of_SetSort(TRUE)


this.inv_sort.of_SetUseDisplay(TRUE)

this.inv_sort.of_SetColumnnameSource(this.inv_sort.HEADER)

this.inv_sort.of_SetStyle(this.inv_sort.DRAGDROP)

this.inv_sort.of_SetColumnHeader(TRUE)


this.of_SetFilter(TRUE)
this.inv_filter.of_SetColumnDisplayNameStyle(2)
this.inv_filter.of_SetStyle(2)


event ue_populatedddws()	//08.17.2009 by jervis
end event

event buttonclicked;call super::buttonclicked;
choose case dwo.name
	case 'b_sort'
		event pfc_sortdlg( )
		
	case 'b_filter'
		event pfc_filterdlg( )
	case 'b_1'
		event pfc_deleterow( )
		
	case 'b_add'
		//this.insertrow(0)
		//---------Begin Added by (Appeon)Harry 02.11.2014 for Bug # 3873--------
		Long ll_currow
		ll_currow = this.insertrow(0)
		this.scrolltorow(ll_currow)
		this.setrow(ll_currow)
		//---------End Added ------------------------------------------------------
end choose
end event

event pfc_preupdate;


return success
end event

event pfc_validation;long ll_count
//---------Begin Modified by (Appeon)Harry 06.07.2013 for V141 ISG-CLX--------
long ll_code

//------------appeon begin---------------
//<$>Commented:long.zhang 05.03.2013
//<$>reason:move to below
//for ll_count = 1 to this.rowcount()
//	if not f_validstr(string(this.object.cpt_code_id[ll_count])) then
//		
//	this.object.cpt_code_id[ll_count] = gnv_app.of_get_id("LOOKUP")
//		
//	end if 
//	
//next
//-------------appeon end-------------------

IF Super::EVENT PFC_VALIDATION() <> SUCcess THEN 
	RETURN Failure
END IF

ll_code = of_get_maxcptcode()//long.zhang 05.03.2013
for ll_count = 1 to this.rowcount()
	if not f_validstr(string(this.object.cpt_code_id[ll_count])) then
		ll_code++//long.zhang 05.03.2013
//	this.object.cpt_code_id[ll_count] = gnv_app.of_get_id("LOOKUP")
			this.object.cpt_code_id[ll_count] = ll_code//long.zhang 05.03.2013
	end if 
	
next
//---------End Modfiied ------------------------------------------------------

return success
end event

type gb_1 from groupbox within u_tabpg_cpt_maint
integer x = 27
integer y = 112
integer width = 4037
integer height = 1764
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Code"
end type

type cb_4 from u_cb within u_tabpg_cpt_maint
string tag = "Opens the retrive parmeters window."
integer x = 2949
integer y = 16
integer taborder = 11
boolean bringtotop = true
string text = "&Find"
boolean default = true
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
**  Created By	: Michael B. Skinner © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


String ls_dataobject

///////////////////////////////////////////////////////////////////////
// PARENT.PF
///////////////////////////////////////////////////////////////////////
long ll_ret
//Modify by Alan on 2008-12-30 //BugA040802
if dw_1.ModifiedCount() + dw_1.DeletedCount() > 0 then
	if messagebox('Alert','Do you want to save changes?',Question!,YesNo!,1)=1 then
		ll_ret = iw_parent.DYNAMIC event pfc_SAVE()
		IF ll_ret < 0 then 
			RETURN 
		END IF 
	end if
end if

dw_1.SetRedraw(false)
str_pass lstr_pass

lstr_pass.s_u_dw = dw_1
ls_dataobject = dw_1.dataobject

dw_1.dataobject = ''
dw_1.dataobject = ls_dataobject
dw_1.ib_retrieve_drop_downs = false
dw_1.event ue_populatedddws()	//jervis-08.14.2009
dw_1.settransobject(sqlca)

dw_1.Object.DataWindow.QueryMode = "yes"

OpenWithParm(w_cpt_find, lstr_pass)
CHOOSE CASE Message.StringParm
	CASE 'EXACT'
		//do nothing
		//of_add_like(FALSE)
	CASE 'SIM'	
		of_add_like(TRUE)
	CASE 'ALL'
		
	CASE 'CANCEL'
		dw_1.Object.DataWindow.QueryMode = "no"
		RETURN 
end choose 
						
dw_1.Object.DataWindow.QueryMode = "no"
dw_1.retrieve( )
this.text = '&Find'

dw_1.setredraw(true)

end event

event constructor;call super::constructor;//this.tag = '0123fghdrdfhdfghdfghdfghdgfh sdrgsd wertw ertwert wer wert wert wer wert wertwertwer  wertwert wert wert wertewrt wret wertwertwer wert wert wer wertwertwe wertw ertwer wergre1233 '
end event

type cb_save from commandbutton within u_tabpg_cpt_maint
string tag = "Save changes"
integer x = 3323
integer y = 16
integer width = 352
integer height = 92
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;iw_parent.triggerevent('pfc_save')
end event

type cb_clise from commandbutton within u_tabpg_cpt_maint
string tag = "Close window"
integer x = 3698
integer y = 16
integer width = 352
integer height = 92
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;

iw_parent.triggerevent('pfc_close')
end event

type cb_1 from u_cb within u_tabpg_cpt_maint
string tag = "Retrieve All"
integer x = 2565
integer y = 16
integer taborder = 21
boolean bringtotop = true
string text = "&Retrieve All"
end type

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.12.2006 By: LeiWei
//$<reason> Add a Retrieve All button that will do the same as clicking 
//$<reason> Find->Retrieve All Codes Filter afterwoods. Function.

String 	ls_dataobject
String 	ls_RETURN_PARM
long 		ll_ret
//Modify by Alan on 2008-12-30 //BugA040802
if dw_1.ModifiedCount() + dw_1.DeletedCount() > 0 then
	if messagebox('Alert','Do you want to save changes?',Question!,YesNo!,1)=1 then
		ll_ret = iw_parent.DYNAMIC event pfc_SAVE()
		IF ll_ret < 0 then 
			RETURN 
		END IF 
	end if
end if

dw_1.SetFilter("") 		//10.24.2006 Fix a defect. Added by Davis.

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-03-11 By: Scofield
//$<Reason> Retrieve all record.

dw_1.DataObject = "d_cpt_code_maint"
dw_1.ib_retrieve_drop_downs = false
dw_1.event ue_populatedddws()	//jervis-08.14.2009
dw_1.SetTransObject(SQLCA)
dw_1.Retrieve()
//---------------------------- APPEON END ----------------------------
//---------------------------- APPEON END ----------------------------

end event

