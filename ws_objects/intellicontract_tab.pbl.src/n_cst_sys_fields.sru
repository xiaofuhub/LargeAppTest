$PBExportHeader$n_cst_sys_fields.sru
forward
global type n_cst_sys_fields from nonvisualobject
end type
end forward

global type n_cst_sys_fields from nonvisualobject
end type
global n_cst_sys_fields n_cst_sys_fields

type variables
string is_class_name[]
string field_sql[]

//u_dw ldw
string ls_Table
long ll_table_id
long ll_field_id

long integers

long ll_start, ll_used

string is_docname,is_named
long   ll_FileNum
long   ll_return 
blob   b_text_blob
string ls_file_dump
string is_file_names[]

CONSTANT STRING NEW_LINE = '~r~n'	
string ls_file_path
n_cst_string       lnv_string

integer li_FileNum

end variables

forward prototypes
public function integer of_create_sysfields (u_dw adw)
public function integer of_create_sysfields (w_master a_window)
public function integer of_create_insert_data (u_dw adw, string as_table_name)
public function integer of_create_file (u_dw adw)
public function integer of_create_sysfields (u_tabpg_contract_master adw_tabpage)
end prototypes

public function integer of_create_sysfields (u_dw adw);

//// it does not know about specific controls
//
//userobject u_tabpg
//
//// Get values for the Tab control and the tab page
//
//
//
//try
//	u_tabpg = adw.GetParent( )
//	of_create_insert_data(adw,  'Contract Logix/' + u_tabpg.text+'/'+ adw.title)
//catch (runtimeerror rte)
//	of_create_insert_data(adw,  'somewindow/' + adw.title)
//end try 



RETURN 0
end function

public function integer of_create_sysfields (w_master a_window);





dragobject temp
int ll_i,i

ll_i = upperbound(a_window.control)
for i = 1 to ll_i
	temp = a_window.control[i]
	choose case typeof(temp)
		case DataWindow! 
			u_dw ldw
			ldw = temp
         ll_table_id++
		   of_create_insert_data( ldw,a_window.title + '(W)\' + ldw.tag)
   		end choose
NEXT

return 0

end function

public function integer of_create_insert_data (u_dw adw, string as_table_name);
string ls_table_name
string ls_field_text[]
string ls_field_type[]
long   ll_rowcount
long   field_order[]
long   ll_field_width[]
string ls_column_name[]


ls_table_name = adw.dataobject

if not f_validstr(ADW.title) then return 0



//aS_TABLE_NAME=  adw.Describe("DataWindow.Table.UpdateTable")

if not f_validstr(AS_TABLE_NAME) or AS_TABLE_NAME = '?' then return 0

ll_table_id++


//messagebox('',string(ADW.Object.DataWindow.Column.Count))
///messagebox('',string(long(ADW.Describe("DataWindow.Column.Count"))))



for ll_rowcount =  1 to long(ADW.Describe("DataWindow.Column.Count"))
	        //AS_TABLE_NAME=  adw.Object.DataWindow.Table.UpdateTable
			  
				if long(ADW.Describe("#" + string(ll_rowcount) + ".TabSequence")) = 0 then continue
				if ADW.Describe( ADW.describe ("#" + string(ll_rowcount) + + ".name") + "_t" + ".Text" ) = '!' then continue
							
				
				field_order[upperbound(field_order) + 1]    =  long(ADW.Describe("#" + string(ll_rowcount) + ".TabSequence"))
				ls_column_name[upperbound(ls_column_name) + 1] =  string(ADW.Describe("#" + string(ll_rowcount) + ".Name")) //dbName
				field_order[upperbound(field_order) + 1]    =  long(ADW.Describe("#" + string(ll_rowcount) + ".TabSequence"))
				ls_field_text[upperbound(ls_field_text) + 1]  =  ADW.Describe ( ADW.describe ("#" + string(ll_rowcount) + + ".name") + "_t" + ".Text" )
				
				 CHOOSE CASE upper(left( string(ADW.Describe("#" + string(ll_rowcount) + ".Coltype"))   ,2 ))
					CASE 'DE'
						ls_field_type[upperbound(ls_field_type) + 1] = 'N'
					CASE 'CH'
						ls_field_type[upperbound(ls_field_type) + 1] = 'C'
					CASE 'LO'
						ls_field_type[upperbound(ls_field_type) + 1] = 'I'
					CASE 'DA'
						ls_field_type[upperbound(ls_field_type) + 1] = 'D'
				END CHOOSE
				
				//ls_field_type[upperbound(ls_field_type) + 1]   = upper(left( string(ADW.Describe("#" + string(ll_rowcount) + ".Coltype"))   ,2 ))
				ll_field_width[upperbound(ll_field_width) + 1] =   long(ADW.Describe("#" + string(ll_rowcount) + ".Width"))
		   next


			//////////////////////////////////////////////////////////////
			// create the table insert sql
			//////////////////////////////////////////////////////////////
//			long ll_count
//			select count(*) 
//			into :ll_count 
//		   from sys_tables 
//			WHERE table_id = :ll_table_id;
			
//			if ll_count < 1 then 
 			// field_sql[upperbound(field_sql) + 1] = "DELETE FROM sys_tables WHERE (table_id = " + STRING(ll_table_id) + ");"
			 field_sql[upperbound(field_sql) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (" +string(ll_table_id) +",'"+ string(ls_table_name) + "'" + ",'" +string(AS_TABLE_NAME) + "'" + ");"
	//	   end if

			//////////////////////////////////////////////////////////////
			// create the sys_field insert sql
			//////////////////////////////////////////////////////////////

			for ll_rowcount =  1 to upperbound(ls_column_name)
				 ll_field_id++
				 	
				 
//		   select count(*) 
//			into :ll_count 
//		   from sys_tables 
//			WHERE table_id = :ll_table_id;
				 
				 /*field_sql[upperbound(field_sql) + 1] = "if exists(select 1 from sys_fields where table_id= " + string(ll_table_id)  + ' and field_id = ' + string(ll_field_id)+ ')' &
					 													+ ' then delete from sys_fields where table_id= ' + string(ll_table_id) + ' and field_id = ' + string(ll_field_id) +' end if; ' */
					
					field_sql[upperbound(field_sql) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES ("+ string(ll_table_id) +&
																																',' +string(ll_field_id) + ','+ &
																																	  string(field_order[ll_rowcount]) + ','+ &
																																	"'" + ls_column_name[ll_rowcount] + "'," + &
																																	"'" + ls_field_type[ll_rowcount] + "',"  + &
																																  string(ll_field_width[ll_rowcount]) +  &
																																	",'" + string(ls_field_text[ll_rowcount] ) +"'" + ");"
				
			     NEXT
				  
				  
of_create_file(adw)

RETURN 0
end function

public function integer of_create_file (u_dw adw);

long ll_i



li_FileNum = FileOpen("C:\sql.sql",StreamMode!, Write!, LockWrite!, append!)
	
//FileWrite ( li_FileNum, "string  ls_sql_statments []" + NEW_LINE)
//FileWrite ( li_FileNum, "long  ll_i" + NEW_LINE)

for ll_i = 1 to upperbound(field_sql)
	  FileWrite ( li_FileNum, 'ls_sql_statments[upperbound(ls_sql_statments) + 1] = "' + field_sql[ll_i]  + ' " '+ NEW_LINE)
next


//FileWrite ( li_FileNum, "FOR ll_i = 1 TO upperbound(ls_sql_statments)" + NEW_LINE)
//FileWrite ( li_FileNum, "execute immediate :ls_sql_statments[LL_I] using sqlca;" + NEW_LINE)
//FileWrite ( li_FileNum, "IF len(sqlca.sqlerrtext) > 0 THEN " + NEW_LINE)
//FileWrite ( li_FileNum, "messagebox(string(LL_I), string(sqlca.sqlerrtext)  + new_line + error.object + new_line +    string(ls_sql_statments[LL_I]) + new_line + 'Please contact software vendor.' )"  + NEW_LINE )
//FileWrite ( li_FileNum, "END IF" + NEW_LINE)
//FileWrite ( li_FileNum, "NEXT" + NEW_LINE)

FileClose ( li_FileNum )

//string ls_Null
//SetNull(ls_Null)
//
//ShellExecuteA ( Handle( This ), "open", "C:\sql.sql", ls_Null, ls_Null, 1)
//
//string  Mysql
//
//for ll_i = 1 to upperbound(field_sql)
//  Mysql= field_sql[ll_i]
//  EXECUTE IMMEDIATE :Mysql USING sqlca ;
//  IF len(sqlca.sqlerrtext) > 0 THEN
//	  messagebox(string(LL_I), string(sqlca.sqlerrtext)  + new_line + error.object + new_line +    string(Mysql) + new_line + "Please contact software vendor."   )
//	 
//  else 
//	commit;
//	
//   END IF
//  
//  
//next
//
//rollback;

string ls_null[] 

field_sql = ls_null 

return 0
end function

public function integer of_create_sysfields (u_tabpg_contract_master adw_tabpage);

dragobject temp

int ll_i,i

ll_i = upperbound(adw_tabpage.control)
for i = 1 to ll_i
	
	temp = adw_tabpage.control[i]
	
	choose case typeof(temp)
		case DataWindow! 
			u_dw ldw
			ldw = temp
			//messagebox('ldw',string(long(ldw.Describe("DataWindow.Column.Count"))))
		   of_create_insert_data( temp,adw_tabpage.text + '\' +  ldw.tag )
			end choose
NEXT

return 0

end function

on n_cst_sys_fields.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_sys_fields.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ll_table_id =  999  // as per mikea

ll_field_id =  19999 // as per mikea


//field_sql[upperbound(field_sql) + 1] = "delete from sys_tables where table_id between 1000 and 1100;"
//field_sql[upperbound(field_sql) + 1] = "delete from sys_fields where table_id between 1000 and 1100;"
//field_sql[upperbound(field_sql) + 1] = "Commit;"
end event

