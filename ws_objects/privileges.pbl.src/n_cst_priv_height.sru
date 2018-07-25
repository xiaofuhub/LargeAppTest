$PBExportHeader$n_cst_priv_height.sru
$PBExportComments$set priv_template_excl_cont_text,priv_template_header_text Height add Michael 05.28.2012
forward
global type n_cst_priv_height from nonvisualobject
end type
end forward

global type n_cst_priv_height from nonvisualobject
end type
global n_cst_priv_height n_cst_priv_height

forward prototypes
public function integer of_set_height (datawindow adw_report, multilineedit amle_text)
public function string of_get_mle_linetext (string as_mle_text, long al_lines)
public function integer of_set_height (datastore ads_report, multilineedit amle_text)
end prototypes

public function integer of_set_height (datawindow adw_report, multilineedit amle_text);//////////////////////////////////////////////////////////////////////
// $<function> of_set_height
// $<arguments>
//              adw_report
//					 amle_text
// $<returns>  
// $<description> Bug id 2935-set DW heander height 
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Michael 05.28.2012
//////////////////////////////////////////////////////////////////////
string ls_text
string ls_y	//long.zhang 03.19.2013
long  ll_cnt, ll_height, ll_width 
CONSTANT long ll_lines = 10000
long ll_i  
string temp
datawindowchild ldwc_1

adw_report.setredraw(false)
//set priv_template_header_text height
if adw_report.dataobject  = "d_form_clin_priv_request_master_inova" or adw_report.dataobject  = "d_form_pract_priv_request_f3"  or adw_report.dataobject  = "d_form_pract_priv_request_f4" or adw_report.dataobject  = "d_form_clin_priv_request_master_f2" or adw_report.dataobject  = "d_form_clin_priv_request_master_f3" or adw_report.dataobject  = "d_form_clin_priv_request_master_f4" or & 
   adw_report.dataobject  = "d_form_clin_priv_request_master_h" or adw_report.dataobject  = "d_form_clin_priv_request_master_d"  or  adw_report.dataobject  = "d_form_priv_request_master_f2" or  adw_report.dataobject  = "d_form_priv_request_master_f3" or  adw_report.dataobject  = "d_form_priv_request_master_f4"  then
	adw_report.getchild("dw_1",ldwc_1)
	ll_width = long(ldwc_1.describe("priv_template_header_text.width"))
	amle_text.width = ll_width		
	if ldwc_1.rowcount() >0 then 
		ls_text = ldwc_1.getitemstring(1,"priv_template_header_text")
		amle_text.text = ls_text
		ll_cnt = amle_text.linecount() 
//		//------------------- APPEON BEGIN -------------------
//		//$<add> Michael 06.11.2012
//		//$<reason> Bug 3119 Privileges being cut off when prinitng forms 
//		if ll_cnt > ll_lines then
//			ll_cnt = ll_lines
//			ls_text = of_get_mle_linetext(ls_text,ll_lines)
//			for ll_i = 1 to ldwc_1.rowcount()
//				ldwc_1.setitem(ll_i,"priv_template_header_text",ls_text)
//			next
//		end if
//		//------------------- APPEON END ---------------------
		ll_height = ll_cnt * 68
		ls_y = ldwc_1.describe("priv_template_header_text.Y")	//added by long.zhang 03.19.2013	Bug 3447
		
		//temp = ldwc_1.modify("datawindow.header.height = '"+string(ll_height+long(ldwc_1.describe("priv_template_header_text.y") )+15)+"'")
		temp = ldwc_1.modify("datawindow.header.height = '"+string(ll_height+long(ls_y)+15)+"'")	//long.zhang 03.19.2013	Bug 3447
		temp = ldwc_1.modify("priv_template_header_text.height = '"+string(ll_height)+"'") 
	end if		
end if
	
if adw_report.dataobject  = "d_form_pract_priv_request_f2" or adw_report.dataobject  = "d_form_pract_priv_request_h" or adw_report.dataobject  = "d_form_pract_priv_request_f2d" or adw_report.dataobject  = "d_form_pract_priv_request_d"  or adw_report.dataobject  = "d_form_pract_priv_request_d_inova" or & 
	adw_report.dataobject  = "d_form_priv_by_clin_area_d_f2" or adw_report.dataobject  = "d_form_priv_by_clin_area_f2" or adw_report.dataobject  = "d_form_priv_by_clin_area_d" or adw_report.dataobject  = "d_form_priv_by_clin_area_h"  or  adw_report.dataobject  ="d_form_priv_by_clin_area_d_f3"  or  adw_report.dataobject  ="d_form_priv_by_clin_area_d_f4" then
	ll_width = integer(adw_report.describe("priv_template_header_text.width"))
	amle_text.width = ll_width		
	if  adw_report.rowcount() > 0 then
		ls_text =  adw_report.getitemstring(1,"priv_template_header_text")
		amle_text.text = ls_text
		ll_cnt = amle_text.linecount()
//		//------------------- APPEON BEGIN -------------------
//		//$<add> Michael 06.11.2012
//		//$<reason> Bug 3119 Privileges being cut off when prinitng forms 
//		if ll_cnt > ll_lines then
//			ll_cnt = ll_lines
//			ls_text = of_get_mle_linetext(ls_text,ll_lines)
//			for ll_i = 1 to adw_report.rowcount()
//				adw_report.setitem(ll_i,"priv_template_header_text",ls_text)
//			next
//		end if
//		//------------------- APPEON END ---------------------
		
		ll_height = ll_cnt * 68

		temp = adw_report.modify("datawindow.header.height = '"+string(ll_height+long(adw_report.describe("priv_template_header_text.y") )+15)+"'")
		temp = adw_report.modify("priv_template_header_text.height = '"+string(ll_height)+"'") 
	end if
end if

//set priv_template_excl_cont_text height
if adw_report.dataobject  = "d_form_pract_priv_request_f3" or adw_report.dataobject  = "d_form_pract_priv_request_f4" or adw_report.dataobject  = "d_form_clin_priv_request_master_f2" or  adw_report.dataobject  = 	"d_form_clin_priv_request_master_f3" or   adw_report.dataobject  = "d_form_clin_priv_request_master_f4"  or &
   adw_report.dataobject  = "d_form_priv_request_master_f4" or adw_report.dataobject  = "d_form_priv_request_master_f3" or adw_report.dataobject  = "d_form_priv_request_master_f2"   then
	adw_report.getchild("dw_1",ldwc_1)
	if ldwc_1.getitemnumber(1,"use_exclusive") = 1 then
		ll_width = integer(ldwc_1.describe("priv_template_excl_cont_text.width"))
		amle_text.width = ll_width			
		if ldwc_1.rowcount() >0 then 
			ls_text = ldwc_1.getitemstring(1,"priv_template_excl_cont_text")
			amle_text.text = ls_text
			ll_cnt = amle_text.linecount()
//			//------------------- APPEON BEGIN -------------------
//			//$<add> Michael 06.11.2012
//			//$<reason> Bug 3119 Privileges being cut off when prinitng forms 
//			if ll_cnt > ll_lines then
//				ll_cnt = ll_lines
//				ls_text = of_get_mle_linetext(ls_text,ll_lines)
//				for ll_i = 1 to ldwc_1.rowcount()
//					ldwc_1.setitem(ll_i,"priv_template_excl_cont_text",ls_text)
//				next
//			end if
//			//------------------- APPEON END ---------------------
			ll_height = ll_cnt * 68		
			ls_y = ldwc_1.describe("priv_template_header_text.Y")	//	added by long.zhang 03.19.2013	Bug 3447
			//temp = ldwc_1.modify("datawindow.header.height = '"+string(ll_height+long(ldwc_1.describe("priv_template_header_text.height"))+long(ldwc_1.describe("priv_template_header_text.y"))+15+15)+"'")
			temp = ldwc_1.modify("datawindow.header.height = '"+string(ll_height+long(ldwc_1.describe("priv_template_header_text.height"))+long(ls_y)+15+15)+"'") //long.zhang 03.19.2013	Bug 3447
			temp = ldwc_1.modify("priv_template_excl_cont_text.height = '"+string(ll_height)+"'") 	
		//	temp = ldwc_1.modify("priv_template_excl_cont_text.y = '"+string(long(ldwc_1.describe("priv_template_header_text.height"))+long(ldwc_1.describe("priv_template_header_text.y"))+15)+"'") 	
			temp = ldwc_1.modify("priv_template_excl_cont_text.y = '"+string(long(ldwc_1.describe("priv_template_header_text.height"))+long(ls_y)+15)+"'") 	//long.zhang 03.19.2013	Bug 3447
		end if
	end if	
end if
if adw_report.dataobject  = "d_form_priv_by_clin_area_d_f4" or adw_report.dataobject  = "d_form_priv_by_clin_area_d_f3" or adw_report.dataobject  = "d_form_priv_by_clin_area_d_f2" or adw_report.dataobject  = "d_form_priv_by_clin_area_f2" 	then																				  			
		if adw_report.getitemnumber(1 ,"use_exclusive") = 1  then
			ll_width = integer(adw_report.describe("priv_template_excl_cont_text.width"))
			amle_text.width = ll_width		
			if  adw_report.rowcount() > 0 then
				ls_text =  adw_report.getitemstring(1,"priv_template_excl_cont_text")
				amle_text.text = ls_text
				ll_cnt = amle_text.linecount() 	
//				//------------------- APPEON BEGIN -------------------
//				//$<add> Michael 06.11.2012
//				//$<reason> Bug 3119 Privileges being cut off when prinitng forms 
//				if ll_cnt > ll_lines then
//					ll_cnt = ll_lines
//					ls_text = of_get_mle_linetext(ls_text,ll_lines)
//					for ll_i = 1 to adw_report.rowcount()
//						adw_report.setitem(ll_i,"priv_template_excl_cont_text",ls_text)
//					next
//				end if
//				//------------------- APPEON END ---------------------
				ll_height = ll_cnt * 68
				
				temp = adw_report.modify("datawindow.header.height = '"+string(ll_height+long(adw_report.describe("priv_template_header_text.height"))+long(adw_report.describe("priv_template_header_text.y"))+15+15)+"'")
				temp = adw_report.modify("priv_template_excl_cont_text.height = '"+string(ll_height)+"'") 	
				temp = adw_report.modify("priv_template_excl_cont_text.y = '"+string(long(adw_report.describe("priv_template_header_text.height"))+long(adw_report.describe("priv_template_header_text.y"))+15)+"'") 	
			end if
		end if
end if
adw_report.setredraw(true)
return 1
end function

public function string of_get_mle_linetext (string as_mle_text, long al_lines);//////////////////////////////////////////////////////////////////////
// $<function> of_get_mle_linetext
// $<arguments>
//              as_mle_text
//					 al_lines
// $<returns>  ls_linetext
// $<description> get the first few lines of text in the MLE
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Michael 06.11.2012
//////////////////////////////////////////////////////////////////////
string ls_linetext = ''
long ll_i
long ll_pos

for ll_i = 1 to al_lines
	ll_pos = pos(as_mle_text,"~r~n")
	if ll_i = al_lines then
		ls_linetext = ls_linetext + left(as_mle_text,ll_pos - 1) + "~r~n"
	else
		ls_linetext = ls_linetext + left(as_mle_text,ll_pos - 1) //+ "~r~n"
	end if
	as_mle_text = right(as_mle_text , len(as_mle_text) - ll_pos)	
next
return ls_linetext
end function

public function integer of_set_height (datastore ads_report, multilineedit amle_text);//////////////////////////////////////////////////////////////////////
// $<function> of_set_height
// $<arguments>
//              ads_report
//					 amle_text
// $<returns>  
// $<description> For printing privilege forms with expiring appointment letter 
//////////////////////////////////////////////////////////////////////
// Add by Appeon:long.zhang 08.31.2012
//////////////////////////////////////////////////////////////////////
string ls_text
string ls_y	//long.zhang 03.19.2013
long  ll_cnt, ll_height, ll_width 
CONSTANT long ll_lines = 10000
long ll_i  
string temp
datawindowchild ldwc_1


//ads_report.setredraw(false)
//set priv_template_header_text height
if ads_report.dataobject  = "d_form_clin_priv_request_master_inova" or ads_report.dataobject  = "d_form_pract_priv_request_f3"  or ads_report.dataobject  = "d_form_pract_priv_request_f4" or ads_report.dataobject  = "d_form_clin_priv_request_master_f2" or ads_report.dataobject  = "d_form_clin_priv_request_master_f3" or ads_report.dataobject  = "d_form_clin_priv_request_master_f4" or & 
   ads_report.dataobject  = "d_form_clin_priv_request_master_h" or ads_report.dataobject  = "d_form_clin_priv_request_master_d"  or  ads_report.dataobject  = "d_form_priv_request_master_f2" or  ads_report.dataobject  = "d_form_priv_request_master_f3" or  ads_report.dataobject  = "d_form_priv_request_master_f4"  then
	ads_report.getchild("dw_1",ldwc_1)
	ll_width = integer(ldwc_1.describe("priv_template_header_text.width"))
	amle_text.width = ll_width		
	if ldwc_1.rowcount() >0 then 
		ls_text = ldwc_1.getitemstring(1,"priv_template_header_text")
		amle_text.text = ls_text
		ll_cnt = amle_text.linecount() 
//		//------------------- APPEON BEGIN -------------------
//		//$<add> Michael 06.11.2012
//		//$<reason> Bug 3119 Privileges being cut off when prinitng forms 
//		if ll_cnt > ll_lines then
//			ll_cnt = ll_lines
//			ls_text = of_get_mle_linetext(ls_text,ll_lines)
//			for ll_i = 1 to ldwc_1.rowcount()
//				ldwc_1.setitem(ll_i,"priv_template_header_text",ls_text)
//			next
//		end if
//		//------------------- APPEON END ---------------------
		ll_height = ll_cnt * 68	
		ls_y = ldwc_1.describe("priv_template_header_text.Y")	//added by long.zhang 03.19.2013 Bug 3447
//		temp = ldwc_1.modify("datawindow.header.height = '"+string(ll_height+long(ldwc_1.describe("priv_template_header_text.y") )+15)+"'")
		temp = ldwc_1.modify("datawindow.header.height = '"+string(ll_height+long(ls_y)+15)+"'")	//long.zhang 03.19.2013 Bug 3447
		temp = ldwc_1.modify("priv_template_header_text.height = '"+string(ll_height)+"'") 
	end if		
end if
	
if ads_report.dataobject  = "d_form_pract_priv_request_f2" or ads_report.dataobject  = "d_form_pract_priv_request_h" or ads_report.dataobject  = "d_form_pract_priv_request_f2d" or ads_report.dataobject  = "d_form_pract_priv_request_d"  or ads_report.dataobject  = "d_form_pract_priv_request_d_inova" or & 
	ads_report.dataobject  = "d_form_priv_by_clin_area_d_f2" or ads_report.dataobject  = "d_form_priv_by_clin_area_f2" or ads_report.dataobject  = "d_form_priv_by_clin_area_d" or ads_report.dataobject  = "d_form_priv_by_clin_area_h"  or  ads_report.dataobject  ="d_form_priv_by_clin_area_d_f3"  or  ads_report.dataobject  ="d_form_priv_by_clin_area_d_f4" then
	ll_width = integer(ads_report.describe("priv_template_header_text.width"))
	amle_text.width = ll_width		
	if  ads_report.rowcount() > 0 then
		ls_text =  ads_report.getitemstring(1,"priv_template_header_text")
		amle_text.text = ls_text
		ll_cnt = amle_text.linecount()
//		//------------------- APPEON BEGIN -------------------
//		//$<add> Michael 06.11.2012
//		//$<reason> Bug 3119 Privileges being cut off when prinitng forms 
//		if ll_cnt > ll_lines then
//			ll_cnt = ll_lines
//			ls_text = of_get_mle_linetext(ls_text,ll_lines)
//			for ll_i = 1 to ads_report.rowcount()
//				ads_report.setitem(ll_i,"priv_template_header_text",ls_text)
//			next
//		end if
//		//------------------- APPEON END ---------------------
		
		ll_height = ll_cnt * 68
		
		temp = ads_report.modify("datawindow.header.height = '"+string(ll_height+long(ads_report.describe("priv_template_header_text.y") )+15)+"'")
		temp = ads_report.modify("priv_template_header_text.height = '"+string(ll_height)+"'") 
	end if
end if

//set priv_template_excl_cont_text height
if ads_report.dataobject  = "d_form_pract_priv_request_f3" or ads_report.dataobject  = "d_form_pract_priv_request_f4" or ads_report.dataobject  = "d_form_clin_priv_request_master_f2" or  ads_report.dataobject  = 	"d_form_clin_priv_request_master_f3" or   ads_report.dataobject  = "d_form_clin_priv_request_master_f4"  or &
   ads_report.dataobject  = "d_form_priv_request_master_f4" or ads_report.dataobject  = "d_form_priv_request_master_f3" or ads_report.dataobject  = "d_form_priv_request_master_f2"   then
	ads_report.getchild("dw_1",ldwc_1)
	if ldwc_1.getitemnumber(1,"use_exclusive") = 1 then
		ll_width = integer(ldwc_1.describe("priv_template_excl_cont_text.width"))
		amle_text.width = ll_width			
		if ldwc_1.rowcount() >0 then 
			ls_text = ldwc_1.getitemstring(1,"priv_template_excl_cont_text")
			amle_text.text = ls_text
			ll_cnt = amle_text.linecount()
//			//------------------- APPEON BEGIN -------------------
//			//$<add> Michael 06.11.2012
//			//$<reason> Bug 3119 Privileges being cut off when prinitng forms 
//			if ll_cnt > ll_lines then
//				ll_cnt = ll_lines
//				ls_text = of_get_mle_linetext(ls_text,ll_lines)
//				for ll_i = 1 to ldwc_1.rowcount()
//					ldwc_1.setitem(ll_i,"priv_template_excl_cont_text",ls_text)
//				next
//			end if
//			//------------------- APPEON END ---------------------
			ll_height = ll_cnt * 68		
			ls_y = ldwc_1.describe("priv_template_header_text.Y") //added by long.zhang 03.19.2013 Bug 3447		
			//temp = ldwc_1.modify("datawindow.header.height = '"+string(ll_height+long(ldwc_1.describe("priv_template_header_text.height"))+long(ldwc_1.describe("priv_template_header_text.y"))+15+15)+"'")
			temp = ldwc_1.modify("datawindow.header.height = '"+string(ll_height+long(ldwc_1.describe("priv_template_header_text.height"))+long(ls_y)+15+15)+"'")//long.zhang 03.19.2013 Bug 3347
			temp = ldwc_1.modify("priv_template_excl_cont_text.height = '"+string(ll_height)+"'") 	
			//temp = ldwc_1.modify("priv_template_excl_cont_text.y = '"+string(long(ldwc_1.describe("priv_template_header_text.height"))+long(ldwc_1.describe("priv_template_header_text.y"))+15)+"'")
			temp = ldwc_1.modify("priv_template_excl_cont_text.y = '"+string(long(ldwc_1.describe("priv_template_header_text.height"))+long(ls_y)+15)+"'") 	//long.zhang 03.19.2013 Bug 3347
		end if
	end if	
end if
if ads_report.dataobject  = "d_form_priv_by_clin_area_d_f4" or ads_report.dataobject  = "d_form_priv_by_clin_area_d_f3" or ads_report.dataobject  = "d_form_priv_by_clin_area_d_f2" or ads_report.dataobject  = "d_form_priv_by_clin_area_f2" 	then																				  			
		if ads_report.getitemnumber(1 ,"use_exclusive") = 1  then
			ll_width = integer(ads_report.describe("priv_template_excl_cont_text.width"))
			amle_text.width = ll_width		
			if  ads_report.rowcount() > 0 then
				ls_text =  ads_report.getitemstring(1,"priv_template_excl_cont_text")
				amle_text.text = ls_text
				ll_cnt = amle_text.linecount() 	
//				//------------------- APPEON BEGIN -------------------
//				//$<add> Michael 06.11.2012
//				//$<reason> Bug 3119 Privileges being cut off when prinitng forms 
//				if ll_cnt > ll_lines then
//					ll_cnt = ll_lines
//					ls_text = of_get_mle_linetext(ls_text,ll_lines)
//					for ll_i = 1 to ads_report.rowcount()
//						ads_report.setitem(ll_i,"priv_template_excl_cont_text",ls_text)
//					next
//				end if
//				//------------------- APPEON END ---------------------
				ll_height = ll_cnt * 68
				
				temp = ads_report.modify("datawindow.header.height = '"+string(ll_height+long(ads_report.describe("priv_template_header_text.height"))+long(ads_report.describe("priv_template_header_text.y"))+15+15)+"'")
				temp = ads_report.modify("priv_template_excl_cont_text.height = '"+string(ll_height)+"'") 	
				temp = ads_report.modify("priv_template_excl_cont_text.y = '"+string(long(ads_report.describe("priv_template_header_text.height"))+long(ads_report.describe("priv_template_header_text.y"))+15)+"'") 	
			end if
		end if
end if
//ads_report.setredraw(true)
return 1
end function

on n_cst_priv_height.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_priv_height.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

