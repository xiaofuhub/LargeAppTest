$PBExportHeader$u_cst_gadget_recent_prac.sru
forward
global type u_cst_gadget_recent_prac from u_cst_gadget
end type
end forward

global type u_cst_gadget_recent_prac from u_cst_gadget
string tag = "u_gadget_7.Recent Practitioner"
event ue_refresh_data ( )
end type
global u_cst_gadget_recent_prac u_cst_gadget_recent_prac

event ue_refresh_data();//
end event

on u_cst_gadget_recent_prac.create
call super::create
end on

on u_cst_gadget_recent_prac.destroy
call super::destroy
end on

event ue_run;call super::ue_run;Long ll_data_id
str_dashboard str_para
w_prac_data_1 lw_prac  // maha 04.27.2012
w_prac_data_2 lw_prac1  //maha 06.18.2013
w_prac_data_intelliapp_2 lw_prac2 //maha 06.18.2013
w_prac_data_sk_2 lw_prac3 //maha 06.18.2013

If al_row <= 0 Then Return 1

ll_data_id = dw_content.GetItemNumber(al_row,'dashboard_gadgets_recent_data_id')
str_para.data_id = ll_data_id
str_para.data_id = dw_content.Object.pd_basic_prac_id[al_row]
str_para.data_name = dw_content.Object.facility_facility_name[al_row]
str_para.data_ext_id = dw_content.Object.dashboard_gadgets_recent_facility_id[al_row]
str_para.color = gl_bg_color2   //16773365 //Start Code Change ----10.04.2012 #V12 maha - for 12.3 //Start Code Change ----03.17.2016 #V15 maha - changed to variable

//Start Code Change ----06.18.2013 #V14 maha -rewrote using separate variables
//Start Code Change ----04.27.2012 #V12 maha - rewrote based on window variable
IF gs_cust_type = "I" THEN
	IF gb_sk_ver = False THEN	//app
		OpenSheetWithParm(lw_prac2 ,str_para,w_mdi,4,Original!)
		lw_prac = lw_prac2
	ELSEIF gb_sk_ver = true  THEN//sk
		OpenSheetWithParm(lw_prac3 ,str_para,w_mdi,4,Original!)
		lw_prac = lw_prac3
	END IF
	IF gi_prac_tab = 1 THEN
		OpenSheetWithParm( lw_prac3 ,str_para,w_mdi,4,Original!)
		lw_prac = lw_prac3 //Bug 3375 - Alfee 01.08.2013 
	end if
ELSE //cred
	OpenSheetWithParm(lw_prac1 ,str_para,w_mdi,4,Original!)
	lw_prac = lw_prac1  //12.04.2012  maha - changed from w_prac_data_1
END IF
//Start Code Change ----12.04.2012 #V12 maha - chasnged to always open a new window
//IF IsValid(lw_prac)  THEN
//	lw_prac.of_dashboard(str_para.data_name,str_para.data_id,str_para.data_ext_id)
//ELSE	
//	OpenSheetWithParm(lw_prac,str_para,w_mdi,4,Original!)
//Start Code Change ----06.18.2013
	w_mdi.iw_prac_window = lw_prac //add Michael 05.07.2012 System Error:Null object reference
//END IF

return 1
//End Code Change ----04.27.2012

//old code prior to 4-2012
//IF gs_cust_type = "I" THEN
//	//--------Begin Modified by  Nova 09.06.2010-----------------------
//	//V10.5 SK Section D - Menu and Setup
//	//	 IF IsValid(w_prac_data_intelliapp)  THEN
//	//		w_prac_data_intelliapp.of_dashboard(str_para.data_name,str_para.data_id,str_para.data_ext_id)
//	//	 ELSE
//	//		OpenSheetWithParm(w_prac_data_intelliapp,str_para,w_mdi,4,Original!)
//	//	 END IF
//	IF gb_sk_ver = False THEN	
//		 IF IsValid(w_prac_data_intelliapp)  THEN
//			w_prac_data_intelliapp.of_dashboard(str_para.data_name,str_para.data_id,str_para.data_ext_id)
//		 ELSE
//			OpenSheetWithParm(w_prac_data_intelliapp,str_para,w_mdi,4,Original!)
//		 END IF
//	ELSEIF gb_sk_ver = true  THEN//sk
//		 IF IsValid(w_prac_data_sk)  THEN
//			w_prac_data_sk.of_dashboard(str_para.data_name,str_para.data_id,str_para.data_ext_id)
//		 ELSE
//			OpenSheetWithParm(w_prac_data_sk,str_para,w_mdi,4,Original!)
//		 END IF
//   end if
//	 //--------End Modified --------------------------------------------
//ELSE
//	 IF IsValid(w_prac_data_1)  THEN
//		w_prac_data_1.of_dashboard(str_para.data_name,str_para.data_id,str_para.data_ext_id)
//	 ELSE
//		OpenSheetWithParm(w_prac_data_1,str_para,w_mdi,4,Original!)
//	 END IF
//END IF
//
//Return 1
end event

type dw_content from u_cst_gadget`dw_content within u_cst_gadget_recent_prac
string dataobject = "d_dashb_gadget_recent_prac"
end type

type ln_split from u_cst_gadget`ln_split within u_cst_gadget_recent_prac
end type

type st_1 from u_cst_gadget`st_1 within u_cst_gadget_recent_prac
end type

type st_title from u_cst_gadget`st_title within u_cst_gadget_recent_prac
end type

type pb_close from u_cst_gadget`pb_close within u_cst_gadget_recent_prac
end type

type pb_max from u_cst_gadget`pb_max within u_cst_gadget_recent_prac
end type

type pb_edit from u_cst_gadget`pb_edit within u_cst_gadget_recent_prac
end type

