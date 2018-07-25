$PBExportHeader$n_cst_sql.sru
$PBExportComments$Extension SQL Service service
forward
global type n_cst_sql from pfc_n_cst_sql
end type
end forward

global type n_cst_sql from pfc_n_cst_sql
end type

type variables


end variables

forward prototypes
public function long of_get_count (datawindow adw_1)
end prototypes

public function long of_get_count (datawindow adw_1);/****************************************************************************************************************
** [PUBLIC] Function of_get_count in n_cst_sql inherited from pfc_n_cst_sql
**--------------------------------------------------------------------------------------------------------------
** Description:
**--------------------------------------------------------------------------------------------------------------
** Arguments:	
**
**	[value] datawindow adw_1      <Description>
**--------------------------------------------------------------------------------------------------------------
** Returns:	(LONG) 
**--------------------------------------------------------------------------------------------------------------
** Author:	MSKINNER		Date: Friday, June 15, 2001    10:27:40
**--------------------------------------------------------------------------------------------------------------
** Modification Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
**
**
****************************************************************************************************************/

/////////////////////////////////////////////
// get a count of all the rows for the scroll bar
////////////////////////////////////////////
string ls_select
string ERRORS
string sql_syntax
String   ls_sql
n_cst_sqlattrib   lnv_sqlattrib[ ]
Integer   li_return
long ll_total_rows
string presentation_str, dwsyntax_str

n_ds l_datastore
l_datastore = CREATE n_ds


ls_select = adw_1.Describe("DataWindow.Table.Select")

li_return = of_Parse(ls_select, lnv_sqlattrib)

lnv_sqlattrib[1].s_columns = 'count(*)' + '"' + "count" + '"'
ls_sql = of_Assemble(lnv_sqlattrib)

sqlca.autocommit=TRUE
sql_syntax = ls_sql
presentation_str = "style(type=grid)"
dwsyntax_str = SQLCA.SyntaxFromSQL(sql_syntax,presentation_str, ERRORS)

l_datastore.Create( dwsyntax_str, ERRORS)
l_datastore.settransobject(sqlca)
l_datastore.retrieve()

sqlca.autocommit=false

if l_datastore.rowcount() > 0 then
ll_total_rows = l_datastore.getItemNumber(l_datastore.getRow(),'count' )
end if 
//l_datastore.getItemNumber(l_datastore.getRow(),'count' )


return ll_total_rows
end function

on n_cst_sql.create
call super::create
end on

on n_cst_sql.destroy
call super::destroy
end on

