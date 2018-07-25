$PBExportHeader$n_cst_dwcache.sru
$PBExportComments$Extension DataWindow Caching service
forward
global type n_cst_dwcache from pfc_n_cst_dwcache
end type
end forward

global type n_cst_dwcache from pfc_n_cst_dwcache
end type
global n_cst_dwcache n_cst_dwcache

type variables
String is_cachename_refreshed[] //Added by Appeon long.zhang 03.09.2017 (Contracts Module Slowness)
end variables

forward prototypes
public function long of_refreshifempty (string as_id)
public function integer of_getregistered (string as_id, ref n_ds ads_cache)
public function integer of_getregistered (string as_id, ref n_ds ads_cache, boolean ab_refreshifempty)
public function boolean of_is_cachename_refreshed (string as_cachename)
public subroutine of_add_cachename_refreshed (string as_cachename)
end prototypes

public function long of_refreshifempty (string as_id);//////////////////////////////////////////////////////////////////////////////
//	Public Function:	of_RefreshIfEmpty
//	Arguments:		as_id			The ID of the registered datastore
//
//	Returns:  		Long 		The number of rows in the cache, if successful
//									-1 - Error, or cache is not registered
//
//	Description:		If the identified cache is empty, refresh it
//						Return the number of rows in the cache
//////////////////////////////////////////////////////////////////////////////
//	Rev. History:	Date
//						3.4.2016   Initial version by Ronnie Po
//////////////////////////////////////////////////////////////////////////////
n_ds lds_cache
//integer li_ret
Long ll_rtn //Added by Appeon long.zhang 03.09.2017

IF of_isRegistered(as_id) <> 1 THEN
	return -1
ELSEIF of_getRegistered(as_id, lds_cache, FALSE) <> 1 THEN
	return -1
ELSEIF lds_cache.rowCount() = 0 THEN
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 03.09.2017
	//<$>reason:if rowcount = 0 and this cache was retrieved before this, don't retrieve it again, For Contracts Module Slowness.
	//return of_refresh(as_id)
	If of_is_cachename_refreshed(as_id)  Then
		Return 0
	Else
		ll_rtn = of_refresh(as_id)
		
		of_add_cachename_refreshed(as_id) //Remember this cache has been retrieved.
	End If	
	//------------------- APPEON END -------------------
ELSE
	return lds_cache.rowCount()
END IF

end function

public function integer of_getregistered (string as_id, ref n_ds ads_cache);//----------------------- <RP> 3.7.2016 ----------------------------------------------------------
//	Modified to provide just-in-time caching functionality
//	Assume that all registered cache datastores have NOT been refreshed. Each cache is refreshed
//	only as necessary - when calling this method
//

return of_getRegistered(as_id, ads_cache, TRUE)

end function

public function integer of_getregistered (string as_id, ref n_ds ads_cache, boolean ab_refreshifempty);//////////////////////////////////////////////////////////////////////////////
//	Public Function:	of_GetRegistered
//	Arguments:		as_id			The ID of the registered datastore for which a reference is wanted.
//						ads_cache	A reference to the Datastore matching the passed ID (by reference).
//						ab_refreshIfEmpty		If TRUE, then refresh ads_cache if it is empty.
//	Returns:  		Integer 		1 success the ads_cache holds the desired reference, -1 error.
//	Description:		Returns a reference to the Datastore matching the passed ID.
//////////////////////////////////////////////////////////////////////////////
//	Rev. History:	3.1.2016		<RP>		Added this variation of the function to preserve backward compatability
//													when implementing automatic just-in-time caching
//////////////////////////////////////////////////////////////////////////////
integer li_ret

li_ret = SUPER::of_getregistered(as_id, ads_cache)

IF (li_ret = 1) AND ab_refreshIfEmpty THEN
	of_RefreshIfEmpty(as_id)
END IF

return li_ret

end function

public function boolean of_is_cachename_refreshed (string as_cachename);//====================================================================
//$<Function>: of_is_cachename_refreshed
//$<Arguments>:
// 	value    string    as_catchname
//$<Return>:  (None)
//$<Description>: Check whether this cachename was ever refreshd.
//$<Author>: (Appeon) long.zhang 03.09.2017 (Contracts Module Slowness)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
n_cst_string lnv_string

Return lnv_string.of_isexists( is_cachename_refreshed[], as_cachename)


end function

public subroutine of_add_cachename_refreshed (string as_cachename);//====================================================================
//$<Function>: of_add_cachename_refreshd
//$<Arguments>:
// 	value    string    as_catchname
//$<Return>:  (None)
//$<Description>: Remember that this cachename has been refreshd.
//$<Author>: (Appeon) long.zhang 03.09.2017 (Contracts Module Slowness)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
If Not (of_is_cachename_refreshed(as_cachename)) Then &
	is_cachename_refreshed[UpperBound(is_cachename_refreshed[]) + 1] = as_cachename
end subroutine

on n_cst_dwcache.create
call super::create
end on

on n_cst_dwcache.destroy
call super::destroy
end on

