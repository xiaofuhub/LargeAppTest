$PBExportHeader$w_oig_on_demand.srw
forward
global type w_oig_on_demand from window
end type
type cb_4 from commandbutton within w_oig_on_demand
end type
type cbx_maiden from checkbox within w_oig_on_demand
end type
type cb_log_view from commandbutton within w_oig_on_demand
end type
type dw_log from datawindow within w_oig_on_demand
end type
type cb_log from commandbutton within w_oig_on_demand
end type
type cb_batch from commandbutton within w_oig_on_demand
end type
type rb_2 from radiobutton within w_oig_on_demand
end type
type rb_1 from radiobutton within w_oig_on_demand
end type
type cbx_npi from checkbox within w_oig_on_demand
end type
type st_pname from statictext within w_oig_on_demand
end type
type cb_3 from commandbutton within w_oig_on_demand
end type
type cb_2 from commandbutton within w_oig_on_demand
end type
type cb_1 from commandbutton within w_oig_on_demand
end type
type cb_cancel from commandbutton within w_oig_on_demand
end type
type cb_clear from commandbutton within w_oig_on_demand
end type
type cb_print from commandbutton within w_oig_on_demand
end type
type st_added from statictext within w_oig_on_demand
end type
type st_3 from statictext within w_oig_on_demand
end type
type st_2 from statictext within w_oig_on_demand
end type
type st_1 from statictext within w_oig_on_demand
end type
type cb_view from commandbutton within w_oig_on_demand
end type
type cb_done from commandbutton within w_oig_on_demand
end type
type cb_scan from commandbutton within w_oig_on_demand
end type
type cbx_dob from checkbox within w_oig_on_demand
end type
type cbx_first from checkbox within w_oig_on_demand
end type
type cbx_last from checkbox within w_oig_on_demand
end type
type cb_search from commandbutton within w_oig_on_demand
end type
type gb_1 from groupbox within w_oig_on_demand
end type
type dw_verifs from datawindow within w_oig_on_demand
end type
type dw_oig_data from datawindow within w_oig_on_demand
end type
type cb_none from commandbutton within w_oig_on_demand
end type
type gb_2 from groupbox within w_oig_on_demand
end type
type dw_prac_list from datawindow within w_oig_on_demand
end type
type dw_copied from u_dw within w_oig_on_demand
end type
end forward

global type w_oig_on_demand from window
integer x = 142
integer y = 48
integer width = 4210
integer height = 2680
boolean titlebar = true
string title = "OIG Search"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
cb_4 cb_4
cbx_maiden cbx_maiden
cb_log_view cb_log_view
dw_log dw_log
cb_log cb_log
cb_batch cb_batch
rb_2 rb_2
rb_1 rb_1
cbx_npi cbx_npi
st_pname st_pname
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
cb_cancel cb_cancel
cb_clear cb_clear
cb_print cb_print
st_added st_added
st_3 st_3
st_2 st_2
st_1 st_1
cb_view cb_view
cb_done cb_done
cb_scan cb_scan
cbx_dob cbx_dob
cbx_first cbx_first
cbx_last cbx_last
cb_search cb_search
gb_1 gb_1
dw_verifs dw_verifs
dw_oig_data dw_oig_data
cb_none cb_none
gb_2 gb_2
dw_prac_list dw_prac_list
dw_copied dw_copied
end type
global w_oig_on_demand w_oig_on_demand

type variables
long il_pracid[]
long il_notfound
integer ii_last = 1
integer ii_first = 1
integer ii_dob = 1
integer ii_bus = 0
integer ii_maid = 0
string is_verif 
string is_from
string is_auto
string is_type = "P"
string ii_matchon
date id_last_update
boolean ib_all_data = false //maha 08.02.2013

Boolean ib_continue = False
end variables

forward prototypes
public function integer of_add_no_match (integer ai_row)
public function integer of_change_label (string as_type)
public function integer of_scan_oig_data (string as_auto, integer ai_lname, integer ai_fname, integer ai_dob, string as_type, integer ai_npi)
public function string of_set_where (integer ai_row, integer ai_lname, integer ai_fname, integer ai_dob, integer ai_npi)
public function integer of_prac_mass (gs_batch_search ast_pracs)
public function string of_set_filter (integer ai_row, integer ai_lname, integer ai_fname, integer ai_dob, integer ai_npi)
public function integer of_add_log (long al_prac, integer ai_cnt)
end prototypes

public function integer of_add_no_match (integer ai_row);integer r
string ls_date


r = dw_copied.insertrow(0)
dw_copied.setitem(r,"lastname",dw_prac_list.getitemstring(ai_row,"last_name"))
dw_copied.setitem(r,"firstname",dw_prac_list.getitemstring(ai_row,"first_name"))
//dw_oig_data.setitem(r,"midname",dw_prac_list.getitemstring(ai_row,""))
ls_date = of_date_to_string(dw_prac_list.getitemdatetime(ai_row,"date_of_birth"),"mm\dd\yy")
dw_copied.setitem(r,"dob",ls_date)
dw_copied.setitem(r,"sanctype","None")
dw_copied.setitem(r,"code_lookup_description","No Match Found")
//dw_oig_data.setitem(r,"",dw_prac_list.getitemstring(ai_row,""))
//dw_oig_data.setitem(r,"",dw_prac_list.getitemstring(ai_row,""))
//dw_oig_data.setitem(r,"",dw_prac_list.getitemstring(ai_row,""))
//dw_oig_data.setitem(r,"",dw_prac_list.getitemstring(ai_row,""))

return 1
end function

public function integer of_change_label (string as_type);choose case as_type
	case "P"
		cbx_last.text = "Last Name"
		cbx_first.text = "First Name"
		cbx_dob.text = "Date Of Birth"
		cbx_maiden.visible = true
	Case "B"
		cbx_last.text = "Business Name"
		cbx_first.text = "Street"
		cbx_dob.text = "Zip Code"
		cbx_maiden.visible = false
end choose


return 1
end function

public function integer of_scan_oig_data (string as_auto, integer ai_lname, integer ai_fname, integer ai_dob, string as_type, integer ai_npi);//of_scan_oig_data()
long i
long ic
long r
long rc
long cnt  //maha 08.01.2013
long ll_log //maha 03.27.2014
long ll_prac //maha 03.27.2014
Long ll_start
Long ll_lastselectedrow
Long ll_begin
Long ll_end
integer li_ans   //maha 08.02.2013
string lname
string fname
string dob
string ls_where = "WHERE"
string ls_sql
string ls_sql_org
string pracname
string ls_return
String ls_sanctype
boolean lb_first

//Start Code Change ----03.26.2014 #V14.2 maha - this sets the values for the report
ii_matchon = ''

 //Start Code Change ----12.17.2015 #V15 maha - change parameters if business
if rb_1.checked then //practitioner
	if cbx_last.checked then ii_matchon = "L"
	if cbx_first.checked then ii_matchon+= "F"
	if cbx_dob.checked then ii_matchon+= "D"
	if cbx_NPI.checked then ii_matchon+= "N"
	if cbx_maiden.checked then ii_matchon+= "M"
else  //business
	if cbx_last.checked then ii_matchon = "B"
	if cbx_first.checked then ii_matchon+= "S"
	if cbx_dob.checked then ii_matchon+= "Z"
	if cbx_NPI.checked then ii_matchon+= "N"
end if
//End Code Change ----12.17.2015


dw_log.reset()
//Start Code Change ----03.26.2014 

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03/19/2008 By: Ken.Guo
//$<reason> Add Trap
If dw_prac_list.rowcount() = 0 Then Return 0
//---------------------------- APPEON END ----------------------------

if as_auto = "A" then //if came in as auto scan set the instance variables
	ii_last = ai_lname
	ii_first = ai_fname
	ii_dob = ai_dob
end if

//get the original sql 
dw_oig_data.SetTransObject( SQLCA )
ls_sql_org = dw_oig_data.GetSQLSelect()

//BATCH scan
if as_type = "S" then  //if a batch scan scroll through list getting the where clause
	ic = dw_prac_list.rowcount()

	st_1.text = "Retrieving scan data"  //Start Code Change ----07.31.2013 #V14 maha

	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 03.25.2016
	//<$>reason:Reduce time costs, for issue: Performance on OIG scan when using 3440 providers

//	//Start Code Change ----06.24.2013 #V14 maha
//	if ic > 1000 then //if this many get all the oig data  //maha 08012013 changed from 10000
//		dw_oig_data.SetTransObject( SQLCA )
//		cnt = dw_oig_data.Retrieve( )
//		ib_all_data = true
//	else 
//		lb_first = true
//		for i = 1 to ic			
//			//---------Begin Modified by (Appeon)Stephen 08.12.2013 for Bug 3629-------
//			/*
//			if i = 1 then
//				ls_where = "WHERE " + of_set_where(i,ai_lname,ai_fname,ai_dob,ai_npi)
//			else
//				ls_where += "OR" + of_set_where(i,ai_lname,ai_fname,ai_dob,ai_npi)
//			end if
//			*/
//			if lb_first then
//				ls_return =  of_set_where(i,ai_lname,ai_fname,ai_dob,ai_npi)
//				if not (isnull(ls_return) or trim(ls_return) = '()') then
//					ls_where = "WHERE " + ls_return
//					lb_first = false
//				end if
//			else
//				ls_return =  of_set_where(i,ai_lname,ai_fname,ai_dob,ai_npi)
//				if not (isnull(ls_return) or trim(ls_return) = '()') then
//					ls_where += "OR" + ls_return
//				end if
//			end if
//			//---------End Modfiied ------------------------------------------------------
//		next
//		IF ic > 0 THEN
//			ls_sql = ls_sql_org
//			if lower(trim(ls_where)) <> 'where' then //(Appeon)Stephen 08.12.2013 - Bug 3630
//				ls_sql = ls_sql + ls_where
//			end if
//			dw_oig_data.SetSQlSelect( ls_sql )
//			dw_oig_data.SetTransObject( SQLCA )
//			cnt = dw_oig_data.Retrieve( )
//		END IF
//
//	end if
//	//End Code Change ----06.24.2013	

	
	ll_begin = 1	
	if ic > 1000 then //if this many get all the oig data	
		ib_all_data = true
		ll_end = 1000 //Init
	Else
		ll_end = ic
	End If
	
	If ic > 0 Then
		//Retreive multi-times when ic > 1000
		Do
			lb_first = true
			ls_where = "WHERE"
			
			for i = ll_begin to ll_end			
				if lb_first then
					ls_return =  of_set_where(i,ai_lname,ai_fname,ai_dob,ai_npi)
					if not (isnull(ls_return) or trim(ls_return) = '()') then
						ls_where = "WHERE " + ls_return
						lb_first = false
					end if
				else
					ls_return =  of_set_where(i,ai_lname,ai_fname,ai_dob,ai_npi)
					if not (isnull(ls_return) or trim(ls_return) = '()') then
						ls_where += "OR" + ls_return
					end if
				end if
			next
			
			ls_sql = ls_sql_org
			if lower(trim(ls_where)) <> 'where' then //(Appeon)Stephen 08.12.2013 - Bug 3630
				ls_sql = ls_sql + ls_where
			end if
			dw_oig_data.SetSQlSelect( ls_sql )
			dw_oig_data.SetTransObject( SQLCA )
			st_1.text = "Retrieving scan data (" + String(ll_begin) + ' - ' + String(ll_end) + ')'
			Yield()
			cnt = dw_oig_data.Retrieve( ) //when ib_continue, it doesn't reset data.
			
			//Continue retrieve
			If ll_end < ic Then
				ll_begin = ll_end + 1
				If (ll_end + 1000) > ic Then
					ll_end = ic
				Else
					ll_end = ll_end + 1000
				End If
				ib_continue = True
			Else
				ib_continue = False
			End If
		Loop While ib_continue
	End If
	//------------------- APPEON END -------------------
	
	if cnt < 0 then //Start Code Change ----08.01.2013 #V14 maha
		messagebox("OIG error","error with OIG data syntax")
		return -1
	end if
	//debugbreak()
	st_1.text = "Scanning Records"  //Start Code Change ----07.31.2013 #V14 maha
	//scan the oig data	
	for i = 1 to ic
		if mod(i, 1000) = 0 then //update progress message
			st_1.text = "Scanning Records " + string(i) + " records scanned"
		end if
		if  dw_prac_list.getitemnumber(i,"selected") = 1 then
			//pracname = dw_prac_list.getitemstring(i,"last_name")
			ll_prac = dw_prac_list.getitemnumber(i, "prac_id")  //Start Code Change ----03.26.2014 #V14.2 maha
			//st_pname.text = pracname

			ll_lastselectedrow = i
			If  mod(i, 1000) = 0 Then //Test
				yield()
				dw_prac_list.scrolltorow(i)
				dw_prac_list.selectrow(0,false)
				dw_prac_list.selectrow(i,true)	
			End If
			ls_where = of_set_filter(i,ai_lname,ai_fname,ai_dob,ai_npi)
			if isnull(ls_where) or trim(ls_where) = '()' then ls_where = '' //(Appeon)Stephen 08.12.2013 - Bug 3629

			//------------------- APPEON BEGIN -------------------
			//<$>added:long.zhang 03.24.2016
			//<$>reason: Reduce time, For issue: Performance on OIG scan when using 3440 providers.
			//------------------- APPEON END -------------------			
//			//messagebox("filter",ls_where)
//			rc = dw_oig_data.setfilter(ls_where)	
//			if rc < 1 then
//				li_ans =  messagebox("OIG Filter Failed.", ls_where + "~r~rDo you want to continue to scan?", question!,yesno!,2) //Start Code Change ----08.02.2013 #V14 maha - added option to continue scan
//				if li_ans = 2 then return 1
//			end if
//			
//			dw_oig_data.filter()
//			r = dw_oig_data.Rowcount( )
//			
//			//copy any results on auto scan
//			dw_prac_list.setitem(i,"matchfound",r)
//			if r > 0 then
//				if r = 1 then
//					dw_prac_list.setitem(i,"cust_10",dw_oig_data.getitemstring(1,"sanctype"))
//				end if
//				dw_oig_data.RowsCopy (1, r, primary!, dw_copied, 100000, primary! )
//			else
//				of_add_no_match(i)
//				dw_prac_list.setitem(i,"cust_10"," No Match")
//				//dw_oig_data.RowsCopy (1, r, primary!, dw_copied, 100000, primary! ) //comment test
//				//dw_oig_data.setitem(dw_oig_data.rowcount(),"sanctype",'None') //comment test
//				//messagebox("OIG Scan","Scan complete")
//			end if	
						
			ll_start = 0
			rc = dw_oig_data.Find(ls_where, ll_start, cnt)	
			If rc < 0 Then
				li_ans =  messagebox("OIG Find Failed.", ls_where + "~r~rDo you want to continue to scan?", question!,yesno!,2) //Start Code Change ----08.02.2013 #V14 maha - added option to continue scan
				If li_ans = 2 Then Return 1
			End If
			
			//Remeber it
			If rc > 0 Then ls_sanctype = dw_oig_data.getitemstring(rc, "sanctype")
			
			//Find more
			r = 0
			Do While (rc > 0)
				r++ //Count find result
				
				dw_oig_data.RowsCopy (r, r, primary!, dw_copied, 100000, primary! )
				
				If rc = cnt Then Exit		
				ll_start =	rc + 1
				rc = dw_oig_data.Find(ls_where, ll_start, cnt)	
			Loop

			dw_prac_list.setitem(i,"matchfound",r)
			
			//Special logic
			If r = 1 then
				dw_prac_list.setitem(i,"cust_10", ls_sanctype)
			ElseIf r= 0 Then
				of_add_no_match(i)
				dw_prac_list.setitem(i,"cust_10"," No Match")
			end if
			
			//------------------- APPEON END -------------------	
					
			of_add_log( ll_prac, r)  //Start Code Change ----03.26.2014 #V14.2 maha
		end if
	next
	
	If ll_lastselectedrow > 0 Then  //Test
		dw_prac_list.scrolltorow(i)
		dw_prac_list.selectrow(0,false)
		dw_prac_list.selectrow(i,true)	
	End If
	
//	rc = dw_oig_data.setfilter("")	//Comment by Appeon long.zhang 03.24.2016 (Performance on OIG scan when using 3440 providers)
//	dw_oig_data.filter() //Comment by Appeon long.zhang 03.24.2016 (Performance on OIG scan when using 3440 providers)
	
	st_1.text = "Scanning Complete " + string(i) + " records scanned" //Start Code Change ----07.31.2013 #V14 maha
	messagebox("OIG Scan","Scan completed.")
	st_1.text = "Double click Name to search, or click Scan List to scan all records selected."  //Start Code Change ----07.31.2013 #V14 maha

else //single practioner from doubleclick
	i = dw_prac_list.getrow()
	//messagebox("row",i)
	//Start Code Change ----08.02.2013 #V14 maha - added code where all data was retrieved to improve perfocmance
	if not ib_all_data then
		//---------Begin Modified by (Appeon)Stephen 08.15.2013 for Bug 3630--------
		//ls_where = "WHERE " + of_set_where(i,ai_lname,ai_fname,ai_dob,ai_npi)
		ls_where = of_set_where(i,ai_lname,ai_fname,ai_dob,ai_npi)
		if isnull(ls_where) or trim(ls_where) = '()' then 
			ls_where = ''
		else
			ls_where = "WHERE "  + ls_where
		end if
		//---------End Modfiied ------------------------------------------------------
		
				//messagebox("",ls_where)
		ls_sql = ls_sql_org	
		if lower(trim(ls_where)) <> 'where' then //(Appeon)Stephen 08.15.2013 - Bug 3630
			ls_sql = ls_sql + ls_where
		end if
				//messagebox("",ls_sql_org)
				//messagebox("",ls_sql)
		dw_oig_data.SetSQlSelect( ls_sql )
		dw_oig_data.SetTransObject( SQLCA )
		r = dw_oig_data.Retrieve( )
	else //if all data has been retrieved, filter
		ls_where = of_set_filter(i,ai_lname,ai_fname,ai_dob,ai_npi)
		if isnull(ls_where) or trim(ls_where) = '()' then ls_where = '' //(Appeon)Stephen 08.15.2013 - Bug 3629
		rc = dw_oig_data.setfilter(ls_where)	
		if rc < 1 then
			li_ans =  messagebox("OIG Filter Failed.", ls_where + "~r~rDo you want to continue to scan?", question!,yesno!,2) //Start Code Change ----08.02.2013 #V14 maha - added option to continue scan
			if li_ans = 2 then return 1
		end if
			
		dw_oig_data.filter()

		r = dw_oig_data.rowcount()
		
	end if
	ll_prac = dw_prac_list.getitemnumber(i, "prac_id")  //Start Code Change ----03.26.2014 #V14.2 maha
	if r > 0 then
		dw_prac_list.setitem(i,"matchfound",r)
		if r = 1 then
			dw_prac_list.setitem(i,"cust_10",dw_oig_data.getitemstring(1,"sanctype"))
		end if
	else //maha 082505  creating 'no match' record
		of_add_no_match(i)
		dw_prac_list.setitem(i,"cust_10"," No Match")
		dw_oig_data.RowsCopy (1, r, primary!, dw_copied, 100000, primary! )
		//dw_oig_data.setitem(dw_oig_data.rowcount(),"sanctype",'None') - commented by alfee 03.12.2010
	end if
	of_add_log( ll_prac, r)  //Start Code Change ----03.26.2014 #V14.2 maha
	st_3.text = string(r) + " records found"
end if

//---------------------------- APPEON END ----------------------------

st_added.text = "Report has " + string(dw_copied.rowcount()) + " records."	
	
dw_oig_data.SetSQlSelect( ls_sql_org )
dw_oig_data.SetTransObject( SQLCA )	

if dw_oig_data.rowcount() = 0 then
	st_3.text = "No Records Found"
end if

dw_copied.object.t_last_update.text = string(id_last_update)

dw_log.update()  //Start Code Change ----03.26.2014 #V14.2 maha

if is_auto = "A" then
	cb_done.triggerevent(clicked!)
end if
	

return 1

end function

public function string of_set_where (integer ai_row, integer ai_lname, integer ai_fname, integer ai_dob, integer ai_npi);long i
long ic
long r
long rc
integer p
string lname
string first_street
string ls_zip
string syear
string smonth
string sday
string ls_oig_1
string ls_oig_2
string ls_oig_3
string ls_oig_4
date d_dob
string dob
string ls_npi
string ls_where1
string ls_where2
string ls_where3
string ls_where4
string ls_where = " ("
string ls_maiden  //maha 09.07.2017
string ls_maiden_first  //maha 10.23.2017
n_cst_string ln_string

//Start Code Change ----06.21.2013 #V14 maha - redesigned for alternate search type for business and redesigned clause creation
if is_type = "P" then
	lname = upper(dw_prac_list.getitemstring(ai_row,"last_name"))
	ls_oig_1 = " upper(oig_data.lastname) "
else
	lname = upper(dw_prac_list.getitemstring(ai_row,"last_name"))
	ls_oig_1 = " upper(oig_data.busname) "
end if

if is_type = "P" and ii_maid = 1 then  //Start Code Change ----09.07.2017 #V154 maha
	ls_maiden = upper(dw_prac_list.getitemstring(ai_row,"maiden_other_name"))
end if

//Start Code Change ----10.23.2017 #V16 maha
p = pos(ls_maiden, " ", 1)
if p > 0 then
	ls_maiden_first = mid(ls_maiden, 1, p - 1)
	ls_maiden = mid(ls_maiden,  p + 1)
else
	ls_maiden_first = ""
end if

//messagebox(ls_maiden, ls_maiden_first)
	
//do until p < 1
	p = PosA(lname,"'",1) 
if p > 0 then
	lname = MidA(lname,1,p - 1) + "'" + MidA(lname,p )
end if

p = PosA(first_street,"'",1) 
if p > 0 then
	lname = MidA(first_street,1,p - 1) + "'" + MidA(first_street,p  )
end if

if is_type = "P" then
	first_street = upper(dw_prac_list.getitemstring(ai_row,"first_name"))
	ls_oig_2 = " upper(oig_data.firstname) "
else
	first_street = upper(dw_prac_list.getitemstring(ai_row,"street_2"))
	ls_oig_2 = " upper(oig_data.address) "
end if

if isnull(first_street) then first_street = ""
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-09-15 By: Liu HongXin
//$<reason> Fix defect.
lname = ln_string.of_globalreplace(lname, "''", "'", False)
lname = ln_string.of_globalreplace(lname, "'", "''", False)
lname = ln_string.of_globalreplace(lname, '"', '', False)

first_street = ln_string.of_globalreplace(first_street, "''", "'", False)
first_street = ln_string.of_globalreplace(first_street, "'", "''", False)
first_street= ln_string.of_globalreplace(first_street, '"', '', False)
//---------------------------- APPEON END ----------------------------

if is_type = "P" then
	d_dob = date(dw_prac_list.getitemdatetime(ai_row,"date_of_birth"))
	syear = MidA(string(year(d_dob)),3,2)
	smonth = string(month(d_dob))
	sday = string(day(d_dob))
	//---------Begin Added by (Appeon)Stephen 2013-09-09 for Bug 3661 OIG Scan error--------
	if isnull(syear) then syear ='0'
	if isnull(smonth) then smonth ='0'
	if isnull(sday) then sday ='0'
	//---------End Added ------------------------------------------------------
	if LenA(smonth) = 1 then smonth = "0" + smonth
	if LenA(sday) = 1 then sday = "0" + sday
	dob = smonth + "/" + sday + "/" + syear
	if isnull(dob) then dob = ""
	ls_oig_3 = " oig_data.dob "
else
	dob = mid(dw_prac_list.getitemstring(ai_row,"zip"),1,5) //oig data contains only 5 digits
	ls_oig_3 = " oig_data.zip "
end if

//for both npi
ls_npi = dw_prac_list.getitemstring(ai_row,"npi_number")
ls_oig_4 = " oig_data.npi_num "  //maha 08.08.2013 corrected field name 

ls_where1 = ls_oig_1 + " = '" + lname  + "'"
ls_where2 = ls_oig_2 + " = '" + first_street + "'" 
ls_where3 = ls_oig_3 + " = '" + dob  + "'"
ls_where4 = ls_oig_4 + " = '" + ls_npi + "'"

//Start Code Change ----10.23.2017 #V16 maha
if is_type = "P" and ii_maid = 1 then  //Start Code Change ----09.07.2017 #V154 maha - for maiden name search
	if len(ls_maiden_first) > 0 then
		ls_where1 = "(" + ls_where1 + " OR " + ls_oig_1 + " = '" + ls_maiden  + "' )"
	end if
	
	if len(ls_maiden_first) > 0 then
		ls_where2 = "(" + ls_where2 + " OR " + ls_oig_1 + " = '" + ls_maiden_first  + "' )"
	end if
end if
//End Code Change ----10.23.2017

if ai_lname = 1 then 
	if not isnull(ls_where1) then //(Appeon)Stephen 2013-08-15 -  Bug 3630
		ls_where+= ls_where1
	end if
end if

if ai_fname = 1 then
	if not isnull(ls_where2) then //(Appeon)Stephen 2013-08-15 -  Bug 3630
		if len(ls_where) > 8 then  ls_where+= " AND "
		 ls_where+= ls_where2
	end if
end if

if ai_dob = 1 then
	if not isnull(ls_where3) then //(Appeon)Stephen 2013-08-15 -  Bug 3630
		if len(ls_where) > 8 then  ls_where+= " AND "
		 ls_where+= ls_where3
	end if
end if

if ai_npi = 1 then
	if not isnull(ls_where4) then //(Appeon)Stephen 2013-08-15 -  Bug 3630
		if len(ls_where) > 8 then  ls_where+= " AND "
		 ls_where+= ls_where4
	end if
end if
	
//messagebox("dob",dob)
//if ai_lname = 1 and ai_fname = 1 and ai_dob = 1 then
//	ls_where = ls_where + " upper(oig_data.lastname) = '" + lname + "' and upper(oig_data.firstname) = '" + first_street + "' and oig_data.dob = '" + dob + "'"
//elseif ai_lname = 1 and ai_fname = 1 then
//	ls_where = ls_where + " upper(oig_data.lastname) = '" + lname + "' and upper(oig_data.firstname) = '" +first_street + "'"
//elseif ai_lname = 1 and ai_dob = 1 then
//	ls_where = ls_where + " upper(oig_data.lastname) = '" + lname + "' and oig_data.dob = '" + dob + "'"
//elseif ai_fname = 1 and ai_dob = 1 then
//	ls_where = ls_where + " upper(oig_data.firstname) = '" + first_street + "' and oig_data.dob = '" + dob + "'"
//elseif ai_lname = 1 then
//	ls_where = ls_where + " upper(oig_data.lastname) = '" + lname + "'"
//elseif ai_fname = 1 then
//	ls_where = ls_where + " upper(oig_data.firstname) = '" + first_street + "'"
//elseif ai_dob = 1 then
//	ls_where = ls_where + " oig_data.dob = '" + dob + "'"
//elseif ai_bus = 1 then  //Start Code Change ----08.24.2010 #V10 maha - for business name
//	ls_where = ls_where + " upper(oig_data.busname) = '" + lname + "'"
//else
//	//messagebox("","No match criteria selected")
//	messagebox("Select Criteria","No match criteria was selected")
//	return "Fail"
//end if

 
ls_where += ") "

//messagebox("",ls_where)


return ls_where
end function

public function integer of_prac_mass (gs_batch_search ast_pracs);//Start Code Change ----06.24.2013 #V14 maha - created for huge number of retrieved pracs
gs_batch_search lst_search
long ll_pracs[]
long ll_ret[]
long ll_blank[]
long rc
long ll_cur
long li_l1
long li_l2
long li_upper
long li_loops
long li_mod
datastore lds_pracs


lds_pracs = create datastore
lds_pracs.dataobject = dw_prac_list.dataobject
lds_pracs.settransobject(sqlca) 

lst_search = ast_pracs

//get prac list
ll_pracs = lst_search.li_prac_id[]
rc = upperbound(ll_pracs )

//break down into smaller batches
li_loops = rc/10000 //number of batches
li_mod = mod(rc, 10000) //remainder
if li_mod > 0 then li_loops++

//messagebox("rc",rc)
//messagebox("li_loops",li_loops)
//messagebox("li_mod",li_mod)


for li_l1 = 1 to li_loops
	if li_l1 < li_loops then
		li_upper = 10000
	else
		li_upper = li_mod
	end if
	ll_ret[] = ll_blank[]   //Start Code Change ----12.17.2015 #V15 maha - clear array
	//messagebox("li_upper",li_upper)
	for li_l2 = 1 to li_upper  //li_mod   //Start Code Change ----12.17.2015 #V15 maha - corrected variable
		ll_cur++
		ll_ret[li_l2] = lst_search.li_prac_id[ll_cur]
	next
	lds_pracs.retrieve(ll_ret)
	lds_pracs.rowscopy( 1, lds_pracs.rowcount(),primary!, dw_prac_list, 1000000, primary!)
next

destroy lds_pracs

return 1
end function

public function string of_set_filter (integer ai_row, integer ai_lname, integer ai_fname, integer ai_dob, integer ai_npi);long i
long ic
long r
long rc
integer p
string lname
string first_street
string ls_zip
string syear
string smonth
string sday
string ls_oig_1
string ls_oig_2
string ls_oig_3
string ls_oig_4
date d_dob
string dob
string ls_npi
string ls_where1
string ls_where2
string ls_where3
string ls_where4
string ls_where = " ("
string ls_maiden  //maha 10.23.2017
string ls_maiden_first  //maha 10.23.2017
n_cst_string ln_string



//Start Code Change ----06.21.2013 #V14 maha - redesigned for alternate search type for business and redesigned clause creation
if is_type = "P" then
	lname = upper(dw_prac_list.getitemstring(ai_row,"last_name"))
	//---------Begin Modified by (Appeon)Stephen 2013-09-09 for Bug 3661 OIG Scan error--------
	//ls_oig_1 = " upper(oig_data.lastname) "
	ls_oig_1 = " upper(lastname) "
	//---------End Modfiied ------------------------------------------------------
else
	lname = upper(dw_prac_list.getitemstring(ai_row,"last_name"))
	//---------Begin Modified by (Appeon)Stephen 2013-09-09 for Bug 3661 OIG Scan error--------
	//ls_oig_1 = " upper(oig_data.busname) "
	ls_oig_1 = " upper(busname) "
	//---------End Modfiied ------------------------------------------------------
end if
//do until p < 1
	p = PosA(lname,"'",1) 
if p > 0 then
	lname = MidA(lname,1,p - 1) + "'" + MidA(lname,p )
end if

p = PosA(first_street,"'",1) 
if p > 0 then
	lname = MidA(first_street,1,p - 1) + "'" + MidA(first_street,p  )
end if

if is_type = "P" then
	first_street = upper(dw_prac_list.getitemstring(ai_row,"first_name"))
	//---------Begin Modified by (Appeon)Stephen 2013-09-09 for Bug 3661 OIG Scan error--------
	//ls_oig_2 = " upper(oig_data.firstname) "
	ls_oig_2 = " upper(firstname) "
	//---------End Modfiied ------------------------------------------------------
else
	first_street = upper(dw_prac_list.getitemstring(ai_row,"street_2"))
	//---------Begin Modified by (Appeon)Stephen 2013-09-09 for Bug 3661 OIG Scan error--------
	//ls_oig_2 = " upper(oig_data.address) "
	ls_oig_2 = " upper(address) "
	//---------End Modfiied ------------------------------------------------------	
end if

if isnull(first_street) then first_street = ""

//lname = ln_string.of_globalreplace(lname, "''", "'", False)
//lname = ln_string.of_globalreplace(lname, "'", "''", False)
//lname = ln_string.of_globalreplace(lname, '"', '', False)

first_street = ln_string.of_globalreplace(first_street, "''", "'", False)
first_street = ln_string.of_globalreplace(first_street, "'", "''", False)
first_street= ln_string.of_globalreplace(first_street, '"', '', False)



//Start Code Change ----10.23.2017 #V16 maha
p = pos(ls_maiden, " ", 1)
if p > 0 then
	ls_maiden_first = mid(ls_maiden, 1, p - 1)
	ls_maiden = mid(ls_maiden,  p + 1)
else
	ls_maiden_first = ""
end if
//End Code Change ----10.23.2017 


if is_type = "P" then
	d_dob = date(dw_prac_list.getitemdatetime(ai_row,"date_of_birth"))
	syear = MidA(string(year(d_dob)),3,2)
	smonth = string(month(d_dob))
	sday = string(day(d_dob))
	//---------Begin Added by (Appeon)Stephen 2013-09-09 for Bug 3661 OIG Scan error--------
	if isnull(syear) then syear ='0'
	if isnull(smonth) then smonth ='0'
	if isnull(sday) then sday ='0'
	//---------End Added ------------------------------------------------------
	
	if LenA(smonth) = 1 then smonth = "0" + smonth
	if LenA(sday) = 1 then sday = "0" + sday
	dob = smonth + "/" + sday + "/" + syear
	if isnull(dob) then dob = ""
	//---------Begin Modified by (Appeon)Stephen 2013-09-09 for Bug 3661 OIG Scan error--------
	//ls_oig_3 = " oig_data.dob "
	ls_oig_3 = " dob "
	//---------End Modfiied ------------------------------------------------------	
else
	dob = mid(dw_prac_list.getitemstring(ai_row,"zip"),1,5) //oig data contains only 5 digits
	//---------Begin Modified by (Appeon)Stephen 2013-09-09 for Bug 3661 OIG Scan error--------
	//ls_oig_3 = " oig_data.zip "
	ls_oig_3 = " zip "
	//---------End Modfiied ------------------------------------------------------	
end if

//for both npi
ls_npi = dw_prac_list.getitemstring(ai_row,"npi_number")
//---------Begin Modified by (Appeon)Stephen 2013-09-09 for Bug 3661 OIG Scan error--------
//ls_oig_4 = " oig_data.npi_num "  //maha 08.08.2013  corrected field name
ls_oig_4 = " npi_num "
//---------End Modfiied ------------------------------------------------------

ls_where1 = ls_oig_1 + ' = "'+ lname  + '"'
ls_where2 = ls_oig_2 + ' = "'+ first_street  + '"'
ls_where3 = ls_oig_3 + ' = "' + dob  + '"'
ls_where4 = ls_oig_4 + ' = "' + ls_npi + '"'

//ls_where1 = ls_oig_1 + " = '" + lname  + "'"
//ls_where2 = ls_oig_2 + " = '" + first_street + "'" 
//ls_where3 = ls_oig_3 + " = '" + dob  + "'"
//ls_where4 = ls_oig_4 + " = '" + ls_npi + "'"

//Start Code Change ----10.23.2017 #V16 maha
if is_type = "P" and ii_maid = 1 then  //Start Code Change ----09.07.2017 #V154 maha - for maiden name search
	if len(ls_maiden_first) > 0 then
		ls_where1 = "(" + ls_where1 + " OR " + ls_oig_1 + " = '" + ls_maiden  + "' )"
	end if
	
	if len(ls_maiden_first) > 0 then
		ls_where2 = "(" + ls_where2 + " OR " + ls_oig_1 + " = '" + ls_maiden_first  + "' )"
	end if
end if
//End Code Change ----10.23.2017

if ai_lname = 1 then 
	if not isnull(ls_where1) then //(Appeon)Stephen 2013-08-15 - Bug 3630
		ls_where+= ls_where1
	end if
end if

if ai_fname = 1 then
	if not isnull(ls_where2) then //(Appeon)Stephen 08.15.2013 - Bug 3630
		if len(ls_where) > 8 then  ls_where+= " AND "
		 ls_where+= ls_where2
	end if
end if

if ai_dob = 1 then
	if not isnull(ls_where3) then //(Appeon)Stephen 08.15.2013 - Bug 3630
		if len(ls_where) > 8 then  ls_where+= " AND "
		 ls_where+= ls_where3
	end if
end if

if ai_npi = 1 then
	if not isnull(ls_where4) then //(Appeon)Stephen 08.15.2013 - Bug 3630
		if len(ls_where) > 8 then  ls_where+= " AND "
		 ls_where+= ls_where4
	end if
end if
	

ls_where += ") "

return ls_where
end function

public function integer of_add_log (long al_prac, integer ai_cnt);//Start Code Change ----03.26.2014 #V14.2 maha - created
long r

r = dw_log.insertrow(0)
dw_log.setitem(r,"prac_id",al_prac)
dw_log.setitem(r,"scan_date", datetime(today(),now()) )
dw_log.setitem(r,"result_count",ai_cnt)
dw_log.setitem(r,"match_on",ii_matchon)
dw_log.setitem(r,"run_by",gs_user_id)

return 1

end function

on w_oig_on_demand.create
this.cb_4=create cb_4
this.cbx_maiden=create cbx_maiden
this.cb_log_view=create cb_log_view
this.dw_log=create dw_log
this.cb_log=create cb_log
this.cb_batch=create cb_batch
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cbx_npi=create cbx_npi
this.st_pname=create st_pname
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_cancel=create cb_cancel
this.cb_clear=create cb_clear
this.cb_print=create cb_print
this.st_added=create st_added
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_view=create cb_view
this.cb_done=create cb_done
this.cb_scan=create cb_scan
this.cbx_dob=create cbx_dob
this.cbx_first=create cbx_first
this.cbx_last=create cbx_last
this.cb_search=create cb_search
this.gb_1=create gb_1
this.dw_verifs=create dw_verifs
this.dw_oig_data=create dw_oig_data
this.cb_none=create cb_none
this.gb_2=create gb_2
this.dw_prac_list=create dw_prac_list
this.dw_copied=create dw_copied
this.Control[]={this.cb_4,&
this.cbx_maiden,&
this.cb_log_view,&
this.dw_log,&
this.cb_log,&
this.cb_batch,&
this.rb_2,&
this.rb_1,&
this.cbx_npi,&
this.st_pname,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.cb_cancel,&
this.cb_clear,&
this.cb_print,&
this.st_added,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_view,&
this.cb_done,&
this.cb_scan,&
this.cbx_dob,&
this.cbx_first,&
this.cbx_last,&
this.cb_search,&
this.gb_1,&
this.dw_verifs,&
this.dw_oig_data,&
this.cb_none,&
this.gb_2,&
this.dw_prac_list,&
this.dw_copied}
end on

on w_oig_on_demand.destroy
destroy(this.cb_4)
destroy(this.cbx_maiden)
destroy(this.cb_log_view)
destroy(this.dw_log)
destroy(this.cb_log)
destroy(this.cb_batch)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cbx_npi)
destroy(this.st_pname)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_cancel)
destroy(this.cb_clear)
destroy(this.cb_print)
destroy(this.st_added)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_view)
destroy(this.cb_done)
destroy(this.cb_scan)
destroy(this.cbx_dob)
destroy(this.cbx_first)
destroy(this.cbx_last)
destroy(this.cb_search)
destroy(this.gb_1)
destroy(this.dw_verifs)
destroy(this.dw_oig_data)
destroy(this.cb_none)
destroy(this.gb_2)
destroy(this.dw_prac_list)
destroy(this.dw_copied)
end on

event open;string ls_auto
string ls_from
string ls_verif
integer i
date ld_imp
integer res
integer li_field

is_verif = MidA(message.stringparm,1,1)
is_auto = MidA(message.stringparm,2,1)
is_from = MidA(message.stringparm,3,1)

select lookup_code into :il_notfound from code_lookup where lookup_code = 11026;

If il_notfound < 1 or isnull(il_notfound) then
	messagebox("Lookup not found","Unable to find the lookup record for Match not found.  Contact customer support")
end if

//Start Code Change ----06.24.2013 #V14 maha - add new fields on the fly.
if gs_dbtype = "ASA" then
	select count(sys.syscolumn.column_name) into :li_field from sys.syscolumn ,  sys.systable t where sys.syscolumn.table_id=t.table_id and  sys.syscolumn.column_name='npi_num' and t.table_name='oig_data';
else
	select count(syscolumns.name) into :li_field from syscolumns , sysobjects where syscolumns.id=sysobjects.id and   syscolumns.name='npi_num' and sysobjects.name='oig_data' and sysobjects.type = 'U';
end if

if li_field = 0 then 
	string ls_sql
	
	 ls_sql = "alter table oig_data add npi_num varchar(15) "
	 EXECUTE Immediate :ls_sql Using Sqlca;
	 ls_sql = " alter table oig_data add wvrdate varchar(15) "
	 EXECUTE Immediate :ls_sql Using Sqlca;
	  ls_sql = " alter table oig_data add wvrstate varchar(15) "
	 EXECUTE Immediate :ls_sql Using Sqlca;
	 
	COMMIT Using Sqlca;
end if
//Start Code Change ----06.24.2013	 
	  
//is_verif - *V* = comes from verifications ; M = on demand search 
//is_auto -  *A* = automatic;  S = manual scan
//is_from -  *A* = action items; P = practitioner folder; N = on demand search(not verification) - determines what happens when done is clicked.

select last_oig_update into :ld_imp from ids;
id_last_update = ld_imp  //Start Code Change ----05.03.2011 #V11 maha 

if isnull(ld_imp) then
	res = messagebox("OIG Data","Do you wish to download the update from the OIG website now?",question!,yesno!,1)
elseif RelativeDate ( ld_imp, 30) < today() then 
	res = messagebox("OIG Data","The last update of the OIG data was " + string(ld_imp) + ".~rDo you wish to download the update from the OIG website now?",question!,yesno!,1)
end if
if res = 1 then 
	close(this)
	open(w_import_oig)
	return
end if


if is_verif = "V" then
	cb_search.enabled = false
	cb_batch.enabled = false
end if
	

if is_auto = "A" then
	cb_search.enabled = false
	cb_batch.enabled = false
	cb_scan.enabled = false
	dw_oig_data.enabled = false
end if
	



end event

type cb_4 from commandbutton within w_oig_on_demand
boolean visible = false
integer x = 2734
integer y = 176
integer width = 247
integer height = 92
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter test"
end type

event clicked;of_set_filter(1, 1, 1, 1, 0)
end event

type cbx_maiden from checkbox within w_oig_on_demand
integer x = 2487
integer y = 68
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Maiden name"
end type

event clicked;//Start Code Change ----09.07.2017 #V154 maha

if this.checked = true then
	ii_maid = 1
else
	ii_maid = 0
end if
end event

type cb_log_view from commandbutton within w_oig_on_demand
integer x = 3200
integer y = 48
integer width = 443
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Log Report"
end type

event clicked;open(w_oig_scan_log)

end event

type dw_log from datawindow within w_oig_on_demand
boolean visible = false
integer x = 3515
integer y = 80
integer width = 105
integer height = 64
integer taborder = 160
string title = "none"
string dataobject = "d_oig_scan_log_add"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject( sqlca)
end event

type cb_log from commandbutton within w_oig_on_demand
boolean visible = false
integer x = 2843
integer y = 292
integer width = 457
integer height = 84
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Log Scan Data"
end type

event clicked;//Start Code Change ----12.12.2013 #V14 maha - added for 14.2
long r
long rc
long ll_pracs[]
long nr
datetime ld_now

dw_prac_list.setfilter("selected = 1")
dw_prac_list.filter()

rc = dw_prac_list.rowcount()

if rc = 0 then return

ld_now = datetime(today(),now())

for r = 1 to rc
	ll_pracs[r] = dw_prac_list.getitemnumber(r,"prac_id")
next

for r = 1 to rc
	nr = dw_prac_list.insertrow(0)
	dw_prac_list.setitem(r, "prac_id", ll_pracs[r])
	dw_prac_list.setitem(r, "run_by", gs_user_id )  //varable in function
	dw_prac_list.setitem(r, "scan_date", ld_now)
	dw_prac_list.setitem(r, "result_count", dw_prac_list.getitemnumber(r,"matchfound"))
next

dw_prac_list.update()
	
		

end event

type cb_batch from commandbutton within w_oig_on_demand
integer x = 521
integer y = 176
integer width = 457
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Batch Search"
end type

event clicked;//return

gs_batch_search lst_search
long i
long ic
long r
long rc
long pracids[]
string names[]
string ls_openstring

ls_openstring = "R*ALL" 


openwithparm(w_batch_prac_select_new,ls_openstring)


if message.stringparm = "Cancel" then
	return

else 
	lst_search = message.powerobjectparm
	
	pracids[] = lst_search.li_prac_id[]
	names[] = lst_search.ls_name[]
	ic = upperbound(pracids[]) 
	
	//Start Code Change ----06.24.2013 #V14 maha - break down large volumns
	if ic > 10000 then
		of_prac_mass(lst_search)
		ic = dw_prac_list.rowcount()
	else
		dw_prac_list.settransobject(sqlca)
		ic = dw_prac_list.retrieve(pracids[])
	end if
	//Start Code Change ----06.24.2013 
end if

end event

type rb_2 from radiobutton within w_oig_on_demand
integer x = 352
integer y = 64
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Business"
end type

event clicked;of_change_label("B")
is_type = "B"
dw_prac_list.dataobject = "d_oig_bus_match_data"
end event

type rb_1 from radiobutton within w_oig_on_demand
integer x = 59
integer y = 68
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Person"
boolean checked = true
end type

event clicked;of_change_label("P")
is_type = "P"
dw_prac_list.dataobject = "d_oig_prac_match_data"
end event

type cbx_npi from checkbox within w_oig_on_demand
integer x = 2085
integer y = 68
integer width = 375
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "NPI Number"
end type

event clicked;//Start Code Change ----08.24.2010 #V10 maha - added 08.24.2010 - this checkbox stands alone

if this.checked = true then
	ii_bus = 1
else
	ii_bus = 0
end if


end event

type st_pname from statictext within w_oig_on_demand
integer x = 59
integer y = 1608
integer width = 654
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 80269524
long backcolor = 33551856
boolean enabled = false
string text = "Prac name"
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_oig_on_demand
integer x = 2354
integer y = 180
integer width = 370
integer height = 84
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Export Report"
end type

event clicked;gnv_dw.of_SaveAs(dw_copied) //.saveas() Modify by Evan 05.11.2010
end event

type cb_2 from commandbutton within w_oig_on_demand
integer x = 3351
integer y = 180
integer width = 800
integer height = 84
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Verify match using OIG Web Site"
end type

event clicked;//Access to the OIG home site for verifying match


String sle_url
inet iinet_base


if gi_citrix = 1 then //maha 040508
	of_open_web("http://exclusions.oig.hhs.gov/search.html")
else
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 06.23.2006 By: Liang QingShi
	//$<reason>  GetContextService is currently unsupported. 
	//$<modification> Replace GetContextService with ShellExecuteA to provide the
	//$<modification> same functionality.
	/*
	GetContextService("Internet", iinet_base)
	iinet_base.HyperlinkToURL("http://exclusions.oig.hhs.gov/search.html")
	*/
	String ls_url,ls_null
	setnull(ls_null)
	ls_url = "http://exclusions.oig.hhs.gov/"  //Start Code Change ----09.17.2013 #V14 maha - corrected url
	//---------Begin Modified by (Appeon)Harry 04.27.2015 for Keep Everything under One Browser--------
	//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_url , ls_Null, 4)
	ShellExecuteA (Handle( This ), "open", of_getbrowserversion( ), ls_url, ls_Null, 4)
	//---------End Modfiied ------------------------------------------------------
	//---------------------------- APPEON END ----------------------------
	
end if

end event

type cb_1 from commandbutton within w_oig_on_demand
integer x = 1006
integer y = 176
integer width = 178
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Sort"
end type

event clicked;string null_str

SetNull(null_str)

dw_prac_list.SetSort(null_str)

dw_prac_list.Sort( )
end event

type cb_cancel from commandbutton within w_oig_on_demand
integer x = 3653
integer y = 48
integer width = 247
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;close(parent)
end event

type cb_clear from commandbutton within w_oig_on_demand
integer x = 2994
integer y = 180
integer width = 343
integer height = 84
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Clear Report"
end type

event clicked;dw_copied.reset()

st_added.text = "Report has " + string(dw_copied.rowcount()) + " records."
end event

type cb_print from commandbutton within w_oig_on_demand
integer x = 1998
integer y = 180
integer width = 338
integer height = 84
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print &Report"
end type

event clicked;
	dw_copied.print()

end event

type st_added from statictext within w_oig_on_demand
integer x = 2350
integer y = 1616
integer width = 526
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Report has 0 records"
boolean focusrectangle = false
end type

type st_3 from statictext within w_oig_on_demand
integer x = 73
integer y = 2180
integer width = 686
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
boolean enabled = false
boolean focusrectangle = false
end type

type st_2 from statictext within w_oig_on_demand
integer x = 727
integer y = 1612
integer width = 1536
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Double click matched record to add to report list."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_oig_on_demand
integer x = 50
integer y = 292
integer width = 2615
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Double click Name to search, or click Scan List to scan all records selected."
boolean focusrectangle = false
end type

type cb_view from commandbutton within w_oig_on_demand
integer x = 1641
integer y = 180
integer width = 338
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&View Report"
end type

event clicked;
if dw_copied.visible = false then
	dw_copied.visible = true
	this.text = "Hide Report"
else
	dw_copied.visible = false
	this.text = "&View Report"
end if
end event

type cb_done from commandbutton within w_oig_on_demand
integer x = 3913
integer y = 48
integer width = 247
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Done"
end type

event clicked;long pracid
integer i
integer ic
integer f
string ls_stype
integer cnt
integer li_sent
long ll_code
long ll_match
long ll_recid
string ls_sanct_code
integer res
integer li_facility_id
integer li_screen_id
pfc_n_cst_ai_action_items inv_action_items



if is_verif = "V" then //do following only if from verifications

	if is_from = "A" then//only if from action items 
		inv_action_items = create pfc_n_cst_ai_action_items
	end if
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-03
	//$<modify> 02.16.2006 By: Wangchao
	//$<reason> Performance tuning
	//$<reason> Reduce client-server interactions to improve runtime performance.
	//$<modification> Write script to retrieve data from a cache instead of from the database.

	
	/*
	select lookup_code into :ll_code from code_lookup where lookup_name = 'Credentials Verification Response' and code = 'SAT OIG';
	*/
	
	ll_code = long(gnv_data.of_getitem("code_lookup" ,'lookup_code', "upper(lookup_name) = '" + upper('Credentials Verification Response') + "'" + " and upper(code) = 'SAT OIG'"))
	//---------------------------- APPEON END ----------------------------
	
	//select lookup_code into :ll_match from code_lookup where lookup_name = 'OIG Sanctions' and code = '';

	//create data to send back to verification list
	for i = 1 to dw_prac_list.rowcount()
		pracid = dw_prac_list.getitemnumber(i,"prac_id")
		f = dw_verifs.find( "prac_id = " + string(pracid), 1, dw_verifs.rowcount() )
		//
		//messagebox("f",f)
		if f > 0 then
			cnt = dw_prac_list.getitemnumber(i,"matchfound")
			if isnull(cnt) then cnt = 0
			
			
			//get sanction description
			ls_stype = dw_prac_list.getitemstring(i,"cust_10")
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-04
			//$<modify> 02.16.2006 By: Wangchao
			//$<reason> Performance tuning
			//$<reason> Reduce client-server interactions to improve runtime performance.
			//$<modification> Write script to retrieve data from a cache instead of from the database.
					
			/*
			select description into :ls_sanct_code from code_lookup where lookup_name = 'OIG Sanctions' and code = :ls_stype;
			*/
			
			ls_sanct_code = gnv_data.of_getitem("code_lookup" ,'description', "upper(lookup_name) = '" + upper('OIG Sanctions') + "'" + " and upper(code) = '" + upper(ls_stype) + "'")
			//---------------------------- APPEON END ----------------------------
			
			//set sent data
			if isnull(dw_verifs.getitemdatetime(f,"first_sent")) then dw_verifs.setitem(f,"first_sent",datetime(today(),now()))
			dw_verifs.setitem(f,"last_sent",datetime(today(),now()))
			li_sent = dw_verifs.getitemnumber(f,"number_sent")
			//---------Begin Added by (Appeon)Stephen 09.02.2016 for V15.1 Bug # 5314 - OIG scan is preventing Verif. Complete from auto populating as well as the light turning green--------
			li_facility_id = dw_verifs.getitemnumber(f, "verif_info_facility_id" )
			li_screen_id = dw_verifs.getitemnumber(f, "screen_id" )
			//---------End Added ------------------------------------------------------
			if isnull(li_sent) then
				dw_verifs.setitem(f,"number_sent",1)
			else
				li_sent++
				dw_verifs.setitem(f,"number_sent",li_sent)
			end if
			dw_verifs.setitem(f,"print_flag",0)
			//set completed
			if cnt = 0 then
				//	messagebox("cnt","0")
				dw_verifs.setitem(f,"date_recieved",datetime(today(),now()))
				dw_verifs.setitem(f,"user_name",gs_user_id)
				dw_verifs.setitem(f,"response_code",ll_code)
				dw_verifs.setitem(f,"user_name",gs_user_id)
				//dw_verifs.setitem(f,"notes", string(cnt) + "0 matches found")
			elseif cnt = 1 then
				//messagebox("cnt","1")
				dw_verifs.setitem(f,"notes","1 match found  - " + ls_sanct_code)
			else
				//messagebox("cnt",">1")
				dw_verifs.setitem(f,"notes", string(cnt) + " matches found")
			end if
			
				
				
		end if
		
	next
	if is_auto = "A" then //ask to print report for auto scans
		If dw_copied.rowcount() > 0 then
			res = messagebox("Print Report","Do you want to print the Scan matches report?",question!,yesno!,1)
			if res = 1 then 
				dw_copied.print()
			end if
		end if
	end if
	res = dw_verifs.update()
	if res < 0 then
		messagebox("Save Error","Unable to update verifications.")
	else 
		commit using sqlca;
		if is_verif = "V" then //if from verifications reretrieve the data in the window
			if is_from = "P" then//if from prac folder
				w_prac_data_1.tab_1.tabpage_verif.uo_verif_summary.of_retrieve_detail(w_prac_data_1.tab_1.tabpage_verif.uo_verif_summary.dw_orgs_facilities.getrow() )
				w_prac_data_1.tab_1.tabpage_verif.uo_verif_summary.of_ver_filter()
				//---------Begin Added by (Appeon)Stephen 09.02.2016 for V15.1 Bug # 5314 - OIG scan is preventing Verif. Complete from auto populating as well as the light turning green--------
				w_prac_data_1.tab_1.tabpage_verif.uo_verif_summary.ii_facility_ids[1] = li_facility_id
				w_prac_data_1.tab_1.tabpage_verif.uo_verif_summary.ii_screen_ids[1] = li_screen_id
				w_prac_data_1.tab_1.tabpage_verif.uo_verif_summary.of_post_update()
				li_facility_id = w_prac_data_1.tab_1.tabpage_verif.uo_verif_summary.dw_orgs_facilities.GetItemNumber( w_prac_data_1.tab_1.tabpage_verif.uo_verif_summary.dw_orgs_facilities.GetRow(), "parent_facility_id" )
				ll_recid = w_prac_data_1.il_affil_rec_id
				w_prac_data_1.uo_app_stat.of_get_status( pracid, li_facility_id)  
				w_prac_data_1.uo_app_stat.of_get_status_rec( ll_recid )
				//---------End Added ------------------------------------------------------
			elseif is_from = "A" then//if from action items
				inv_action_items.of_filter( w_action_items.ii_org_id, w_action_items.ii_facility_id, w_action_items.is_filter, w_action_items.tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse, w_action_items.is_user_id, w_action_items.ddplb_filters )
			end if
		end if
	end if
	
	if is_from = "A" then//only if from action items
		destroy inv_action_items
	end if	
	
end if
	
	


		
		
close(parent)
end event

type cb_scan from commandbutton within w_oig_on_demand
integer x = 2912
integer y = 52
integer width = 247
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Scan &List"
end type

event clicked;long i
long ic
long r = 0
long rc


//note: ii_bus is the npi search
if ii_last < 1 and ii_first < 1 and ii_dob < 1 and ii_bus < 1 then
	//messagebox("Scan error","No match fields selected.")
	messagebox("Scan Error","No match fields were selected.")
	return
end if

dw_copied.reset()

st_added.text = "Report has " + string(dw_copied.rowcount()) + " records."

of_scan_oig_data("A",ii_last,ii_first,ii_dob,"S",ii_bus) //Start Code Change ----08.24.2010 #V10 maha

end event

type cbx_dob from checkbox within w_oig_on_demand
integer x = 1650
integer y = 60
integer width = 389
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Date of Birth"
boolean checked = true
end type

event clicked;if this.checked = true then
	ii_dob = 1
else
	ii_dob = 0
end if


end event

type cbx_first from checkbox within w_oig_on_demand
integer x = 1285
integer y = 60
integer width = 370
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "First Name"
boolean checked = true
end type

event clicked;if this.checked = true then
	ii_first = 1
else
	ii_first = 0
end if


end event

type cbx_last from checkbox within w_oig_on_demand
integer x = 791
integer y = 60
integer width = 494
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Last Name"
boolean checked = true
end type

event clicked;if this.checked = true then
	ii_last = 1
else
	ii_last = 0
end if



	
end event

type cb_search from commandbutton within w_oig_on_demand
integer x = 41
integer y = 176
integer width = 457
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Individual Search"
end type

event clicked;//Start Code Change ---- 01.19.2006 #205 maha rebuilt code
Integer nr
Integer li_find
integer i
integer ic
integer li_fac
Long ll_prac_id
String ls_full_name

gs_search lstr_string
gs_batch_search  lstr_search

lstr_string.stran_transaction = SQLCA

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-09-22 By: Rodger Wu
//$<reason> Fix a defect.

/* select default_search_facility into :li_fac from security_users; */
select default_search_facility into :li_fac from security_users where user_id = :gs_user_id; 

//---------------------------- APPEON END ----------------------------

if isnull(li_fac) then li_fac = 0

lstr_string.ls_open_for = "REPORTS" + string(li_fac)

//debugbreak()
//messagebox("", lstr_search.ls_open_for )
OpenWithParm( w_extended_search_new , lstr_string )

IF Message.DoubleParm = -1 THEN
	Return -1
END IF

lstr_search = message.powerobjectparm
 
if not isvalid(message.powerobjectparm) then return 0

ic = upperbound(lstr_search.li_prac_id)
nr = upperbound(il_pracid[])

for i = 1 to ic
	nr++
	il_pracid[nr] = lstr_search.li_prac_id[i]
next

dw_prac_list.settransobject(sqlca)
dw_prac_list.retrieve(il_pracid[])
//End Code Change---01.19.2005 


end event

type gb_1 from groupbox within w_oig_on_demand
integer x = 754
integer y = 4
integer width = 2432
integer height = 156
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Match on:"
end type

type dw_verifs from datawindow within w_oig_on_demand
boolean visible = false
integer x = 3374
integer y = 76
integer width = 128
integer height = 60
integer taborder = 150
string dataobject = "d_ver_sum_rec_view_oig"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_oig_data from datawindow within w_oig_on_demand
integer y = 1696
integer width = 4206
integer height = 844
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_oig_matched_data"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event doubleclicked;integer i

i = this.getrow()
if i > 0 then
	dw_oig_data.RowsCopy (i, i, primary!, dw_copied, 100000, primary! )
	dw_prac_list.setitem(dw_prac_list.getrow(),"matchfound",1)
	dw_prac_list.setitem(dw_prac_list.getrow(),"cust_10",dw_oig_data.getitemstring(1,"sanctype"))
		
	
end if

st_added.text = "Report has " + string(dw_copied.rowcount()) + " records."
end event

event clicked;integer li_nr

li_nr = this.getclickedrow()

this.SelectRow( 0 , False )
this.ScrollToRow( li_nr )
this.SetRow ( li_nr )
this.SelectRow( li_nr , True )
end event

event retrievestart;If ib_continue Then Return 2 //Added by Appeon long.zhang 03.25.2016 (Performance on OIG scan when using 3440 providers)
end event

type cb_none from commandbutton within w_oig_on_demand
boolean visible = false
integer x = 9
integer y = 1604
integer width = 297
integer height = 68
integer taborder = 160
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "No Match"
end type

event clicked;	dw_prac_list.setitem(dw_prac_list.getrow(),"matchfound",0)

end event

type gb_2 from groupbox within w_oig_on_demand
integer x = 32
integer y = 16
integer width = 681
integer height = 132
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Type"
end type

type dw_prac_list from datawindow within w_oig_on_demand
integer y = 380
integer width = 4206
integer height = 1204
integer taborder = 70
string dataobject = "d_oig_prac_match_data"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event doubleclicked;long pracid
long blankarray[]


st_3.text = ""
//il_pracid[] = blankarray[]

//pracid = this.getitemnumber(this.getrow(),"prac_id")
//il_pracid[1] = pracid
if ii_last < 1 and ii_first < 1 and ii_dob < 1 and ii_bus < 1 then
	//messagebox("Scan error","No match fields selected.")
	messagebox("Scan Error","No match fields were selected.")
	return
end if

of_scan_oig_data("M",ii_last,ii_first,ii_dob,"M",ii_bus) //Start Code Change ----08.24.2010 #V10 maha
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<modify> 05.05.2006 By: Liang QingShi
//$<reason> Try...CATCH... is currently unsupported.
//$<modification> Rewrite the following script and move it to of_scan_oig_data.

/*
try
if dw_oig_data.rowcount() = 0 then
	st_3.text = "No Records Found"
end if
catch (runtimeerror rte)
end try 
*/

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05.05.2006 By: Liang QingShi
//$<reason> Fix a defect.
/*
cb_none.visible = true
*/
if isvalid(w_oig_on_demand) then
	cb_none.visible = true
end if
//---------------------------- APPEON END ----------------------------
//cb_none.enabled = true
	
end event

event clicked;integer li_nr

li_nr = this.getclickedrow()

this.SelectRow( 0 , False )
this.ScrollToRow( li_nr )
this.SetRow ( li_nr )
this.SelectRow( li_nr , True )
end event

event constructor;this.settransobject(sqlca)
end event

type dw_copied from u_dw within w_oig_on_demand
boolean visible = false
integer y = 280
integer width = 4206
integer height = 2276
integer taborder = 120
boolean titlebar = true
string title = "Double click report name to hide."
string dataobject = "d_oig_matched_data_report"
boolean hscrollbar = true
boolean resizable = true
boolean livescroll = false
end type

event doubleclicked;call super::doubleclicked;this.visible = false

cb_view.text = "View Report"
end event

