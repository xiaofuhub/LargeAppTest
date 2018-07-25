$PBExportHeader$n_cst_array_db.sru
forward
global type n_cst_array_db from nonvisualobject
end type
end forward

global type n_cst_array_db from nonvisualobject
end type
global n_cst_array_db n_cst_array_db

type variables

end variables

forward prototypes
public function string of_generate_clientid ()
public function integer of_array_to_db (decimal adec_array_num[], ref string as_client_id)
public function integer of_array_to_db (string as_array_vchar[], ref string as_client_id)
public function integer of_delete_temp_data_exe (string as_where_sql)
public function integer of_delete_temp_data (string as_client_id)
public function integer of_delete_temp_data (string as_client_id[])
public function integer of_array_to_db (integer ai_array_type, decimal adec_array_num[], string as_array_vchar[], ref string as_clientid)
end prototypes

public function string of_generate_clientid ();string ls_client_id
String ls_random
gi_seq++
If AppeonGetClientType() = 'WEB' Then
	ls_client_id = AppeonGetClientID() + String(gi_seq) 	
Else
	ls_random = String(Rand(30000),'00000')
	ls_client_id = String(today(),'yymmddhhmmssfff') +ls_random 
End If
Return ls_client_id
end function

public function integer of_array_to_db (decimal adec_array_num[], ref string as_client_id);String ls_null[]
Integer li_ret
If UpperBound(adec_array_num[]) = 0 Then Return 0
li_ret = of_array_to_db(1,adec_array_num[],ls_null[],as_client_id)
Return li_ret
end function

public function integer of_array_to_db (string as_array_vchar[], ref string as_client_id);Decimal ldec_null[]
Integer li_ret
If UpperBound(as_array_vchar[]) = 0 Then Return 0
li_ret = of_array_to_db(2,ldec_null[],as_array_vchar[],as_client_id)
Return li_ret
end function

public function integer of_delete_temp_data_exe (string as_where_sql);//Delete Temp data
String ls_sql1,ls_sql2
ls_sql1 = "Delete From ic_client_data Where " + as_where_sql
ls_sql2 = "Delete From ic_array_to_db Where " + as_where_sql
gnv_appeondb.of_startqueue()
EXECUTE IMMEDIATE :ls_sql1 USING SQLCA ;
EXECUTE IMMEDIATE :ls_sql2 USING SQLCA ;
commit;
gnv_appeondb.of_commitqueue()
Return 1

end function

public function integer of_delete_temp_data (string as_client_id);Int li_ret
String ls_where_sql
ls_where_sql = " client_id = '" + as_client_id + "'"
li_ret = of_delete_temp_data_exe(ls_where_sql)
Return li_ret
end function

public function integer of_delete_temp_data (string as_client_id[]);Int i,li_ret
String ls_where_sql
//---------Begin Added by (Appeon)Toney 06.06.2013 for V141 ISG-CLX--------
//$Reason:Check arguments
//Added By Mark Lee 08/02/12	bugger
If Isnull(as_client_id) Or UpperBound(as_client_id[]) <= 0 Then
	Return 0
End If 
//---------End Added ------------------------------------------------------------------

For i = 1 to UpperBound(as_client_id[])
	If i = 1 Then
		ls_where_sql = " client_id = '" + as_client_id[i] + "'" 
	Else
		ls_where_sql += " Or client_id = '" + as_client_id[i] + "'"
	End If
Next
li_ret = of_delete_temp_data_exe(ls_where_sql)
Return li_ret
end function

public function integer of_array_to_db (integer ai_array_type, decimal adec_array_num[], string as_array_vchar[], ref string as_clientid);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_array_dbof_array_to_db()
// $<arguments>
//		value    	integer	ai_array_type  (1:numeric; 2:String) 		
//		value    	decimal	adec_array_num[]		
//		value    	string 	as_array_vchar[]		
//		reference	decimal	adec_client_id  		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 10/25/2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long i,j,ll_arr_count,ll_db_count,ll_count
Boolean lb_autocommit
String ls_random
Integer li_exist = 1, li_sum , ll_ret
String ls_text[]
Long ll_arraydb_count
j = 1

//Generate random Client ID
Do While li_exist > 0
	If li_sum >= 10 Then Return -3
	as_clientid = of_generate_clientid()
	Select count(*) into :li_exist From ic_client_data Where client_id = :as_clientid;
	li_sum++
Loop

//User auto commit for multi-user use it 
lb_autocommit = SQLCA.autocommit
SQLCA.autocommit = True


//Insert array data to DB----
//-Generate array to string array var.
If ai_array_type = 1 Then //Numeric Type
	ll_arr_count = UpperBound(adec_array_num[])
	For i = 1 To ll_arr_count
		ls_text[j] +=  String(adec_array_num[i]) + ','
		If LenA(ls_text[j]) > 2000 Then //vchar need less than 8000 in DB, and JS run slow performance when large string var add other string, so set total is 2000.
			ls_text[j] = MidA( ls_text[j],1,(LenA(ls_text[j]) - 1) ) //Delete last char ';'
			J++
		End If		
	Next
	ls_text[j] = MidA( ls_text[j],1,(LenA(ls_text[j]) - 1) ) //Delete last char ';'
ElseIf ai_array_type = 2 Then //String Type
	ll_arr_count = UpperBound(as_array_vchar[])
	For i = 1 To ll_arr_count
		ls_text[j] +=  as_array_vchar[i] + ','
		If LenA(ls_text[j]) > 2000 Then //vchar need less than 8000 in DB, and JS run slow performance when large string var add other string, so set total is 2000.
			ls_text[j] = MidA( ls_text[j],1,(LenA(ls_text[j]) - 1) ) //Delete last char ';'
			J++
		End If
	Next	
	ls_text[j] = MidA( ls_text[j],1,(LenA(ls_text[j]) - 1) ) //Delete last char ';'
Else
	//Unsupport other type
End If

//-Insert string array var to DB
gnv_appeondb.of_startqueue()
Delete from ic_array_to_db where client_id = :as_clientid ; //Delete data if exist.
ll_arraydb_count = Upperbound(ls_text[])
If ll_arraydb_count > 0 Then
	For i = 1 to ll_arraydb_count
		Insert Into ic_array_to_db(client_id,seq_no,data) values(:as_clientid,:i,:ls_text[i]);
	Next

 DECLARE lup_array_to_db PROCEDURE FOR up_array_to_row  
        :as_clientid,
		  :ai_array_type,
		  :ll_arraydb_count;
		  
 Execute lup_array_to_db;
 Select Count(*) into :ll_count from ic_client_data where client_id = :as_clientid;
End If
gnv_appeondb.of_commitqueue()

//Insert failed.
If ll_arr_count <> ll_count Then
	//Delete bad data
	of_delete_temp_data(as_clientid)
	SQLCA.autocommit = lb_autocommit
	Return -1 
End If

SQLCA.autocommit = lb_autocommit
Return 1
end function

on n_cst_array_db.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_array_db.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

