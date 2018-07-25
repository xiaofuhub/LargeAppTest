$PBExportHeader$n_cst_right.sru
forward
global type n_cst_right from nonvisualobject
end type
end forward

global type n_cst_right from nonvisualobject
end type
global n_cst_right n_cst_right

forward prototypes
public subroutine of_filter_right (ref datawindow adw_data, string as_colname, integer ai_type)
public subroutine of_filter_right (ref datastore adw_data, string as_colname, integer ai_type)
public subroutine of_filter_right (ref datawindowchild adw_data, string as_colname, integer ai_type)
public function string of_getfilter (string as_col, integer ai_type)
end prototypes

public subroutine of_filter_right (ref datawindow adw_data, string as_colname, integer ai_type);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_rightof_filter_right()
// $<arguments>
//		reference	datawindow	adw_data  		
//		value    	string    	as_colname		
//		value    	integer   	ai_type   //3:Template;4:Document		
// $<returns> (none)
// $<description> If role have no right to access the category,need filter the record in dw.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 03-04-2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////


string ls_category,ls_type
long i,ll_count,ll_find
datastore lds_category_access
lds_category_access = Create datastore
lds_category_access.dataobject = 'd_category_no_access'
lds_category_access.settransobject(sqlca)
lds_category_access.retrieve(gs_user_id,ai_type)
ll_count = adw_data.rowcount()
If ll_count < 1 Then Return 
If lds_category_access.rowcount() < 1 Then Return 

ls_type = adw_data.Describe(as_colname+'.coltype')
If lower(Left(ls_type,4)) = 'char' Then
	ls_type = 'S'  //Category Name
Else
	ls_type = 'N' //Category ID
End If

For i = ll_count To 1 step -1
	If ls_type = 'S' Then
		ls_category = adw_data.GetItemString(i,as_colname)
		If lds_category_access.find( 'code = "'+ls_category+'"',1, lds_category_access.rowcount()) > 0 Then
			adw_data.deleterow(i)
		End If		
	Else
		ls_category = String(adw_data.GetitemNumber(i,as_colname))
		If lds_category_access.find( 'lookup_code = '+ls_category,1, lds_category_access.rowcount()) > 0 Then
			adw_data.deleterow(i)
		End If		
	End If
Next


end subroutine

public subroutine of_filter_right (ref datastore adw_data, string as_colname, integer ai_type);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_rightof_filter_right()
// $<arguments>
//		reference	datastore	adw_data  		
//		value    	string    	as_colname	//Category_ID or Category_Name	
//		value    	integer   	ai_type   //3:Template;4:Document		
// $<returns> (none)
// $<description> If role have no right to access the category,need filter the record in dw.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 03-04-2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_type
string ls_category
long i,ll_count,ll_find
datastore lds_category_access
lds_category_access = Create datastore
lds_category_access.dataobject = 'd_category_no_access'
lds_category_access.settransobject(sqlca)
lds_category_access.retrieve(gs_user_id,ai_type)
ll_count = adw_data.rowcount()
If ll_count < 1 Then Return 
If lds_category_access.rowcount() < 1 Then Return 

ls_type = adw_data.Describe(as_colname+'.coltype')
If lower(Left(ls_type,4)) = 'char' Then
	ls_type = 'S'  //Category Name
Else
	ls_type = 'N' //Category ID
End If

For i = ll_count To 1 step -1
	If ls_type = 'S' Then
		ls_category = adw_data.GetItemString(i,as_colname)
		If lds_category_access.find( 'code = "'+ls_category+'"',1, lds_category_access.rowcount()) > 0 Then
			adw_data.deleterow(i)
		End If		
	Else
		ls_category = String(adw_data.GetitemNumber(i,as_colname))
		If lds_category_access.find( 'lookup_code = '+ls_category,1, lds_category_access.rowcount()) > 0 Then
			adw_data.deleterow(i)
		End If		
	End If
Next
end subroutine

public subroutine of_filter_right (ref datawindowchild adw_data, string as_colname, integer ai_type);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_rightof_filter_right()
// $<arguments>
//		reference	datastore	adw_data  		
//		value    	string    	as_colname		
//		value    	integer   	ai_type   //3:Template;4:Document		
// $<returns> (none)
// $<description> If role have no right to access the category,need filter the record in dw.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 03-04-2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////


string ls_category,ls_type
long i,ll_count,ll_find
datastore lds_category_access
lds_category_access = Create datastore
lds_category_access.dataobject = 'd_category_no_access'
lds_category_access.settransobject(sqlca)
lds_category_access.retrieve(gs_user_id,ai_type)
ll_count = adw_data.rowcount()
If ll_count < 1 Then Return 
If lds_category_access.rowcount() < 1 Then Return 


ls_type = adw_data.Describe(as_colname+'.coltype')
If lower(Left(ls_type,4)) = 'char' Then
	ls_type = 'S'  //Category Name
Else
	ls_type = 'N' //Category ID
End If

For i = ll_count To 1 step -1
	If ls_type = 'S' Then
		ls_category = adw_data.GetItemString(i,as_colname)
		If lds_category_access.find( 'code = "'+ls_category+'"',1, lds_category_access.rowcount()) > 0 Then
			adw_data.deleterow(i)
		End If		
	Else
		ls_category = String(adw_data.GetitemNumber(i,as_colname))
		If lds_category_access.find( 'lookup_code = '+ls_category,1, lds_category_access.rowcount()) > 0 Then
			adw_data.deleterow(i)
		End If		
	End If
Next


end subroutine

public function string of_getfilter (string as_col, integer ai_type);
//////////////////////////////////////////////////////////////////////
// $<function>n_cst_rightof_getfilter()
// $<arguments>
//		value	string 	as_col 		
//		value	integer	ai_type		
// $<returns> string
// $<description> Get filter condition
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 04-04-2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_filter
decimal ldec_colvalue
Long i,ll_count
datastore lds_category_access
lds_category_access = Create datastore
lds_category_access.dataobject = 'd_category_no_access'
lds_category_access.settransobject(sqlca)
lds_category_access.retrieve(gs_user_id,ai_type)
ll_count = lds_category_access.rowcount()
if ll_count < 1 then return '1=1'

For i = 1 To ll_count
	ldec_colvalue = lds_category_access.getitemdecimal(i,'lookup_code')
	if isnull(ldec_colvalue) then continue
	If i = 1 Then
		ls_filter = as_col +" <> "+ string(ldec_colvalue)
	Else
		ls_filter += ' And ' + as_col +" <> "+ string(ldec_colvalue)
	End If
Next

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.22.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(lds_category_access) then Destroy lds_category_access
//---------------------------- APPEON END ----------------------------

Return ls_filter


end function

on n_cst_right.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_right.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

