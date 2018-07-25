$PBExportHeader$n_logservice.sru
forward
global type n_logservice from nonvisualobject
end type
end forward

global type n_logservice from nonvisualobject
end type
global n_logservice n_logservice

type variables

//LOG LEVEL
CONSTANT  int CI_LEVEL_INFO=1
CONSTANT  int CI_LEVEL_WARNING=2
CONSTANT  int CI_LEVEL_ERROR=3

String is_loglevel[]={"INFO","WARNING","ERROR"}
long     il_LogFileHandle
int      ii_LogLevel = CI_LEVEL_WARNING

String  is_WorkDir
String   is_LogFile

end variables

forward prototypes
public function integer of_log_error (string as_message)
public function integer of_log (string as_message)
public function integer of_log_warning (string as_message)
public function integer of_log (integer ai_loglevel, string as_message)
public function integer of_setloglevel (integer ai_level)
public function integer of_log_sqlca ()
public function integer of_log (string as_sql, string as_message, string as_title)
end prototypes

public function integer of_log_error (string as_message);//////////////////////////////////////////////////////////////////////
// $<function>of_log_error()
// $<arguments>
//		value	string	as_message		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 05.09.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

return of_log( CI_LEVEL_ERROR, as_message)
end function

public function integer of_log (string as_message);//////////////////////////////////////////////////////////////////////
// $<function>of_log()
// $<arguments>
//		value	string	as_message		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 05.09.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

return of_log( CI_LEVEL_INFO, as_message)
end function

public function integer of_log_warning (string as_message);//////////////////////////////////////////////////////////////////////
// $<function>of_log_warning()
// $<arguments>
//		value	string	as_message		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 05.09.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

return of_log( CI_LEVEL_WARNING, as_message)
end function

public function integer of_log (integer ai_loglevel, string as_message);//////////////////////////////////////////////////////////////////// //
// $<function>of_log_error()
// $<arguments>
//		value	string	as_message		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 05.09.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////



IF ai_loglevel < ii_LogLevel THEN
	RETURN 1
END IF

IF FileExists(is_LogFile) THEN
	IF FileLength(is_LogFile) > 2097152 THEN //2M
		FileClose(il_logfilehandle)
		FileCopy(is_LogFile,is_LogFile+".bak",True)
		FileDelete(is_LogFile)
		
		il_logfilehandle = FileOpen(is_LogFile,StreamMode!,Write!,Shared!,append!)
	END IF
END IF

//Added by Ken.Guo on 2009-04-10. Add cache name in log.
String ls_cachename 
If AppeonGetClientType() = 'WEB' Then
	If Lower(Left(SQLCA.dbparm,11)) = Lower('CacheName= ') Then
		ls_cachename = Mid(SQLCA.dbparm,12)
	End If
End If

as_message = "~r~n"+ ls_cachename + String(Now(),"yyyy-mm-dd hh:mm:ss.fff")+" ["+Upper(is_loglevel[ai_loglevel])+"] "+as_message+"~r~n"

FileWrite(il_logfilehandle,as_message)

String as_title,ls_sql
as_title = Upper(is_loglevel[ai_loglevel])
IF gb_write_log  THEN
	INSERT INTO Update_log
		(cache_id
		,update_user
		,log_title
		,log_message)
		VALUES
		(:gl_cache_id
		,:gs_user_id
		,:as_title
		,:as_message) Using CC_tansobject;
	COMMIT Using CC_tansobject;	
	IF gs_DBType = 'SQL' THEN
		ls_sql = "Update Update_log set update_date = getdate() where cache_id="+String(gl_cache_id)+" ;"
	ELSE
		ls_sql = "Update Update_log set update_date = now() where cache_id="+String(gl_cache_id)+" ;"
	END IF
	EXECUTE Immediate :ls_sql Using CC_tansobject;
	
END IF


RETURN 1

end function

public function integer of_setloglevel (integer ai_level);ii_loglevel = ai_level

return 1
end function

public function integer of_log_sqlca ();//////////////////////////////////////////////////////////////////////
// $<function>of_log_error()
// $<arguments>
//		value	string	as_message		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 05.09.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

IF sqlca.sqlcode = -1 THEN
	return of_log( CI_LEVEL_ERROR, "SQLCA.ERROR="+sqlca.sqlerrtext)
ELSE
	return 1
END IF
end function

public function integer of_log (string as_sql, string as_message, string as_title);//////////////////////////////////////////////////////////////////// //
// $<function>of_log()
// $<arguments>
//		value	string as_sql, string as_message, string as_title		
// $<returns> integer
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> By Alfee 01.30.2008
//////////////////////////////////////////////////////////////////////

String ls_sql

IF FileExists(is_LogFile) THEN
	IF FileLength(is_LogFile) > 2097152 THEN //2M
		FileClose(il_logfilehandle)
		FileCopy(is_LogFile,is_LogFile+".bak",True)
		FileDelete(is_LogFile)
		
		il_logfilehandle = FileOpen(is_LogFile,StreamMode!,Write!,Shared!,append!)
	END IF
END IF

//Added by Ken.Guo on 2009-04-10. Add cache name in log.
String ls_cachename 
If AppeonGetClientType() = 'WEB' Then
	If Lower(Left(SQLCA.dbparm,11)) = Lower('CacheName= ') Then
		ls_cachename = Mid(SQLCA.dbparm,12)
	End If
End If

as_title = "~r~n"+ls_cachename+String(Now(),"yyyy-mm-dd hh:mm:ss.fff")+" [Functionname:] " + as_title
FileWrite(il_logfilehandle,as_title)
//as_message = "~r~n"+string(now(),"yyyy-mm-dd yy:hh:ss.fff")+" [ERROR] " + as_message
as_sql = "~r~n"+ls_cachename+String(Now(),"yyyy-mm-dd hh:mm:ss.fff")+" [SQL Statement:] " + as_sql
FileWrite(il_logfilehandle,as_sql)

as_message = "~r~n"+ls_cachename+String(Now(),"yyyy-mm-dd hh:mm:ss.fff")+" [ERROR:] " + as_message +"~r~n"
FileWrite(il_logfilehandle,as_message)


IF gb_write_log  THEN
	INSERT INTO Update_log
		(cache_id
		,update_user
		,log_title
		,log_sql
		,log_message)
		VALUES
		(:gl_cache_id
		,:gs_user_id
		,:as_title
		,:as_sql
		,:as_message) Using CC_tansobject;
	COMMIT Using CC_tansobject;
	IF gs_DBType = 'SQL' THEN
		ls_sql = "Update Update_log set update_date = getdate() where cache_id="+String(gl_cache_id)+" ;"
	ELSE
		ls_sql = "Update Update_log set update_date = now() where cache_id="+String(gl_cache_id)+" ;"
	END IF
	EXECUTE Immediate :ls_sql Using CC_tansobject;
	
END IF

RETURN 1

end function

event constructor;is_WorkDir = gs_dir_path + gs_DefDirName
is_LogFile = gs_dir_path + gs_DefDirName + "\dbupdate.log"

IF NOT directoryexists(is_workdir) THEN
	createdirectory(is_workdir)
END IF



il_LogFileHandle = FileOpen(is_LogFile,StreamMode!,write!,shared!,append!)
FileWrite(il_LogFileHandle,"~r~n~r~n")
of_log("==========Log service initialized=========")


end event

on n_logservice.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_logservice.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;of_log("===========Log service finalized=========~r~n")
FileClose(il_LogFileHandle)
end event

