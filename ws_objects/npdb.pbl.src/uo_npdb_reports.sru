$PBExportHeader$uo_npdb_reports.sru
forward
global type uo_npdb_reports from u_base
end type
type cb_next from commandbutton within uo_npdb_reports
end type
type cb_prior from commandbutton within uo_npdb_reports
end type
type cb_codes from commandbutton within uo_npdb_reports
end type
type st_2 from u_st_splitbar within uo_npdb_reports
end type
type st_1 from u_st within uo_npdb_reports
end type
type cb_1 from u_cb within uo_npdb_reports
end type
type dw_1 from u_dw within uo_npdb_reports
end type
type tv_1 from u_tv within uo_npdb_reports
end type
type mle_1 from multilineedit within uo_npdb_reports
end type
end forward

global type uo_npdb_reports from u_base
integer width = 4338
integer height = 2096
long backcolor = 33551856
event ue_retrieve ( string as_doc_id )
event pfc_print_all ( )
event ue_retrieve_qrxs ( long al_npdb_hdr_id,  string as_rootlable )
cb_next cb_next
cb_prior cb_prior
cb_codes cb_codes
st_2 st_2
st_1 st_1
cb_1 cb_1
dw_1 dw_1
tv_1 tv_1
mle_1 mle_1
end type
global uo_npdb_reports uo_npdb_reports

type variables

n_cst_npdb invo
window iw_parent_window
long il_rpt_id //maha041808
long il_count

//------------ APPEON BEGIN ------------
//$<Add> 12.16.2009 By: Evan
//$<Reason> V10.1 - NPDB QRXS
TreeViewItem itvi_CurrItem
long il_npdb_hdr_id
long il_Interface
constant long ITP_INTERFACE  = 1
constant long QRXS_INTERFACE = 2

string is_qrxs_report_dw[] = {"d_npdb_report_qrxs_aar", "d_npdb_report_qrxs_jocr", "d_npdb_report_qrxs_laar", "d_npdb_report_qrxs_mmpr", "d_npdb_report_qrxs_lmmpr"}
//------------ APPEON END --------------
end variables

forward prototypes
public function string of_report_no_match (long al_id)
public function integer of_set_id (long al_report)
public function integer of_setbuttonenabled ()
public function integer of_set_dddw (string as_report)
public function integer of_clearout_slideup (datawindowchild adwc_1)
public function integer of_adjust_field_height (ref datawindowchild adwc_1, string as_filed_name, integer ai_row_height)
end prototypes

event ue_retrieve(string as_doc_id);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : ue_create_reports
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  Wednesday 13 October 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
int   index
long  ll_lev1, ll_lev2, ll_lev3, ll_lev4
long tvi_hdl = 0
long ll_start, ll_used
//long ll_id   //maha 122106
any aa_any[]
string ls_report_name
string ls_qsta_val


ll_start = Cpu()
dw_1.dataobject = ''

if isvalid(INVO) then destroy INVO



INVO = create n_cst_npdb

invo.of_initialize( )
invo.OF_Start_npdb( invo.is_report , 0, 0,as_doc_id,u_dw)

ll_used = Cpu() - ll_start

tv_1.PictureHeight = 32
tv_1.PictureWidth = 32

///////////////////////////////////////////////////////////
// delete all existing tree view items
///////////////////////////////////////////////////////////

DO UNTIL tv_1.FindItem(RootTreeItem!, 0) = -1
         tv_1.DeleteItem(tvi_hdl)
LOOP

///////////////////////////////////////////////////////////
// Inser all new tree view itams
///////////////////////////////////////////////////////////

if upperbound(invo.ids_report_dws) > 0  then
	dw_1.dataobject = invo.ids_report_dws[1].dataobject //Start Code Change ----04.17.2008 #V8 maha
	invo.ids_report_dws[1].ShareData(dw_1)
	il_count = il_count + 1
	
   //ll_lev1 = tv_1.InsertItemLast(0,  invo.ids_report_dws[1].object.compute_9[1]  ,1)
	
	if  not f_validstr(invo.ids_report_dws[1].object.compute_9[1]) then 
	   ll_lev1 = tv_1.InsertItemLast(0,  invo.ids_report_dws[1].object.compute_9[1]  ,1)
	else
		ls_report_name = of_report_no_match(il_rpt_id)
		if ls_report_name = "PRAC" then//Start Code Change ----05.07.2008 #V8 maha
			ls_report_name = invo.ids_report_dws[1].object.compute_9[1] 
		end if

		ll_lev1 = tv_1.InsertItemLast(0,  ls_report_name,1)
		dw_1.object.t_6.text = ls_report_name
	end if 
	

	for  il_count = 1 to  upperbound(invo.ids_report_dws)   
		
		ls_report_name = invo.ids_report_dws[il_count].object.report_type_code[1]
		
		choose case ls_report_name
			case "C"
				ls_report_name=  'Adverse Action Report'
			case "J"
				ls_report_name=  'Judgment or Conviction Report'
			case "P"
				ls_report_name=  'Medical Malpractice Payment Report'
			//Start Code Change ----05.07.2008 #V8 maha - added legacy reports
			case "M"
				ls_report_name=  'Legacy Medical Malpractice Payment Report'
			case "A"
				ls_report_name=  'Legacy Adverse Action Report'
			//End Code Change---05.07.2008
		end choose
			
		if f_validstr(ls_report_name) then 
			ll_lev3 = tv_1.InsertItemlast(ll_lev1, ls_report_name, 3)
		end if 
	
		invo.ids_report_dws[il_count].Object.DataWindow.Print.DocumentName = invo.ids_report_dws[1].object.compute_9[1] + ls_report_name + string(il_count)
	next

	tv_1.ExpandItem(ll_lev1)
	tv_1.ExpandItem(ll_lev2)
	tv_1.ExpandItem(ll_lev3)
	st_1.TEXT =  invo.is_retreive_time + '~r~n' +  "Total Completion Time:" + STRING(ll_used/1000) + ' seconds'

else
	//messagebox(iw_parent_window.title , 'No reports found for this practitioner. ')
	//close(iw_parent_window)
end if

of_SetButtonEnabled() //Added by Evan 12.14.2011




end event

event pfc_print_all();/******************************************************************************************************************
**  [PUBLIC]   : event pfc_print_all( )
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

il_count = il_count + 1

for il_count = 1 to  upperbound(invo.ids_npdb_dws)  
	dw_1.dataobject = invo.ids_npdb_dws[il_count].dataobject 
	invo.ids_npdb_dws[il_count].ShareData(dw_1)
	dw_1.event dynamic pfc_print()
next

end event

event ue_retrieve_qrxs(long al_npdb_hdr_id, string as_rootlable);//////////////////////////////////////////////////////////////////////
// $<function> ue_retrieve_qrxs
// $<arguments>
//			long		al_npdb_hdr_id
//			string	as_rootlable
// $<returns> (None)
// $<description> Create report tree view (V10.1 - NPDB QRXS)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 12.16.2009
//////////////////////////////////////////////////////////////////////

long ll_Root
long ll_Handle
long i, ll_Count
TreeViewItem ltvi_Item
string ls_Data[] = {"AAR", "JOCR", "MMPR", "LMMPR", "LAAR"}
string ls_Label[] = {"Adverse Action Report", "Judgment or Conviction Report", "Medical Malpractice Payment Report", "Legacy Medical Malpractice Payment Report", "Legacy Adverse Action Report"}

// Do not create report tree view if npdb_hdr_id no changed
if al_npdb_hdr_id = il_npdb_hdr_id then
	tv_1.Post SetFocus()
	Return
end if
il_npdb_hdr_id = al_npdb_hdr_id

// Delete all existing tree view items
do until tv_1.FindItem(RootTreeItem!, 0) = -1
	tv_1.DeleteItem(0)
loop

// Create report tree view
ltvi_Item.Label = as_RootLable
ltvi_Item.Data = "ROOT!"
ltvi_Item.PictureIndex = 1
ltvi_Item.SelectedPictureIndex = 1
ltvi_Item.Children = true
ll_Root = tv_1.InsertItemLast(0, ltvi_item)

ll_Count = UpperBound(ls_Label)
for i = 1 to ll_Count
	ltvi_Item.Label = ls_Label[i]
	ltvi_Item.Data = ls_Data[i]
	ltvi_Item.PictureIndex = 2
	ltvi_Item.SelectedPictureIndex = 2
	ltvi_Item.Children = false
	tv_1.InsertItemLast(ll_Root, ltvi_Item)
next
tv_1.ExpandAll(ll_Root)

// Select Adverse Action Report item
ll_Handle = tv_1.FindItem(ChildTreeItem!, ll_Root)
tv_1.SelectItem(ll_Handle)
tv_1.Post SetFocus()
st_1.Hide()
of_SetButtonEnabled() //Added by Evan 12.14.2011
end event

public function string of_report_no_match (long al_id);////Start Code Change ---- 12.21.2006 #V7 maha - created to display message other than just 'no match found'


string ls_qsta_val
string ls_err_code
string ls_err_desc
string ls_report_name

//from the qrst find the no match/rejected value


select query_result_ind, err_cd into :ls_qsta_val, :ls_err_code from npdb_qsta where npdb_hdr_id = :al_id ;
//debugbreak()
if ls_qsta_val = "N" then
	ls_report_name=  'No Reports Found'
elseif ls_qsta_val = "R" then
	//select npdb_list_code_description  into :ls_err_desc from npdb_code_lookup where npdb_list = 'list_q' and npdb_list_code = :ls_err_code;
	ls_report_name =  "File Rejected - " + ls_err_code
else
	ls_report_name = "PRAC"// "No Reports Found"
end if

return ls_report_name
end function

public function integer of_set_id (long al_report);//Start Code Change ----04.18.2008 #V8 maha - added new
//function called from w_npdb_report tab itemchanged
il_rpt_id = al_report

return 1
end function

public function integer of_setbuttonenabled ();//====================================================================
// $<function> of_setbuttonenabled()
// $<arguments>
// $<returns> integer
// $<description> N/A
// $<add> (Appeon) evan 12.14.2011
//====================================================================

if dw_1.RowCount() = 0 then
	cb_prior.Enabled = false
	cb_next.Enabled = false
else
	if dw_1.GetRow() > 1 then
		cb_prior.Enabled = true
	else
		cb_prior.Enabled = false
	end if
	
	if dw_1.GetRow() < dw_1.RowCount() then
		cb_next.Enabled = true
	else
		cb_next.Enabled = false
	end if
end if

Return 1
end function

public function integer of_set_dddw (string as_report);//////////////////////////////////////////////////////////////////////
// $<Function> of_set_dddw
// $<arguments> N/A
// $<returns> NONE
// $<description>set dddw  (v12.2 modify NPDB qrxs report)
//////////////////////////////////////////////////////////////////////
// $<add> 09.12.2012 by Stephen
//////////////////////////////////////////////////////////////////////

datawindowchild ldwc_a, ldwc_b, ldwc_c, ldwc_d, ldwc_e
datawindowchild ldwc_f, ldwc_h, ldwc_i
datawindowchild ldwc_j, ldwc_k, ldwc_l, ldwc_m, ldwc_n
datawindowchild ldwc_o, ldwc_p1,ldwc_p2, ldwc_p3, ldwc_p4, ldwc_p5
datawindowchild ldwc_body

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 11.19.2012
//$<reason>NPDB report pagination is not working
if  upper(as_report) <> 'NOFOUND' then
	dw_1.getchild("dw_1", ldwc_body)
end if
//------------------- APPEON END -------------------

choose case upper(as_report)
	case 'AAR'
		ldwc_body.getchild("npdb_qrxs_contact_report_type", ldwc_a)
		ldwc_a.settransobject(sqlca)	
		ldwc_body.getchild("ind_oal_field", ldwc_b)
		ldwc_b.settransobject(sqlca)
		ldwc_body.getchild("ind_oal_specialty", ldwc_c)
		ldwc_c.settransobject(sqlca)
		ldwc_body.getchild("npdb_qrxs_individual_ooal_field1", ldwc_d)
		ldwc_d.settransobject(sqlca)
		ldwc_body.getchild("npdb_qrxs_individual_ooal_specialty1", ldwc_e)
		ldwc_e.settransobject(sqlca)
		ldwc_body.getchild("npdb_qrxs_individual_affi_nature_rela", ldwc_f)
		ldwc_f.settransobject(sqlca)
		ldwc_body.getchild("aar_action", ldwc_h)
		ldwc_h.settransobject(sqlca)
		
		ldwc_body.getchild("aar_class_code1", ldwc_i)
		ldwc_i.settransobject(sqlca)
		ldwc_body.getchild("aar_class_code2", ldwc_j)
		ldwc_j.settransobject(sqlca)
		ldwc_body.getchild("aar_class_code3", ldwc_k)
		ldwc_k.settransobject(sqlca)
		ldwc_body.getchild("aar_class_code4", ldwc_l)
		ldwc_l.settransobject(sqlca)
		ldwc_body.getchild("aar_class_code5", ldwc_m)
		ldwc_m.settransobject(sqlca)
		ldwc_body.getchild("npdb_qrxs_individual_org_type_code", ldwc_n)
		ldwc_n.settransobject(sqlca)
		ldwc_body.getchild("npdb_qrxs_status_error_code", ldwc_o)
		ldwc_o.settransobject(sqlca)
		
		ldwc_body.getchild("aar_basis_code1", ldwc_p1)
		ldwc_p1.settransobject(sqlca)
		ldwc_body.getchild("aar_basis_code2", ldwc_p2)
		ldwc_p2.settransobject(sqlca)
		ldwc_body.getchild("aar_basis_code3", ldwc_p3)
		ldwc_p3.settransobject(sqlca)
		ldwc_body.getchild("aar_basis_code4", ldwc_p4)
		ldwc_p4.settransobject(sqlca)
		ldwc_body.getchild("aar_basis_code5", ldwc_p5)
		ldwc_p5.settransobject(sqlca)
		
		gnv_appeondb.of_startqueue( )
			ldwc_a.retrieve('list_con')
			ldwc_b.retrieve('list_c')
			ldwc_c.retrieve('list_d')
			ldwc_d.retrieve('list_c')
			ldwc_e.retrieve('list_d')
			ldwc_f.retrieve('list_f')
			ldwc_h.retrieve('list_aar_act')
			ldwc_i.retrieve('list_h')
			ldwc_j.retrieve('list_h')
			ldwc_k.retrieve('list_h')
			ldwc_l.retrieve('list_h')
			ldwc_m.retrieve('list_h')
			ldwc_n.retrieve('list_jo_org')
			
			ldwc_o.retrieve('list_q')
			ldwc_p1.retrieve('list_k_1')
			ldwc_p2.retrieve('list_k_1')
			ldwc_p3.retrieve('list_k_1')
			ldwc_p4.retrieve('list_k_1')
			ldwc_p5.retrieve('list_k_1')
			
		gnv_appeondb.of_commitqueue( )	
		
	case 'JOCR'
		ldwc_body.getchild("npdb_qrxs_contact_report_type", ldwc_a)
		ldwc_a.settransobject(sqlca)
		ldwc_body.getchild("ind_oal_field", ldwc_b)
		ldwc_b.settransobject(sqlca)
		ldwc_body.getchild("ind_oal_specialty", ldwc_c)
		ldwc_c.settransobject(sqlca)
		ldwc_body.getchild("npdb_qrxs_individual_ooal_field1", ldwc_d)
		ldwc_d.settransobject(sqlca)
		ldwc_body.getchild("npdb_qrxs_individual_ooal_specialty1", ldwc_e)
		ldwc_e.settransobject(sqlca)
		ldwc_body.getchild("npdb_qrxs_individual_affi_nature_rela", ldwc_f)
		ldwc_f.settransobject(sqlca)
		ldwc_body.getchild("jocr_action", ldwc_h)
		ldwc_h.settransobject(sqlca)
		ldwc_body.getchild("jocr_act_omission_code1", ldwc_i)
		ldwc_i.settransobject(sqlca)
		ldwc_body.getchild("jocr_act_omission_code2", ldwc_j)
		ldwc_j.settransobject(sqlca)
		ldwc_body.getchild("jocr_act_omission_code3", ldwc_k)
		ldwc_k.settransobject(sqlca)
		ldwc_body.getchild("jocr_act_omission_code4", ldwc_l)
		ldwc_l.settransobject(sqlca)
		ldwc_body.getchild("jocr_act_omission_code5", ldwc_m)
		ldwc_m.settransobject(sqlca)
		ldwc_body.getchild("npdb_qrxs_individual_org_type_code", ldwc_n)
		ldwc_n.settransobject(sqlca)
		ldwc_body.getchild("npdb_qrxs_status_error_code", ldwc_o)
		ldwc_o.settransobject(sqlca)
		
		gnv_appeondb.of_startqueue( )
			ldwc_a.retrieve('list_con')
			ldwc_b.retrieve('list_c')
			ldwc_c.retrieve('list_d')
			ldwc_d.retrieve('list_c')
			ldwc_e.retrieve('list_d')
			ldwc_f.retrieve('list_f')
			ldwc_h.retrieve('list_P')
			ldwc_i.retrieve('list_O')
			ldwc_j.retrieve('list_O')
			ldwc_k.retrieve('list_O')
			ldwc_l.retrieve('list_O')
			ldwc_m.retrieve('list_O')
			ldwc_n.retrieve('list_jo_org')
			ldwc_o.retrieve('list_q')
		gnv_appeondb.of_commitqueue( )	
	case 'MMPR'
		ldwc_body.getchild("npdb_qrxs_contact_report_type", ldwc_a)
		ldwc_a.settransobject(sqlca)
		ldwc_body.getchild("ind_oal_field", ldwc_b)
		ldwc_b.settransobject(sqlca)
		ldwc_body.getchild("ind_oal_specialty", ldwc_c)
		ldwc_c.settransobject(sqlca)
		ldwc_body.getchild("npdb_qrxs_individual_ooal_field1", ldwc_d)
		ldwc_d.settransobject(sqlca)
		ldwc_body.getchild("npdb_qrxs_individual_ooal_specialty1", ldwc_e)
		ldwc_e.settransobject(sqlca)
		ldwc_body.getchild("mmpr_nature_allegation", ldwc_f)
		ldwc_f.settransobject(sqlca)
		ldwc_body.getchild("mmpr_sa_code1", ldwc_h)
		ldwc_h.settransobject(sqlca)
		ldwc_body.getchild("mmpr_sa_code2", ldwc_j)
		ldwc_j.settransobject(sqlca)
		ldwc_body.getchild("mmpr_outcome", ldwc_i)
		ldwc_i.settransobject(sqlca)
		ldwc_body.getchild("npdb_qrxs_status_error_code", ldwc_o)
		ldwc_o.settransobject(sqlca)
		
		gnv_appeondb.of_startqueue( )
			ldwc_a.retrieve('list_con')
			ldwc_b.retrieve('list_c')
			ldwc_c.retrieve('list_d')
			ldwc_d.retrieve('list_c')
			ldwc_e.retrieve('list_d')
			ldwc_f.retrieve('list_U')
			ldwc_h.retrieve('list_V')
			ldwc_j.retrieve('list_V')
			ldwc_i.retrieve('list_w')
			ldwc_o.retrieve('list_q')
		gnv_appeondb.of_commitqueue( )	
	case 'LMMPR'
		ldwc_body.getchild("npdb_qrxs_contact_report_type", ldwc_a)
		ldwc_a.settransobject(sqlca)
		ldwc_body.getchild("ind_oal_field", ldwc_b)
		ldwc_b.settransobject(sqlca)
		ldwc_body.getchild("ind_oal_specialty", ldwc_c)
		ldwc_c.settransobject(sqlca)
		ldwc_body.getchild("npdb_qrxs_individual_ooal_field1", ldwc_d)
		ldwc_d.settransobject(sqlca)
		ldwc_body.getchild("npdb_qrxs_individual_ooal_specialty1", ldwc_e)
		ldwc_e.settransobject(sqlca)
		ldwc_body.getchild("lmmpr_aoo_code1 ", ldwc_h)
		ldwc_h.settransobject(sqlca)
		ldwc_body.getchild("lmmpr_aoo_code2 ", ldwc_j)
		ldwc_j.settransobject(sqlca)
		ldwc_body.getchild("npdb_qrxs_status_error_code", ldwc_o)
		ldwc_o.settransobject(sqlca)
		
		gnv_appeondb.of_startqueue( )
			ldwc_a.retrieve('list_con')
			ldwc_b.retrieve('list_c')
			ldwc_c.retrieve('list_d')
			ldwc_d.retrieve('list_c')
			ldwc_e.retrieve('list_d')
			ldwc_h.retrieve('list_V')
			ldwc_j.retrieve('list_V')
			ldwc_o.retrieve('list_q')
		gnv_appeondb.of_commitqueue( )	
		
	case 'LAAR'
		ldwc_body.getchild("npdb_qrxs_contact_report_type", ldwc_a)
		ldwc_a.settransobject(sqlca)
		ldwc_body.getchild("ind_oal_field", ldwc_b)
		ldwc_b.settransobject(sqlca)
		ldwc_body.getchild("ind_oal_specialty", ldwc_c)
		ldwc_c.settransobject(sqlca)
		ldwc_body.getchild("npdb_qrxs_individual_ooal_field1", ldwc_d)
		ldwc_d.settransobject(sqlca)
		ldwc_body.getchild("npdb_qrxs_individual_ooal_specialty1", ldwc_e)
		ldwc_e.settransobject(sqlca)
		ldwc_body.getchild("laar_classification", ldwc_f)
		ldwc_f.settransobject(sqlca)
		ldwc_body.getchild("npdb_qrxs_status_error_code", ldwc_o)
		ldwc_o.settransobject(sqlca)
		
		gnv_appeondb.of_startqueue( )
			ldwc_a.retrieve('list_con')
			ldwc_b.retrieve('list_c')
			ldwc_c.retrieve('list_d')
			ldwc_d.retrieve('list_c')
			ldwc_e.retrieve('list_d')
			ldwc_f.retrieve('list_h')
			ldwc_o.retrieve('list_q')
		gnv_appeondb.of_commitqueue( )	
		
	case 'NOFOUND'
		dw_1.getchild("npdb_qrxs_contact_report_type", ldwc_a)
		ldwc_a.settransobject(sqlca)
		dw_1.getchild("ind_oal_field", ldwc_b)
		ldwc_b.settransobject(sqlca)
		dw_1.getchild("ind_oal_specialty", ldwc_c)
		ldwc_c.settransobject(sqlca)
		dw_1.getchild("npdb_qrxs_individual_ooal_field1", ldwc_d)
		ldwc_d.settransobject(sqlca)
		dw_1.getchild("npdb_qrxs_individual_ooal_specialty1", ldwc_e)
		ldwc_e.settransobject(sqlca)
		dw_1.getchild("npdb_qrxs_individual_org_type_code", ldwc_n)
		ldwc_n.settransobject(sqlca)
		
		gnv_appeondb.of_startqueue( )
			ldwc_a.retrieve('list_con')
			ldwc_b.retrieve('list_c')
			ldwc_c.retrieve('list_d')
			ldwc_d.retrieve('list_c')
			ldwc_e.retrieve('list_d')
			ldwc_n.retrieve('list_jo_org')
		gnv_appeondb.of_commitqueue( )	
			
end choose

return 1
		
		
end function

public function integer of_clearout_slideup (datawindowchild adwc_1);//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// $<function> of_clearout_slideup
// $<arguments>
//				datawindowchild adwc_1
// $<returns> integer
// $<description> Remove the slide up property for all fields for a Web version issue.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// $<add> Alfee 11.19.2012
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

String ls_objects, ls_obj, ls_temp

ls_objects=adwc_1.Describe("datawindow.objects")+'~t'
ls_obj=LeftA(ls_objects,PosA(ls_objects,'~t') - 1)

DO WHILE LenA(ls_obj)>0	
	ls_temp = adwc_1.Modify(ls_obj + ".SlideUp = 'no'") 			

	ls_objects=MidA(ls_objects,PosA(ls_objects,'~t')+LenA('~t'))
	ls_obj=LeftA(ls_objects,PosA(ls_objects,'~t') - 1)
LOOP

RETURN 1
end function

public function integer of_adjust_field_height (ref datawindowchild adwc_1, string as_filed_name, integer ai_row_height);//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// $<function> of_adjust_field_height
// $<arguments>
//				datawindowchild adwc_1 - the current datawindowchild
//				string as_field_name - the field name
//				integer ai_row_height - the standard row height 
// $<returns> integer
// $<description> Adjust height for the sepcified field and the Y position for other fields accordingly.
// $<description> For the slide up issue in Web version.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// $<add> Alfee 11.19.2012
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

Long ll_height, ll_height_ori, ll_height_add, ll_y_cur, ll_y, ll_width
Long ll_rowcnt, ll_cnt, ll_maxcnt, i
String ls_text, ls_temp, ls_val
String ls_objects, ls_obj, ls_objtype, ls_visible, ls_band

ll_rowcnt = adwc_1.RowCount ()
IF ll_rowcnt < 1 THEN RETURN 0

//Get and adjust height for the specified field
ll_y_cur = Long(adwc_1.Describe(as_filed_name + ".y"))
ll_width = Long(adwc_1.Describe(as_filed_name+".width"))
mle_1.Width = ll_width

FOR i = 1 TO ll_rowcnt
	ls_val = RightTrim(adwc_1.GetItemString(i, as_filed_name))
	IF IsNull(ls_val) THEN ls_val = ""
	mle_1.Text = ls_val
	ll_cnt = mle_1.LineCount() 
	IF ll_cnt > ll_maxcnt THEN ll_maxcnt = ll_cnt
NEXT

ll_cnt = ll_maxcnt
IF isnull(ll_cnt) or ll_cnt < 1 THEN ll_cnt = 1
ll_height = ll_cnt * ai_row_height
ll_height_ori = Long(adwc_1.Describe(as_filed_name + ".height"))
ll_height_add = ll_height - ll_height_ori
IF ll_height_add <= 0 and Lower(as_filed_name)="npdb_qrxs_contact_subject_statement" THEN 
	RETURN 0 //Skip shrinking for the statement field
END IF
ls_temp = adwc_1.ModIfy(as_filed_name + ".height = '"+string(ll_height)+"'") 

//Adjust the Y position for other fields
IF ll_cnt < 2 THEN RETURN 1

ls_objects=adwc_1.Describe("datawindow.objects")+'~t'
ls_obj=LeftA(ls_objects,PosA(ls_objects,'~t') - 1)

DO WHILE LenA(ls_obj)>0	
	//Get properties
	ls_visible=adwc_1.Describe(ls_obj+".visible")
	ls_band=adwc_1.Describe(ls_obj+".band") 
	ls_objtype=adwc_1.Describe(ls_obj+".type")

	IF ls_objtype='line' THEN 
		ll_y=long(adwc_1.Describe(ls_obj+".y1"))
	ELSE
		ll_y=long(adwc_1.Describe(ls_obj+".y"))
	END IF
	IF ls_visible = '0' OR Long(ls_band) <> 0 OR ll_y <= ll_y_cur THEN 
		ls_objects=MidA(ls_objects,PosA(ls_objects,'~t')+LenA('~t'))
		ls_obj=LeftA(ls_objects,PosA(ls_objects,'~t') - 1)
		CONTINUE
	END IF
	
	//Adjust the Y position
	IF ls_objtype='line' THEN 
		adwc_1.modIFy(ls_obj+ ".y1 = " + String(ll_y + ll_height_add))		
		adwc_1.modIFy(ls_obj+ ".y2 = " + String(ll_y + ll_height_add))				
	ELSE
		adwc_1.modIFy(ls_obj+ ".y = " + String(ll_y + ll_height_add))		
	END IF
			
	ls_objects=MidA(ls_objects,PosA(ls_objects,'~t')+LenA('~t'))
	ls_obj=LeftA(ls_objects,PosA(ls_objects,'~t') - 1)
LOOP

RETURN 1
end function

on uo_npdb_reports.create
int iCurrent
call super::create
this.cb_next=create cb_next
this.cb_prior=create cb_prior
this.cb_codes=create cb_codes
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_1=create dw_1
this.tv_1=create tv_1
this.mle_1=create mle_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_next
this.Control[iCurrent+2]=this.cb_prior
this.Control[iCurrent+3]=this.cb_codes
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.tv_1
this.Control[iCurrent+9]=this.mle_1
end on

on uo_npdb_reports.destroy
call super::destroy
destroy(this.cb_next)
destroy(this.cb_prior)
destroy(this.cb_codes)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.tv_1)
destroy(this.mle_1)
end on

event constructor;call super::constructor;il_Interface = of_get_app_setting("set_8","I") //Add by Evan 12.16.2009 (V10.1 - NPDB QRXS)
iw_parent_window = this.GetParent()


end event

type cb_next from commandbutton within uo_npdb_reports
integer x = 1870
integer y = 1892
integer width = 261
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Next >"
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 12.14.2011
//====================================================================

dw_1.ScrollNextRow()
of_SetButtonEnabled()
end event

type cb_prior from commandbutton within uo_npdb_reports
integer x = 1595
integer y = 1892
integer width = 261
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "< Prior"
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 12.14.2011
//====================================================================

dw_1.ScrollPriorRow()
of_SetButtonEnabled()
end event

type cb_codes from commandbutton within uo_npdb_reports
integer x = 2505
integer y = 1892
integer width = 421
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Rejection codes"
end type

event clicked;open(w_npdb_reject_codes)
end event

type st_2 from u_st_splitbar within uo_npdb_reports
integer x = 695
integer width = 37
integer height = 1868
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;n_cst_color lnvo 

this.of_Register(tv_1, LEFT)
this.of_Register(dw_1, RIGHT)
end event

type st_1 from u_st within uo_npdb_reports
integer x = 55
integer y = 1884
integer width = 1381
integer height = 124
long backcolor = 33551856
end type

type cb_1 from u_cb within uo_npdb_reports
integer x = 2944
integer y = 1892
integer width = 430
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Output Options"
end type

event clicked;call super::clicked;


m_npdb_options NewMenu 
NewMenu = CREATE m_npdb_options

NewMenu.of_setparent( dw_1)
NewMenu.m_options.PopMenu(parent.x + this.x, parent.y + this.y - 190)



end event

type dw_1 from u_dw within uo_npdb_reports
event ue_mail_current ( )
event pfc_print_all ( )
event type integer pfc_after_retrieve ( )
integer x = 731
integer width = 3575
integer height = 1860
integer taborder = 10
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ib_isupdateable = false
end type

event ue_mail_current();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : EVENT //
//==================================================================================================================
//  Purpose   	: Mail the curennt reports
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

string ls_prac_name
string ls_report_name

if this.GetRow() < 1 then Return //Add by Evan on 11.23.2010

//------------ APPEON BEGIN ------------
//$<Add> 12.29.2009 By: Evan
//$<Reason> V10.1 - NPDB QRXS
if il_Interface = QRXS_INTERFACE then
	ls_prac_name = Trim(dw_1.object.prac_name[1])
	ls_report_name = Trim(dw_1.object.t_title.text)
	dw_1.Object.DataWindow.Print.DocumentName = ls_prac_name + " - " + ls_report_name
	Event ue_save_pdf_for_mailing()
	if  gi_email_type = 1 then //Start Code Change ----12.11.2012 #V12 maha
		Super::Event ue_mail_bak("NPDB Reports for : " + ls_prac_name, "")
	else
		Super::Event ue_mail("NPDB Reports for : " + ls_prac_name, "")
	end if
	Return
end if
//------------ APPEON END --------------

//SetCapture(Handle(this)) // keeps the hourglass solid
constant string ADVERSE_ACTION_REPORT = 'C'
constant string JUDJEMENT_OR_CONVICTION_REPORT = 'J'
constant string MEDICAL_MALPRACTICE_PAYMENT_REPORT = 'P'
constant string LEGACY_ADVERSE_ACTION_REPORT = 'A'
constant string LEGACY_MEDICAL_MALPRACTICE_PAYMENT_REPORT = 'M'

choose case parent.dw_1.object.report_type_code[1]
	case ADVERSE_ACTION_REPORT
		ls_report_name = WordCap ( (Lower ('ADVERSE ACTION REPORT')))
	case JUDJEMENT_OR_CONVICTION_REPORT
		ls_report_name =  WordCap (  lower('JUDJEMENT OR CONVICTION REPORT'))
	case MEDICAL_MALPRACTICE_PAYMENT_REPORT
		ls_report_name=  WordCap (  lower('MEDICAL MALPRACTICE PAYMENT REPORT'))
	case LEGACY_MEDICAL_MALPRACTICE_PAYMENT_REPORT
		ls_report_name=  WordCap (  lower('LEGACY MEDICAL MALPRACTICE PAYMENT REPORT'))
	case LEGACY_ADVERSE_ACTION_REPORT
		ls_report_name=  WordCap (  lower(' LEGACY ADVERSE ACTION REPORT'))
end choose

parent.dw_1.Object.DataWindow.Print.DocumentName = trim(parent.dw_1.object.compute_9[1])	+ ' - ' +ls_report_name
Super::EVENT ue_save_pdf_for_mailing( )

//releasecapture( )
//Start Code Change ----10.09.2008 #V85 maha -  readded option to use outlook email
if  gi_email_type = 1 then //Start Code Change ----12.11.2012 #V12 maha
	Super::EVENT ue_mail_bak('NPDB Reports for : ' + trim(parent.dw_1.object.compute_9[1]),'' )
else
	Super::EVENT ue_mail('NPDB Reports for : ' + trim(parent.dw_1.object.compute_9[1]),'' )
end if
//End Code Change---10.09.2008
end event

event pfc_print_all();LONG i, LL_COUNT
string ls_ReportDW
datawindowchild ldwc_1

choose case il_Interface
	case ITP_INTERFACE
		FOR ll_COUNT = 1 TO upperbound(invo.ids_report_dws) 
			dw_1.dataobject = invo.ids_report_dws[LL_COUNT].dataobject 
			invo.ids_report_dws[LL_COUNT].ShareData(THIS)
			event pfc_print( )
		NEXT
	case QRXS_INTERFACE //Add by Evan 12.29.2009 (V10.1 - NPDB QRXS)
		ls_ReportDW = dw_1.DataObject
		for i = 1 to UpperBound(is_qrxs_report_dw)
			dw_1.DataObject = is_qrxs_report_dw[i]
			dw_1.SetTransObject(SQLCA)
			//---------Begin Modified by (Appeon)Stephen 04.03.2014 for Bug 3990 : NPDB QRXS Error--------
			//if dw_1.Retrieve(il_npdb_hdr_id) > 0 then
			dw_1.retrieve(il_npdb_hdr_id)
			dw_1.getchild("dw_1", ldwc_1)
			if ldwc_1.rowcount()< 1 then
				dw_1.DataObject = "d_npdb_report_qrxs_no_report_found"
				dw_1.SetTransObject(SQLCA)
				dw_1.Retrieve(il_npdb_hdr_id)
			end if	
			if dw_1.rowcount() > 0 then
			//---------End Modfiied ------------------------------------------------------		
				Event pfc_print()
			end if
		next
		dw_1.DataObject = ls_ReportDW
		dw_1.SetTransObject(SQLCA)
		dw_1.Retrieve(il_npdb_hdr_id)
end choose
end event

event type integer pfc_after_retrieve();//Adjust height for description fields for the slide up issue in Web version - Alfee 11.19.2012

Integer li_rtn, i
String ls_dataobject
String ls_desc_fields []
DataWindowChild dwc_1

IF appeongetclienttype() <> 'WEB' THEN RETURN 0

ls_dataobject = Lower(This.DataObject)
IF ls_dataobject = "d_npdb_report_qrxs_no_report_found" THEN RETURN 0

IF This.GetChild("dw_1", dwc_1) = -1 THEN
	MessageBox("Error", "There is no a child report in the '" + ls_dataobject + "'!")
	RETURN 0
END IF
dwc_1.SetTransObject(SQLCA)

//Clear out the slide up property
li_rtn = of_clearout_slideup (dwc_1)

//Adjust the height for specified fields
CHOOSE CASE Lower(ls_dataobject)
	CASE "d_npdb_report_qrxs_aar" 
		ls_desc_fields [UpperBound(ls_desc_fields) + 1]= "aar_narrative"
		ls_desc_fields [UpperBound(ls_desc_fields) + 1]= "npdb_qrxs_contact_subject_statement"		
	CASE "d_npdb_report_qrxs_laar" 		
		ls_desc_fields [UpperBound(ls_desc_fields) + 1]= "laar_narrative"
		ls_desc_fields [UpperBound(ls_desc_fields) + 1]= "npdb_qrxs_contact_subject_statement"		
	CASE	"d_npdb_report_qrxs_jocr"
		ls_desc_fields [UpperBound(ls_desc_fields) + 1]= "jocr_narrative"
		ls_desc_fields [UpperBound(ls_desc_fields) + 1]= "npdb_qrxs_contact_subject_statement"						
	CASE	"d_npdb_report_qrxs_mmpr"
		ls_desc_fields [UpperBound(ls_desc_fields) + 1]= "mmpr_judgment_or_settlement_desc"
		ls_desc_fields [UpperBound(ls_desc_fields) + 1]= "mmpr_medical_condition_desc"		
		ls_desc_fields [UpperBound(ls_desc_fields) + 1]= "mmpr_procedure_desc"
		ls_desc_fields [UpperBound(ls_desc_fields) + 1]= "mmpr_allegation_desc"		
		ls_desc_fields [UpperBound(ls_desc_fields) + 1]= "npdb_qrxs_contact_subject_statement"
	CASE "d_npdb_report_qrxs_lmmpr"		
		ls_desc_fields [UpperBound(ls_desc_fields) + 1]= "lmmpr_act_or_omission_desc"
		ls_desc_fields [UpperBound(ls_desc_fields) + 1]= "lmmpr_judgment_or_settlement_desc"
		ls_desc_fields [UpperBound(ls_desc_fields) + 1]= "npdb_qrxs_contact_subject_statement"		
	CASE ELSE
		RETURN 0
END CHOOSE

FOR i = 1 to UpperBound (ls_desc_fields)
	li_rtn = of_adjust_field_height (dwc_1, ls_desc_fields[i], 60)
NEXT

RETURN 0

end event

event ue_mail;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : EVENT ue_mail
//==================================================================================================================
//  Purpose   	: Mail the reports
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  Wednesday 13 October 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long i
string ls_prac_name
string ls_report_name
string ls_ReportDW

if this.GetRow() < 1 then Return //Add by Evan on 11.23.2010

//------------ APPEON BEGIN ------------
//$<Add> 12.29.2009 By: Evan
//$<Reason> V10.1 - NPDB QRXS
if il_Interface = QRXS_INTERFACE then
	ls_ReportDW = dw_1.DataObject
	for i = 1 to UpperBound(is_qrxs_report_dw)
		dw_1.DataObject = is_qrxs_report_dw[i]
		dw_1.SetTransObject(SQLCA)
		if dw_1.Retrieve(il_npdb_hdr_id) > 0 then
			ls_prac_name = Trim(dw_1.object.prac_name[1])
			ls_report_name = Trim(dw_1.object.t_title.text)
			ls_report_name = ls_prac_name + " - " + ls_report_name + "  " + String(i) + " of " + String(UpperBound(is_qrxs_report_dw))
			dw_1.Object.DataWindow.Print.DocumentName = ls_report_name
			//
			Event ue_save_pdf_for_mailing()
		end if
	next
	Super::Event ue_mail("NPDB Reports for : " + ls_prac_name, "")
	dw_1.DataObject = ls_ReportDW
	dw_1.SetTransObject(SQLCA)
	dw_1.Retrieve(il_npdb_hdr_id)
	Return
end if
//------------ APPEON END --------------

//SetCapture(Handle(this)) // keeps the hourglass solid
constant string ADVERSE_ACTION_REPORT = 'C'
constant string JUDJEMENT_OR_CONVICTION_REPORT = 'J'
constant string MEDICAL_MALPRACTICE_PAYMENT_REPORT = 'P'
constant string LEGACY_ADVERSE_ACTION_REPORT = 'A'
constant string LEGACY_MEDICAL_MALPRACTICE_REPORT = 'M'
long ll_count

for il_count = 1 to upperbound(invo.ids_report_dws)   
	parent.dw_1.dataobject = invo.ids_report_dws[il_count].dataobject 
	invo.ids_report_dws[il_count].ShareData(parent.dw_1)
	
	choose case parent.dw_1.object.report_type_code[1]
		case ADVERSE_ACTION_REPORT
			ls_report_name = WordCap ( (Lower ('ADVERSE ACTION REPORT')))
		case JUDJEMENT_OR_CONVICTION_REPORT
			ls_report_name =  WordCap (  lower('JUDJEMENT OR CONVICTION REPORT'))
			case MEDICAL_MALPRACTICE_PAYMENT_REPORT
			ls_report_name=  WordCap (  lower('MEDICAL MALPRACTICE PAYMENT REPORT'))
		end choose
	
	
	parent.dw_1.Object.DataWindow.Print.DocumentName = trim(parent.dw_1.object.compute_9[1]) +' - ' + ls_report_name + '  ' +string(il_count) +  ' of '+ string (upperbound(invo.ids_report_dws))
	event ue_save_pdf_for_mailing( )
next


Super::EVENT ue_mail('NPDB Reports for : ' + wordcap(lower(trim(parent.dw_1.object.compute_9[1])))  ,'' )

//releasecapture( )

end event

event retrieveend;call super::retrieveend;//Adjust height for description fields for the slide up issue in Web version - Alfee 11.19.2012

IF appeongetclienttype() <> 'WEB' THEN RETURN 0

This.Event Post pfc_after_retrieve()

RETURN 0


end event

type tv_1 from u_tv within uo_npdb_reports
integer width = 695
integer height = 1860
integer taborder = 10
long backcolor = 16777215
borderstyle borderstyle = stylebox!
string picturename[] = {"Picture!","RunReport!","RunReport!"}
end type

event clicked;call super::clicked;integer li_index

//------------ APPEON BEGIN ------------
//$<Add> 12.16.2009 By: Evan
//$<Reason> V10.1 - NPDB QRXS
if il_Interface <> ITP_INTERFACE then
	Return 0
end if
//------------ APPEON END --------------

if li_index > 0  then
	parent.dw_1.dataobject = invo.ids_report_dws[li_index].dataobject 
	invo.ids_report_dws[li_index].ShareData(parent.dw_1)
   //parent.dw_1.Object.DataWindow.Zoom = 80
   // parent.dw_1.Object.DataWindow.Print.Preview = 'no'
end if

of_SetButtonEnabled() //Added by Evan 12.14.2011
end event

event selectionchanged;call super::selectionchanged;//////////////////////////////////////////////////////////////////////
// $<function> selectionchanged
// $<arguments>
//		long	oldhandle
//		long	newhandle
// $<returns> long
// $<description> V10.1 - NPDB QRXS
//////////////////////////////////////////////////////////////////////
// $<add> Evan 12.16.2009
//////////////////////////////////////////////////////////////////////

string ls_Report
string ls_label //maha 10.17.2014
string ls_DataObject
integer li_ret
datawindowchild ldwc_1

SetPointer(HourGlass!) //alfee 11.19.2012
choose case il_Interface
	case QRXS_INTERFACE
		this.GetItem(NewHandle, itvi_CurrItem)
		ls_Report = String(itvi_CurrItem.Data)
		ls_label = String(itvi_CurrItem.label)  //Start Code Change ----10.17.2014 #V14.2 maha
		if ls_Report = "ROOT!" then Return 0
		ls_DataObject = "d_npdb_report_qrxs_" + Lower(ls_Report)
		
		dw_1.SetRedraw(false)
		dw_1.DataObject = ls_DataObject
		dw_1.SetTransObject(SQLCA)		
		
		dw_1.Retrieve(il_npdb_hdr_id)		
		li_ret = of_set_dddw(ls_Report) // add by stephen  09.12.2012 -set dddw  (v12.2 modify NPDB qrxs report)
		dw_1.getchild("dw_1", ldwc_1)
		if  ldwc_1.rowcount()< 1 then
			dw_1.DataObject = "d_npdb_report_qrxs_no_report_found" 
			dw_1.SetTransObject(SQLCA)
			li_ret = of_set_dddw('Nofound') //add by stephen  09.12.2012 -set dddw  (v12.2 modify NPDB qrxs report)
			dw_1.Retrieve(il_npdb_hdr_id)
			dw_1.object.t_title.text = ls_label   //Start Code Change ----10.17.2014 #V14.2 maha
		end if
		dw_1.SetRedraw(true)
		of_SetButtonEnabled() //Added by Evan 12.14.2011
end choose
dw_1.object.datawindow.print.preview="yes"  //add by stephen 10.15.2012 -preview style (v12.2 modify NPDB qrxs report)
end event

type mle_1 from multilineedit within uo_npdb_reports
boolean visible = false
integer x = 722
integer width = 3493
integer height = 1500
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

event constructor;this.height = 2500 //alfee 11.19.2012
end event

