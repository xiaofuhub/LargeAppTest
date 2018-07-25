$PBExportHeader$w_multi-dbupdate.srw
forward
global type w_multi-dbupdate from window
end type
type cb_2 from commandbutton within w_multi-dbupdate
end type
type cb_export from commandbutton within w_multi-dbupdate
end type
type cb_1 from commandbutton within w_multi-dbupdate
end type
type dw_filter from datawindow within w_multi-dbupdate
end type
type st_2 from statictext within w_multi-dbupdate
end type
type st_1 from statictext within w_multi-dbupdate
end type
type dw_cache from datawindow within w_multi-dbupdate
end type
type cb_select from commandbutton within w_multi-dbupdate
end type
type cb_close from commandbutton within w_multi-dbupdate
end type
type cb_save from commandbutton within w_multi-dbupdate
end type
type cb_delete from commandbutton within w_multi-dbupdate
end type
type cb_add from commandbutton within w_multi-dbupdate
end type
type cb_ping from commandbutton within w_multi-dbupdate
end type
type rb_runafter from radiobutton within w_multi-dbupdate
end type
type rb_runnow from radiobutton within w_multi-dbupdate
end type
type cb_viewlog from commandbutton within w_multi-dbupdate
end type
type cb_import from commandbutton within w_multi-dbupdate
end type
type rb_byselect from radiobutton within w_multi-dbupdate
end type
type rb_byask from radiobutton within w_multi-dbupdate
end type
type gb_1 from groupbox within w_multi-dbupdate
end type
type gb_2 from groupbox within w_multi-dbupdate
end type
type gb_3 from groupbox within w_multi-dbupdate
end type
end forward

global type w_multi-dbupdate from window
integer width = 3904
integer height = 1896
boolean titlebar = true
string title = "Multi-DB upgrade"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_export cb_export
cb_1 cb_1
dw_filter dw_filter
st_2 st_2
st_1 st_1
dw_cache dw_cache
cb_select cb_select
cb_close cb_close
cb_save cb_save
cb_delete cb_delete
cb_add cb_add
cb_ping cb_ping
rb_runafter rb_runafter
rb_runnow rb_runnow
cb_viewlog cb_viewlog
cb_import cb_import
rb_byselect rb_byselect
rb_byask rb_byask
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_multi-dbupdate w_multi-dbupdate

type variables
long il_row=0
string is_current_dbprm,is_current_dbms

Boolean ib_SQLCA_UsedOLE = False

str_screen_para  istr_screen_para
end variables

forward prototypes
public function long f_isselectrow ()
public subroutine f_button_enable (boolean ab_agr)
public function integer f_get_update_parameter ()
public function integer f_set_update_parameter (string as_update_method, string as_execute_method)
public function integer f_connect_db (string as_dbparm, string as_dbms, integer as_type, integer as_dbtype)
public function integer f_start_update ()
public function integer f_update_result (long arg_rownumber, long arg_cache_id)
public function integer f_get_result (integer arg_rownumber)
public function integer f_refresh_filter ()
public function integer f_connect_original_db ()
public function string wf_get_screenbak_syntax (long al_data_view_id, long al_screen_id, string as_version, string as_user, string as_notes, datetime adt_date, string as_style)
public subroutine wf_modify_screen ()
end prototypes

public function long f_isselectrow ();//==============================APPEON BEGIN==========================
// Function: w_multi-dbupdate.f_isselectrow()
//--------------------------------------------------------------------
// Description: check which row is selected
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Nova		Date: Jul 23,2008
//--------------------------------------------------------------------
//	All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//	-------------------------------------------------------------------
//==============================APPEON END============================

Long ll_i
Boolean lb_result
IF dw_cache.RowCount() < 0 THEN RETURN 0
il_row = 0
FOR ll_i = 1 To dw_cache.RowCount()
	lb_result = dw_cache.IsSelected(ll_i)
	IF lb_result THEN
		il_row = ll_i
		EXIT
	END IF
NEXT

RETURN il_row


end function

public subroutine f_button_enable (boolean ab_agr);//==============================APPEON BEGIN==========================
// Function: w_multi-dbupdate.f_button_enable()
//--------------------------------------------------------------------
// Description: set button enabled or disable
//--------------------------------------------------------------------
// Arguments:
// 	value	boolean	ab_agr	true:enabled  false:disable
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Nova		Date: Jul 23,2008
//--------------------------------------------------------------------
//	All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//	-------------------------------------------------------------------
//==============================APPEON END============================
//
cb_delete.Enabled = ab_agr
//cb_save.enabled=ab_agr
cb_viewlog.Enabled = ab_agr
cb_ping.Enabled = ab_agr
cb_select.Enabled = ab_agr


end subroutine

public function integer f_get_update_parameter ();//==============================APPEON BEGIN==========================
//Function: w_multi-dbupdate.f_get_update_parameter()
//--------------------------------------------------------------------
// Description:  not using now!
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Nova		Date: Jul 23,2008
//--------------------------------------------------------------------
//	All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//	-------------------------------------------------------------------
//==============================APPEON END============================
//
String ls_update,ls_execute

SELECT update_parameter.update_method,
	update_parameter.execute_method
	INTO :ls_update,
	:ls_execute
	From update_parameter using CC_tansobject ;
	
IF ls_update = '0' THEN
	rb_byask.Checked = True
ELSE
	rb_byselect.Checked = True
END IF

IF ls_execute = '0' THEN
	rb_runnow.Checked = True
ELSE
	rb_runafter.Checked = True
END IF


RETURN 1

end function

public function integer f_set_update_parameter (string as_update_method, string as_execute_method);//==============================APPEON BEGIN==========================
// Function: w_multi-dbupdate.f_set_update_parameter()
//--------------------------------------------------------------------
// Description:set parameter
//--------------------------------------------------------------------
// Arguments:
// 	value	string	as_update_method 	
// 	value	string	as_execute_method	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Nova		Date: Jul 23,2008
//--------------------------------------------------------------------
//	All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//	-------------------------------------------------------------------
//==============================APPEON END============================

UPDATE update_parameter
	SET update_method = :as_update_method,
	execute_method = :as_execute_method using CC_tansobject ;
RETURN 1


end function

public function integer f_connect_db (string as_dbparm, string as_dbms, integer as_type, integer as_dbtype);//==============================APPEON BEGIN==========================
// Function: w_multi-dbupdate.f_connect_db()
//--------------------------------------------------------------------
// Description: try connect cache,
//--------------------------------------------------------------------
// Arguments:
// 	value	string 	as_dbparm	
// 	value	string 	as_dbms  	
// 	value	integer	as_type  	
// 	value	integer	as_dbtype	
//--------------------------------------------------------------------
// Returns:  integer 0:current is not dynamic cache    1:sucessful  -1:failed
//--------------------------------------------------------------------
// Author:	Nova		Date: Jul 23,2008
//--------------------------------------------------------------------
//	All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//	-------------------------------------------------------------------
//==============================APPEON END============================

String ls_dbtype
IF as_type = 1 and AppeonGetClientType() = 'WEB' THEN
	//save current dbparm and dbms
	IF Len(gs_CacheType) = 0 Or Len(gs_CacheSet) = 0 THEN
		RETURN 0
	ELSE
		is_current_dbprm = gs_CacheSet
		is_current_dbms = gs_CacheType
	END IF
END IF
DISCONNECT Using sqlca;
IF AppeonGetClientType() = 'WEB' THEN
	IF as_type = 0 THEN
		sqlca.DBParm = as_dbparm
		sqlca.DBMS = as_dbms
	ELSE
		sqlca.DBParm = "CacheName= '"+as_dbparm+"' "
		sqlca.DBMS = as_dbms
	END IF
Else
	//Added By Ken.Guo 07/10/2012
	//as_dbparm: hostname ;  as_dbms: databasename
	sqlca.DBMS = "OLE DB"
	sqlca.LogPass ="sql"
	sqlca.LogId = "dba"
	sqlca.DBParm = "PROVIDER='SQLOLEDB',DATASOURCE='"+as_dbparm+"',PROVIDERSTRING='database="+as_dbms+"',DelimitIdentifier='Yes'"
	sqlca.autocommit = True
END IF
ib_SQLCA_UsedOLE = True
CONNECT Using sqlca;
IF sqlca.SQLCode = 0  THEN
	SELECT Top 1 @@version Into :ls_dbtype From ids ;
	If isnull(ls_dbtype) Then
		gnv_debug.of_output( true, 'Connected database. But failed to get data from ids. ' + as_dbparm + ' - ' + as_dbms + '.~r~n'  + sqlca.sqlerrtext)
		RETURN -1
	End If
	gs_sqlserver_version = ls_dbtype //Added By Ken.Guo 07/13/2012
	IF as_dbtype = 1 THEN
		IF Pos(Upper(ls_dbtype) , 'SQL SERVER') > 0 THEN
			gs_dbType = 'SQL'
			
		ELSE
			gs_dbType = 'ASA'
		END IF
	END IF
	RETURN 1
ELSE
	gnv_debug.of_output( true, 'Failed to connect to batch database ' + as_dbparm + ' - ' + as_dbms + '.~r~n'  + sqlca.sqlerrtext)
	RETURN -1
END IF







end function

public function integer f_start_update ();
//==============================APPEON BEGIN==========================
// Function: w_multi-dbupdate.f_start_update()
//--------------------------------------------------------------------
// Description: call w_priv_update 
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Nova		Date: Jul 23,2008
//--------------------------------------------------------------------
//	All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//	-------------------------------------------------------------------
//==============================APPEON END============================

String ls_DBMS,ls_dbparm
Long ll_rowcount,li_rtn
Boolean lb_select = False
IF dw_cache.RowCount() <= 0 THEN RETURN 0

FOR ll_rowcount = 1 To dw_cache.RowCount()
	IF dw_cache.Object.cache_selected[ll_rowcount] = 1 THEN
		lb_select = True
		EXIT
	END IF
NEXT

IF lb_select = False THEN
	MessageBox("Infor","You must select a cache that you want to upgrade!")
	RETURN 0
END IF

//Added By Ken.Guo 2010-01-07.
FOR ll_rowcount = 1 To dw_cache.RowCount()
	IF dw_cache.Object.cache_selected[ll_rowcount] = 1 THEN
		If dw_cache.GetItemString(ll_rowcount,'current_version') <> gs_current_version Then
			dw_cache.ScrolltoRow(ll_rowcount)
			dw_cache.SetRow(ll_rowcount)
			If MessageBox("Warning","Your selected cache's main version is difference with the current application's main version, continue?",Question!,YesNo!,2) = 2 Then 
				Return 0
			Else
				Exit
			End If
		End If
	End If
Next


li_rtn = MessageBox("Infor","Are you sure to upgrade these caches that you have selected?",Question!,YesNo!,2)

IF li_rtn = 2 THEN RETURN 0

FOR ll_rowcount = 1 To dw_cache.RowCount()
	IF dw_cache.Object.cache_selected[ll_rowcount] = 1 THEN
		//Added By Ken.Guo 2011-02-21.
		dw_cache.ScrollToRow(ll_rowcount)
		dw_cache.SetRow(ll_rowcount)
		
		IF dw_cache.Object.cache_type[ll_rowcount] = '0' THEN
			ls_DBMS = 'ODB-ASA'
		ELSEIF dw_cache.Object.cache_type[ll_rowcount] = '1' THEN
			ls_DBMS = 'ODB-MSS'
		ELSE
			ls_DBMS = 'Unknown'
		END IF
		ls_dbparm = Lower(Trim(dw_cache.Object.cache_name[ll_rowcount]))
		
		//Added By Ken.Guo 07/11/2012
		If AppeonGetClientType() = 'PB' Then
			ls_dbparm = dw_cache.GetItemString(ll_rowcount, 'database_host')
			ls_DBMS = dw_cache.GetItemString(ll_rowcount, 'database_service_name')
		End If
		
		IF f_connect_db(ls_dbparm,ls_DBMS,ll_rowcount,1) = 1 THEN
			If AppeonGetClientType() = 'PB' Then
				st_1.Text = 'Upgrading '+ls_DBMS+' now...' 
			Else
				st_1.Text = 'Upgrading '+ls_dbparm+' now...' 
			End If
			gb_write_log = True
			gl_cache_id =  dw_cache.Object.cache_id[ll_rowcount]
			OpenWithParm(w_priv_update,'M')
			w_priv_update.st_update.Visible = True
			w_priv_update.st_update.BringToTop = True
			w_priv_update.cb_update.Visible = False
			w_priv_update.cb_reset.Visible = False
			w_priv_update.cb_1.Visible = False
			w_priv_update.cb_3.Visible = False
			w_priv_update.st_1.Visible = False
			w_priv_update.cbx_latest.Visible = False
			w_priv_update.cb_update.TriggerEvent(Clicked!)
			IF IsValid(w_priv_update) THEN Close(w_priv_update)
			f_update_result(ll_rowcount,dw_cache.Object.cache_id[ll_rowcount])
		END IF
	END IF
NEXT
st_1.Text = 'Upgrade Completed!'

messagebox("Infor",'Upgrade Completed!')

RETURN 1







end function

public function integer f_update_result (long arg_rownumber, long arg_cache_id);
//==============================APPEON BEGIN==========================
// Event: w_multi-dbupdate.f_update_result()
//--------------------------------------------------------------------
// Description: set upgrade result
//--------------------------------------------------------------------
// Arguments:
// 	value	long	arg_rownumber	
// 	value	long	arg_cache_id 	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Nova		Date: Jul 23,2008
//--------------------------------------------------------------------
//	All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//	-------------------------------------------------------------------
//==============================APPEON END============================

Long ll_temp_result

IF gb_upgrade_failed THEN
	ll_temp_result = 0
ELSE
	ll_temp_result =  1
END IF

dw_cache.Object.last_update_result[arg_rownumber] = ll_temp_result

UPDATE connection_cache
	SET last_update_result = :ll_temp_result
	Where connection_cache.cache_id = :arg_cache_id Using CC_tansobject ;
f_get_result(arg_rownumber)

dw_cache.update() //Added By Ken.Guo 2011-02-21.

RETURN 1




end function

public function integer f_get_result (integer arg_rownumber);//==============================APPEON BEGIN==========================
// Function: w_multi-dbupdate.f_get_result()
//--------------------------------------------------------------------
// Description: set cache dbtype, last update time, current version
//--------------------------------------------------------------------
// Arguments:
// 	value	integer	arg_rownumber	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Nova		Date: Jul 23,2008
//--------------------------------------------------------------------
//	All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//	-------------------------------------------------------------------
//==============================APPEON END============================


String ls_dbtype
DateTime ld_updatetime
long ll_ver

//set readonly value
SELECT Top 1 @@version ,last_update Into :ls_dbtype,:ld_updatetime From ids using sqlca;

IF Pos(Upper(ls_dbtype) , 'SQL SERVER') > 0 THEN
	dw_cache.Object.cache_type[arg_rownumber] = '1'
ELSE
	dw_cache.Object.cache_type[arg_rownumber] = '0'
END IF
dw_cache.Object.last_update_date[arg_rownumber] = ld_updatetime

SELECT set_18 Into :ll_ver From icred_settings	 using sqlca;
dw_cache.Object.current_version[arg_rownumber] = String(ll_ver)
//


return 1
end function

public function integer f_refresh_filter ();//==============================APPEON BEGIN==========================
// Function: w_multi-dbupdate.f_refresh_filter()
//--------------------------------------------------------------------
// Description:refresh data of dw_filter 
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Nova		Date: Jul 23,2008
//--------------------------------------------------------------------
//	All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//	-------------------------------------------------------------------
//==============================APPEON END============================

dw_filter.SetTransObject(CC_tansobject)

DataWindowChild ldwc_version
dw_filter.GetChild("version_select", ldwc_version )

ldwc_version.SetTransObject(CC_tansobject)
ldwc_version.Retrieve()
ldwc_version.InsertRow(1)
ldwc_version.SetItem(1,"current_version",'All')

dw_filter.InsertRow(0)

RETURN 1

end function

public function integer f_connect_original_db ();//====================================================================
// Function: f_connect_original_db
//--------------------------------------------------------------------
// Description: Connect to original database
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 07/11/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


If AppeonGetClientType() = 'WEB' Then
	Return f_connect_db(is_current_dbprm,is_current_dbms,0,1)
Else
	DISCONNECT Using sqlca;
	Return of_connect_to_db()
End If

Return 1
end function

public function string wf_get_screenbak_syntax (long al_data_view_id, long al_screen_id, string as_version, string as_user, string as_notes, datetime adt_date, string as_style);Long ll_data_length
Integer li_counter
Integer li_loops
String ls_sql
String ls_all_sql
Long ll_start

// Get file data from database

SELECT ( CASE WHEN :as_style = 'G' THEN  Datalength(grid_sql) ELSE Datalength(dw_sql) END )
INTO :ll_data_length
FROM ctx_screen_bak
WHERE data_view_id = :al_data_view_id
AND screen_id = :al_screen_id And user_id = :as_user And version= :as_version And notes = :as_notes 
And  backupdate = :adt_date ;

IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
	Messagebox("Get sql error","Failed to get datawindow syntax from DB, Please report this to support.")
	RETURN ''
END IF

IF ll_data_length > 8000 THEN 
  	 IF Mod(ll_data_length,8000) = 0 THEN 
        li_loops = ll_data_length/8000 
    ELSE 
  	     li_loops = (ll_data_length/8000) + 1 
    END IF 
ELSE 
  	 li_loops = 1 
END IF 

FOR li_counter = 1 to li_loops
	ll_start = (li_counter - 1) * 8000 + 1
	
	SELECT ( CASE WHEN :as_style = 'G' THEN substring(grid_sql,:ll_start,8000) ELSE substring(dw_sql,:ll_start,8000) END )
	INTO :ls_sql
	FROM ctx_screen_bak 
	WHERE data_view_id = :al_data_view_id
	AND screen_id = :al_screen_id And user_id = :as_user And version= :as_version And notes = :as_notes 
	And  backupdate = :adt_date ;

	ls_all_sql += ls_sql
NEXT 

If not len(ls_all_sql) > 0 Then
	Messagebox("Get sql error 1","Failed to get datawindow syntax from DB, Please report this to support.")
End If
Return ls_all_sql
end function

public subroutine wf_modify_screen ();//	ls_sql = f_get_screen_gridsql(ll_view_id,ll_screen_id,false)  
//								Else
//									ls_sql = f_get_screen_sql(ll_view_id,ll_screen_id,false)

n_ds		lds_Screen , lds_Screen_bak, lds_Source, lds_Target
Long		ll_R, ll_k, ll_i, ll_Find
Long		ll_view_id, ll_Screen_id
String		ls_name, ls_Temp, ls_sql, ls_bak_sql, ls_style, ls_Err
String		ls_Tag, ls_vision, ls_user, ls_notes, ls_Ttag, ls_Modify  , ls_Before="",ls_newsql
DateTime	ldt_date
string		ls_date, ls_lookuplist, ls_opsyntax, ls_spcelist
Blob		lblob_syntax,lblob_opsyntax
boolean	lb_Optimized

lds_Screen = Create n_ds
lds_Screen_bak = Create n_ds
lds_Source = create n_ds
lds_Target = Create n_ds

lds_Screen.dataObject = 'ds_screen_restore'
lds_Screen_bak.dataObject = 'ds_screenbak_restore'

lds_Screen.SetTransObject( SQLCA )
lds_Screen_bak.SetTransObject( SQLCA )

//lds_Screen.Retrieve( ) //Commented by (Appeon)Harry 03.13.2014 - V142 ISG-CLX
ls_vision = istr_screen_para.para1
ls_user = istr_screen_para.para2
ls_date = istr_screen_para.para3
lb_Optimized = istr_screen_para.para4
//---------Begin Modified by (Appeon)Harry 03.13.2014 for V142 ISG-CLX--------
//lds_Screen_bak.Retrieve( ls_vision, ls_user, ls_date )
gnv_appeondb.of_startqueue( )
lds_Screen.Retrieve( )
lds_Screen_bak.Retrieve( ls_vision, ls_user, ls_date )
gnv_appeondb.of_commitqueue( )

If lds_Screen_bak.rowcount() = 0  Then//added by gavins 20130917
	MessageBox( 'Tips', 'Backup Screen Data is empty, please try to input other version.' )
	gnv_debug.of_output( true, '('+ ls_vision +',' + ls_user + ',' + ls_date + ") record is empty."  )
	return
End If
//---------End Modfiied ------------------------------------------------------

For ll_k = 1 To lds_Screen.RowCount( )
	yield( )
	ls_style = lds_Screen.object.screen_style[ll_k]
	ll_view_id =lds_Screen.object.data_view_id[ll_k]
	ll_Screen_id =lds_Screen.object.screen_id[ll_k]
	ls_spcelist = lds_screen.GetItemString( ll_k,"fix_field")
	
	If ls_style = 'F' Then
		ls_sql = f_get_screen_sql(ll_view_id,ll_screen_id,false)
	Else
		ls_sql = f_get_screen_gridsql(ll_view_id,ll_screen_id,false)  
	End If
	ll_Find = lds_Screen_bak.Find( "data_view_id = " + string( ll_view_id ) + " and screen_id = " + string( ll_screen_id ), 1, lds_Screen_bak.Rowcount( ))
	If ll_Find > 0 Then
		ls_user = lds_Screen_bak.object.user_id[ ll_Find ]
		ls_vision = lds_Screen_bak.object.version[ ll_Find ]
		ls_notes = lds_Screen_bak.object.notes[ ll_Find ]
		ldt_date = lds_Screen_bak.object.backupdate[ ll_Find ]
			
		ls_bak_sql = wf_Get_screenbak_syntax( ll_view_id, ll_screen_id, ls_vision, ls_user, ls_notes, ldt_date, ls_style )
		ls_err = ''
		lds_Source.Create( ls_sql, ls_Err )
		lds_Source.SetTransObject( sqlca )
		If len( ls_err ) > 0 then 
			gnv_debug.of_output( true, 'view_id=' + string( ll_view_id) + ", screen_id=" + string(ll_screen_id) + ', create screen error=' + ls_Err   )
			continue
		End If
		lds_Target.Create( ls_bak_sql, ls_Err )
		lds_target.SetTransObject(sqlca)
		If len( ls_err ) > 0 then 
			gnv_debug.of_output( true, 'view_id=' + string( ll_view_id) + ", screen_id=" + string(ll_screen_id) + ', create screen_bak error=' + ls_Err   )
			continue
		End If
		ls_Modify = ''
		ls_Before = ''
		For ll_i = 1 To Long( lds_Source.object.datawindow.column.count )
			st_1.Text = 'view id:' + string( ll_view_id ) + ',screen id:' +string( ll_screen_id ) + ',No.' + string( ll_i )
			yield( )
			ls_Name = lds_Source.Describe( "#" + string( ll_i)+".name" ) 
			ls_Tag = lds_Source.Describe( "#" + string( ll_i)+".tag" ) 
			ls_Ttag = lds_Target.Describe( ls_Name +".tag" ) 
			If Not( ls_tag = '!' or ls_tag = '?' or ls_tag = '1#' ) And Len( ls_Ttag ) > 0 And Not( ls_Ttag = '!' or ls_Ttag = '?' or ls_Ttag = '1#' ) Then
				If Len( ls_Tag ) > 0 And ls_Tag <> ls_Ttag Then 
					ls_Modify = ls_Modify + " " +  ls_Name + ".tag='" + ls_Ttag + "'" 
					ls_Before = ls_Before + " " +  ls_Name + ".tag='" + ls_tag + "'" 
				End If
			End If
		Next
		
		If Len( Trim( ls_Modify ) ) > 0  Or lb_Optimized Then 
			If Not lb_Optimized Then
				gnv_debug.of_output( true, 'view_id=' + string( ll_view_id) + ", screen_id=" + string(ll_screen_id) + ', before modify=' + ls_Before   )
				gnv_debug.of_output( true, 'view_id=' + string( ll_view_id) + ", screen_id=" + string(ll_screen_id) + ', modify          =' + ls_Modify   )
				ls_err = lds_Source.Modify( ls_Modify )
				If len( ls_err ) > 0 then 
					gnv_debug.of_output( true, 'view_id=' + string( ll_view_id) + ", screen_id=" + string(ll_screen_id) + ', Modify Screen error=' + ls_Err   )
				End If
			End If
				
			lds_Screen.SetItem( ll_k, 'modify_date', today( ) )
						
			ls_NewSQL = lds_Source.Describe( "datawindow.syntax" )
			If Len( ls_NewSQL ) > 10 Then
				lblob_syntax = blob(ls_NewSQL )
				if ls_style = 'F' Then
						UPDATEBLOB ctx_screen SET    dw_sql = :lblob_syntax 
					WHERE data_view_id = :ll_view_id 	AND screen_id = :ll_screen_id;
				Else
						UPDATEBLOB ctx_screen SET   	grid_sql = :lblob_syntax  
					WHERE data_view_id = :ll_view_id 	AND screen_id = :ll_screen_id;
				End If
				
				IF gf_get_opsyntax(ls_NewSQL ,ls_spcelist,ls_opsyntax,ls_lookuplist) < 0 Then ls_opsyntax = ls_newsql
				lds_Screen.SetItem( ll_k, 'lookup_list', ls_lookuplist )
				lblob_opsyntax = Blob( ls_opsyntax )
				if ls_style = 'F' Then
						UPDATEBLOB ctx_screen SET    dw_opsql = :lblob_opsyntax 
					WHERE data_view_id = :ll_view_id 	AND screen_id = :ll_screen_id;
				Else
						UPDATEBLOB ctx_screen SET   	grid_opsql = :lblob_opsyntax  
					WHERE data_view_id = :ll_view_id 	AND screen_id = :ll_screen_id;
				End If
//				UPDATEBLOB ctx_screen SET  (Case when :ls_style = 'F' Then dw_sql = :lblob_syntax  else
//				grid_sql = :lblob_syntax end )
//				WHERE data_view_id = :ll_view_id 	AND screen_id = :ll_screen_id;
				if sqlca.sqlcode < 0 then	
					gnv_debug.of_output( true, 'view_id=' + string( ll_view_id) + ", screen_id=" + string(ll_screen_id) + ', update blob Screen error=' + sqlca.sqlerrtext   )
					Rollback;
				else 
					commit;
				end if
			End If
		End If
	End If
	
Next

lds_Screen.Update( )
Commit;





end subroutine

on w_multi-dbupdate.create
this.cb_2=create cb_2
this.cb_export=create cb_export
this.cb_1=create cb_1
this.dw_filter=create dw_filter
this.st_2=create st_2
this.st_1=create st_1
this.dw_cache=create dw_cache
this.cb_select=create cb_select
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.cb_ping=create cb_ping
this.rb_runafter=create rb_runafter
this.rb_runnow=create rb_runnow
this.cb_viewlog=create cb_viewlog
this.cb_import=create cb_import
this.rb_byselect=create rb_byselect
this.rb_byask=create rb_byask
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.Control[]={this.cb_2,&
this.cb_export,&
this.cb_1,&
this.dw_filter,&
this.st_2,&
this.st_1,&
this.dw_cache,&
this.cb_select,&
this.cb_close,&
this.cb_save,&
this.cb_delete,&
this.cb_add,&
this.cb_ping,&
this.rb_runafter,&
this.rb_runnow,&
this.cb_viewlog,&
this.cb_import,&
this.rb_byselect,&
this.rb_byask,&
this.gb_1,&
this.gb_2,&
this.gb_3}
end on

on w_multi-dbupdate.destroy
destroy(this.cb_2)
destroy(this.cb_export)
destroy(this.cb_1)
destroy(this.dw_filter)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_cache)
destroy(this.cb_select)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.cb_ping)
destroy(this.rb_runafter)
destroy(this.rb_runnow)
destroy(this.cb_viewlog)
destroy(this.cb_import)
destroy(this.rb_byselect)
destroy(this.rb_byask)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;//==============================APPEON BEGIN==========================
// Event: open.w_multi-dbupdate()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Nova		Date: Jul 23,2008
//--------------------------------------------------------------------
//	All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//	-------------------------------------------------------------------
//==============================APPEON END============================

CC_tansobject = Create n_tr;
String as_dbparm, ls_hostname

as_dbparm = 'controlcenter'
IF AppeonGetClientType() = 'WEB' THEN
	dw_cache.Modify("database_service_name.visible = 0 database_host.visible = 0")
	CC_tansobject.DBParm = "CacheName= '"+as_dbparm+"' "
	CC_tansobject.DBMS = 'ODB-MSS'
	CC_tansobject.AutoCommit = True
	CONNECT Using CC_tansobject;
Else
	//Added By Ken.Guo 07/10/2012. Support Batch Upgrade by C/S version. 
	ls_hostname =ProfileString (gs_IniFilePathName , "setup", "controlcenter", "localhost" )
	If ls_hostname = '' or isnull(ls_hostname) Then 
		ls_hostname = 'localhost'
		gnv_debug.of_output( True, 'Failed to get controlcenter value from INI file. use default value "localhost"')
	End If
	CC_tansobject.DBMS = "OLE DB"
	CC_tansobject.LogPass ="sql"
	CC_tansobject.LogId = "dba"
	CC_tansobject.AutoCommit = True
	CC_tansobject.DBParm = "PROVIDER='SQLOLEDB',DATASOURCE='"+ls_hostname+"',PROVIDERSTRING='database=controlcenter',DelimitIdentifier='Yes'"
	CONNECT Using CC_tansobject;
END IF

IF CC_tansobject.SQLCode <> 0 THEN
	MessageBox("Infor","System can't connect "+as_dbparm+"!~r~n" +CC_tansobject.sqlerrtext +'~r~n'+'Please check:'+'~r~n'+'Can you create a cache which name is control center? ')
	IF IsValid(w_multi-dbupdate) THEN Close(w_multi-dbupdate)
	IF IsValid(CC_tansobject) THEN Destroy CC_tansobject
	RETURN
END IF

dw_cache.SetTransObject(CC_tansobject)
dw_cache.Retrieve()
IF dw_cache.RowCount() > 0 THEN
	f_button_enable(True)
ELSE
	f_button_enable(False)
END IF

f_refresh_filter()
//f_get_update_parameter()




end event

event closequery;//==============================APPEON BEGIN==========================
// Event: closequery.w_multi-dbupdate()
//--------------------------------------------------------------------
// Description: check if save data
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Nova		Date: Jul 23,2008
//--------------------------------------------------------------------
//	All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//	-------------------------------------------------------------------
//==============================APPEON END============================

dw_cache.AcceptText()
IF dw_cache.ModifiedCount() + dw_cache.DeletedCount()  > 0 THEN
	IF MessageBox("Save data", "Close without saving changes?", Question!, YesNo!) = 2 THEN RETURN 1
END IF


end event

event close;IF IsValid(CC_tansobject) THEN DESTROY CC_tansobject

If ib_SQLCA_UsedOLE Then
	//---------Begin Modified by (Appeon)Toney 08.06.2013 for V141 ISG-CLX--------
	  /*
		Messagebox('IntelliSoft','Please quit contractlogix and run again.',Exclamation! )	
	  */
	 Messagebox('IntelliSoft','Please quit IntelliSoft and run again.',Exclamation! )
	//---------End Modfiied ------------------------------------------------------------------	 
End If
end event

type cb_2 from commandbutton within w_multi-dbupdate
integer x = 3209
integer y = 1592
integer width = 361
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Fix Sceen Tag"
end type

event clicked;String ls_DBMS,ls_dbparm
Long ll_rowcount,li_rtn
Boolean lb_select = False


IF dw_cache.RowCount() <= 0 THEN RETURN 0

FOR ll_rowcount = 1 To dw_cache.RowCount()
	IF dw_cache.Object.cache_selected[ll_rowcount] = 1 THEN
		lb_select = True
		EXIT
	END IF
NEXT

IF lb_select = False THEN
	MessageBox("Infor","You must select a cache that you want to upgrade!")
	RETURN 0
END IF

//Added By Ken.Guo 2010-01-07.
FOR ll_rowcount = 1 To dw_cache.RowCount()
	IF dw_cache.Object.cache_selected[ll_rowcount] = 1 THEN
		If dw_cache.GetItemString(ll_rowcount,'current_version') <> gs_current_version Then
			dw_cache.ScrolltoRow(ll_rowcount)
			dw_cache.SetRow(ll_rowcount)
			If MessageBox("Warning","Your selected cache's main version is difference with the current application's main version, continue?",Question!,YesNo!,2) = 2 Then 
				Return 0
			Else
				Exit
			End If
		End If
	End If
Next


li_rtn = MessageBox("Infor","Are you sure to upgrade these caches that you have selected?",Question!,YesNo!,2)

IF li_rtn = 2 THEN RETURN 0

openwithparm( w_multi-dbupdate_screen_para, '' )
If IsValid(  Message.PowerObjectParm ) Then 
	istr_screen_para = Message.PowerObjectParm
Else
	Return
End If


FOR ll_rowcount = 1 To dw_cache.RowCount()
	IF dw_cache.Object.cache_selected[ll_rowcount] = 1 THEN
		//Added By Ken.Guo 2011-02-21.
		dw_cache.ScrollToRow(ll_rowcount)
		dw_cache.SetRow(ll_rowcount)
		
		IF dw_cache.Object.cache_type[ll_rowcount] = '0' THEN
			ls_DBMS = 'ODB-ASA'
		ELSEIF dw_cache.Object.cache_type[ll_rowcount] = '1' THEN
			ls_DBMS = 'ODB-MSS'
		ELSE
			ls_DBMS = 'Unknown'
		END IF
		ls_dbparm = Lower(Trim(dw_cache.Object.cache_name[ll_rowcount]))
		
		//Added By Ken.Guo 07/11/2012
		If AppeonGetClientType() = 'PB' Then
			ls_dbparm = dw_cache.GetItemString(ll_rowcount, 'database_host')
			ls_DBMS = dw_cache.GetItemString(ll_rowcount, 'database_service_name')
		End If
		
		IF f_connect_db(ls_dbparm,ls_DBMS,ll_rowcount,1) = 1 THEN
			If AppeonGetClientType() = 'PB' Then
				st_1.Text = 'Upgrading '+ls_DBMS+' now...' 
			Else
				st_1.Text = 'Upgrading '+ls_dbparm+' now...' 
			End If
//			gb_write_log = True
			gl_cache_id =  dw_cache.Object.cache_id[ll_rowcount]
			gnv_debug.of_output( true, '//-----------------------' + ls_DBMS + '------------------------//'    )
			wf_modify_Screen( )
			gnv_debug.of_output( true, '//****************' + ls_DBMS + '*****************//'    )
		END IF
	END IF
NEXT

messagebox("Infor",'Fix Completed!')

f_connect_original_db()

//refresh golob cache

app_filler.ids_screen_fields_cache.SetTransObject(SQLCA)
app_filler.ids_screen_objects_cache.SetTransObject(SQLCA)
app_filler.ids_screen_fields_cache.Retrieve()
app_filler.ids_screen_objects_cache.Retrieve()


end event

type cb_export from commandbutton within w_multi-dbupdate
integer x = 2930
integer y = 1696
integer width = 270
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Export"
end type

event clicked;//---------Begin Modified by (Appeon)Harry 06.11.2013 for V141 ISG-CLX--------
//dw_cache.SaveAs()
gnv_dw.of_SaveAs(dw_cache)
//---------End Modfiied ------------------------------------------------------


end event

type cb_1 from commandbutton within w_multi-dbupdate
integer x = 1765
integer y = 1660
integer width = 526
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Upgrade Now"
end type

event clicked;//begin upgrade selected dw_cache


f_start_update()
dw_cache.Update()

//restore dbparm and dbms
//f_connect_db(is_current_dbprm,is_current_dbms,0,1)
f_connect_original_db()

//refresh golob cache

app_filler.ids_screen_fields_cache.SetTransObject(SQLCA)
app_filler.ids_screen_objects_cache.SetTransObject(SQLCA)
app_filler.ids_screen_fields_cache.Retrieve()
app_filler.ids_screen_objects_cache.Retrieve()


end event

type dw_filter from datawindow within w_multi-dbupdate
integer x = 544
integer y = 1660
integer width = 347
integer height = 92
integer taborder = 60
string title = "none"
string dataobject = "d_select_version"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;//==============================APPEON BEGIN==========================
// Event: itemchanged.dw_filter()
//--------------------------------------------------------------------
// Description:filter cache by version
//--------------------------------------------------------------------
// Arguments:
// 	value	long    	row 	
// 	value	dwobject	dwo 	
// 	value	string  	data	
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Nova		Date: Jul 23,2008
//--------------------------------------------------------------------
//	All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//	-------------------------------------------------------------------
//==============================APPEON END============================

String ls_version

ls_version = Data

IF Data = 'All' THEN
	dw_cache.SetFilter("")
ELSE
	dw_cache.SetFilter("current_version = '"+ ls_version +" '")
END IF

dw_cache.Filter()

dw_cache.Event RowFocusChanged(dw_cache.GetRow())

end event

type st_2 from statictext within w_multi-dbupdate
integer x = 347
integer y = 1676
integer width = 210
integer height = 88
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Version:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_multi-dbupdate
integer x = 928
integer y = 1672
integer width = 832
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 134217858
long backcolor = 33551856
string text = "Please backup DB before upgrade!"
boolean focusrectangle = false
end type

type dw_cache from datawindow within w_multi-dbupdate
integer width = 3863
integer height = 1564
integer taborder = 10
string title = "none"
string dataobject = "d_connect_cache"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;cb_save.enabled=true
end event

event rowfocuschanged;this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)

end event

event clicked;//==============================APPEON BEGIN==========================
// Event: clicked.dw_cache()
//--------------------------------------------------------------------
// Description:hilight select row
//--------------------------------------------------------------------
// Arguments:
// 	value	integer 	xpos	
// 	value	integer 	ypos	
// 	value	long    	row 	
// 	value	dwobject	dwo 	
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Nova		Date: Jul 23,2008
//--------------------------------------------------------------------
//	All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//	-------------------------------------------------------------------
//==============================APPEON END============================
If row > 0 Then
	This.SelectRow(0, FALSE)
	This.scrolltorow(row)
	This.SelectRow(row, TRUE)
End If


end event

event dberror;//==============================APPEON BEGIN==========================
//Event: dberror.dw_cache()
//--------------------------------------------------------------------
// Description:Do not display the error message
//--------------------------------------------------------------------
// Arguments:
// 	value	long    	sqldbcode 	
// 	value	string  	sqlerrtext	
// 	value	string  	sqlsyntax 	
// 	value	dwbuffer	buffer    	
// 	value	long    	row       	
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Nova		Date: Jul 23,2008
//--------------------------------------------------------------------
//	All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//	-------------------------------------------------------------------
//==============================APPEON END============================

return 1
end event

event itemerror;return 1
end event

type cb_select from commandbutton within w_multi-dbupdate
integer x = 18
integer y = 1652
integer width = 288
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Se&lect All"
end type

event clicked;//==============================APPEON BEGIN==========================
// Event: clicked.cb_select()
//--------------------------------------------------------------------
// Description: select cache
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Nova		Date: Jul 23,2008
//--------------------------------------------------------------------
//	All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//	-------------------------------------------------------------------
//==============================APPEON END============================

Long i
IF cb_select.Text = '&Select All' THEN
	cb_select.Text = '&Deselect All'
	FOR i = 1 To dw_cache.RowCount()
		dw_cache.SetItem(i,'cache_selected',1)
	NEXT
ELSE
	cb_select.Text = '&Select All'
	FOR i = 1 To dw_cache.RowCount()
		dw_cache.SetItem(i,'cache_selected',0)
	NEXT
END IF



end event

type cb_close from commandbutton within w_multi-dbupdate
integer x = 3593
integer y = 1652
integer width = 270
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_save from commandbutton within w_multi-dbupdate
integer x = 2930
integer y = 1588
integer width = 270
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//==============================APPEON BEGIN==========================
// Event: clicked.cb_save()
//--------------------------------------------------------------------
// Description:save dw_cache data
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Nova		Date: Jul 23,2008
//--------------------------------------------------------------------
//	All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//	-------------------------------------------------------------------
//==============================APPEON END============================

String ls_update,ls_execut

IF dw_cache.AcceptText() = -1 THEN RETURN
//try ping cache
cb_ping.TriggerEvent(Clicked!)


//update dw_cache
IF dw_cache.ModifiedCount() + dw_cache.DeletedCount() <= 0 THEN RETURN

IF dw_cache.ModifiedCount()+ dw_cache.DeletedCount() > 0 THEN
	dw_cache.Update()
END IF

//refresh dw_filter
f_refresh_filter()
//set button enable
IF dw_cache.RowCount() > 0 THEN
	f_button_enable(True)
ELSE
	f_button_enable(False)
END IF





end event

type cb_delete from commandbutton within w_multi-dbupdate
integer x = 2656
integer y = 1588
integer width = 270
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;//==============================APPEON BEGIN==========================
// Event: clicked.cb_delete()
//--------------------------------------------------------------------
// Description: delete selectrow
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Nova		Date: Jul 23,2008
//--------------------------------------------------------------------
//	All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//	-------------------------------------------------------------------
//==============================APPEON END============================
//
IF f_isselectrow() <= 0 THEN RETURN
IF MessageBox("Delete", "Are you sure you want to delete the selected record?", Question!, YesNo!) = 2 THEN
	RETURN
END IF

// Delete row
dw_cache.DeleteRow(0)
//
dw_cache.Event RowFocusChanged(dw_cache.GetRow())

IF dw_cache.RowCount() > 0 THEN
	f_button_enable(True)
ELSE
	f_button_enable(False)
END IF



end event

type cb_add from commandbutton within w_multi-dbupdate
integer x = 2382
integer y = 1588
integer width = 270
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;
//==============================APPEON BEGIN==========================
// Event: clicked.cb_add()
//--------------------------------------------------------------------
// Description: addrow for dw_cache
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Nova		Date: Jul 23,2008
//--------------------------------------------------------------------
//	All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//	-------------------------------------------------------------------
//==============================APPEON END============================


Long ll_InsertRow

// Insert row
dw_cache.AcceptText()
ll_InsertRow = dw_cache.InsertRow(0)
IF ll_InsertRow <> -1 THEN
	dw_cache.ScrollToRow(ll_InsertRow)
END IF






end event

type cb_ping from commandbutton within w_multi-dbupdate
integer x = 2656
integer y = 1696
integer width = 270
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Ping"
end type

event clicked;//==============================APPEON BEGIN==========================
// Function: clicked.cb_ping()
//--------------------------------------------------------------------
// Description:try ping selected cache
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Nova		Date: Jul 23,2008
//--------------------------------------------------------------------
//	All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//	-------------------------------------------------------------------
//==============================APPEON END============================
Long ll_rowcount,temp_state,ll_ver
String ls_DBMS,ls_dbparm
String ls_dbtype
DateTime ld_updatetime
Boolean lb_select = False
IF dw_cache.RowCount() <= 0 THEN RETURN

FOR ll_rowcount = 1 To dw_cache.RowCount()
	IF dw_cache.Object.cache_selected[ll_rowcount] = 1 THEN
		lb_select = True
		EXIT
	END IF
	
NEXT

IF lb_select = False THEN
	MessageBox("Infor","You must select a cache that you want to ping!")
	RETURN
END IF

FOR ll_rowcount = 1 To dw_cache.RowCount()
	
	IF dw_cache.Object.cache_selected[ll_rowcount] = 1 THEN
		SetNull(temp_state)
		dw_cache.Object.State[ll_rowcount] = temp_state
		IF dw_cache.Object.cache_type[ll_rowcount] = '0' THEN
			ls_DBMS = 'ODB-ASA'
		ELSEIF dw_cache.Object.cache_type[ll_rowcount] = '1' THEN
			ls_DBMS = 'ODB-MSS'
		ELSE
			ls_DBMS = 'Unknown'
		END IF
		ls_dbparm = Lower(Trim(dw_cache.Object.cache_name[ll_rowcount]))
		
		//Added By Ken.Guo 07/11/2012
		If AppeonGetClientType() = 'PB' Then
			ls_dbparm = dw_cache.GetItemString(ll_rowcount, 'database_host')
			ls_DBMS = dw_cache.GetItemString(ll_rowcount, 'database_service_name')
		End If		
		
		IF f_connect_db(ls_dbparm,ls_DBMS,ll_rowcount,1) = 1 THEN
			dw_cache.Object.State[ll_rowcount] = 1 //ping sucessfull
			//get version, odb_type,lastupdate time
			f_get_result(ll_rowcount)
		ELSEIF f_connect_db(ls_dbparm,ls_DBMS,ll_rowcount,1) = -1 THEN
			dw_cache.Object.State[ll_rowcount] = 0
			//ping failed
		ELSEIF  f_connect_db(ls_dbparm,ls_DBMS,ll_rowcount,1) = 0 THEN
			MessageBox("Infor ","Can't upgrade db! ")
			RETURN
		END IF
		
	END IF
NEXT


//restore dbparm and dbms
//f_connect_db(is_current_dbprm,is_current_dbms,0,1)
f_connect_original_db()

//refresh global cache
app_filler.ids_screen_fields_cache.SetTransObject(SQLCA)
app_filler.ids_screen_objects_cache.SetTransObject(SQLCA)
app_filler.ids_screen_fields_cache.Retrieve()
app_filler.ids_screen_objects_cache.Retrieve()

IF dw_cache.AcceptText() = -1 THEN RETURN










end event

type rb_runafter from radiobutton within w_multi-dbupdate
boolean visible = false
integer x = 2921
integer y = 1000
integer width = 869
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Execute when application next run"
end type

type rb_runnow from radiobutton within w_multi-dbupdate
boolean visible = false
integer x = 2112
integer y = 1000
integer width = 800
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Execute now when saved"
boolean checked = true
end type

type cb_viewlog from commandbutton within w_multi-dbupdate
integer x = 2382
integer y = 1696
integer width = 270
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Viewlog"
end type

event clicked;//==============================APPEON BEGIN==========================
// Function: clicked.cb_viewlog()
//--------------------------------------------------------------------
// Description:view  log
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Nova		Date: Jul 23,2008
//--------------------------------------------------------------------
//	All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//	-------------------------------------------------------------------
//==============================APPEON END============================

IF f_isselectrow() <= 0 THEN RETURN
Long ll_cache_id
ll_cache_id = dw_cache.Object.cache_id[dw_cache.GetRow()]
OpenWithParm(w_logview,ll_cache_id)

end event

type cb_import from commandbutton within w_multi-dbupdate
boolean visible = false
integer x = 50
integer y = 1048
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Import[&I]"
end type

type rb_byselect from radiobutton within w_multi-dbupdate
boolean visible = false
integer x = 1198
integer y = 1000
integer width = 759
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Automatic update by selected"
end type

type rb_byask from radiobutton within w_multi-dbupdate
boolean visible = false
integer x = 654
integer y = 1000
integer width = 498
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ask before update"
boolean checked = true
end type

type gb_1 from groupbox within w_multi-dbupdate
boolean visible = false
integer x = 613
integer y = 892
integer width = 1385
integer height = 232
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Update method"
end type

type gb_2 from groupbox within w_multi-dbupdate
boolean visible = false
integer x = 2103
integer y = 892
integer width = 1765
integer height = 232
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Execute method"
end type

type gb_3 from groupbox within w_multi-dbupdate
integer x = 329
integer y = 1616
integer width = 585
integer height = 168
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Filter"
end type

