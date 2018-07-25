$PBExportHeader$n_cst_dashboard_data.sru
forward
global type n_cst_dashboard_data from nonvisualobject
end type
end forward

global type n_cst_dashboard_data from nonvisualobject
end type
global n_cst_dashboard_data n_cst_dashboard_data

type variables
n_ds ids_gadget_recents_prac,ids_gadget_recents_ctx
end variables

forward prototypes
public function integer of_update_gadgets_recent (string as_recent_type, long ai_data_id, long ai_data_ext_id)
public subroutine of_retrieve ()
end prototypes

public function integer of_update_gadgets_recent (string as_recent_type, long ai_data_id, long ai_data_ext_id);//var
Long ll_ctx_record_cnt,ll_prac_record_cnt,ll_find_ctx
DateTime ldt_accessDateTime
ldt_accessDateTime = DateTime(today(),Now())


//process
IF as_recent_type = 'CTX' THEN
	ll_ctx_record_cnt = ids_gadget_recents_ctx.RowCount( )
	IF ll_ctx_record_cnt = 0 THEN //direct insert 
		ids_gadget_recents_ctx.InsertRow( 0)
		ids_gadget_recents_ctx.SetItem( 1, "user_id",gs_user_id )
		ids_gadget_recents_ctx.SetItem( 1, "data_id",ai_data_id )
		//ids_gadget_recents_ctx.SetItem( 1, "data_ext_id","" )
		ids_gadget_recents_ctx.SetItem( 1, "access_date",ldt_accessDateTime)
		ids_gadget_recents_ctx.SetItem( 1, "recent_type",as_recent_type )
	ELSEIF ll_ctx_record_cnt > 0 And ll_ctx_record_cnt < 10 THEN //find then insert or update
		ll_find_ctx = ids_gadget_recents_ctx.Find("data_id="+String(ai_data_id), 1, ll_ctx_record_cnt)
		IF ll_find_ctx > 0 THEN
			ids_gadget_recents_ctx.SetItem( ll_find_ctx, "user_id",gs_user_id )
			ids_gadget_recents_ctx.SetItem( ll_find_ctx, "data_id",ai_data_id )
			//ids_gadget_recents_ctx.SetItem( ll_find_ctx, "data_ext_id","" )
			ids_gadget_recents_ctx.SetItem( ll_find_ctx, "access_date",ldt_accessDateTime)
			ids_gadget_recents_ctx.SetItem(ll_find_ctx, "recent_type",as_recent_type )
		ELSE
			ids_gadget_recents_ctx.InsertRow( 0)
			ids_gadget_recents_ctx.SetItem(ll_ctx_record_cnt +1, "user_id",gs_user_id )
			ids_gadget_recents_ctx.SetItem(ll_ctx_record_cnt +1, "data_id",ai_data_id )
			//ids_gadget_recents_ctx.SetItem(ll_ctx_record_cnt +1, "data_ext_id","" )
			ids_gadget_recents_ctx.SetItem(ll_ctx_record_cnt +1, "access_date",ldt_accessDateTime)
			ids_gadget_recents_ctx.SetItem(ll_ctx_record_cnt +1, "recent_type",as_recent_type )
		END IF
	ELSEIF ll_ctx_record_cnt >= 10 THEN //find then insert or update
		ll_find_ctx = ids_gadget_recents_ctx.Find("data_id="+String(ai_data_id), 1, ll_ctx_record_cnt)
		IF ll_find_ctx > 0 THEN
			ids_gadget_recents_ctx.SetItem( ll_find_ctx, "user_id",gs_user_id )
			ids_gadget_recents_ctx.SetItem( ll_find_ctx, "data_id",ai_data_id )
			//ids_gadget_recents_ctx.SetItem( ll_find_ctx, "data_ext_id","" )
			ids_gadget_recents_ctx.SetItem( ll_find_ctx, "access_date",ldt_accessDateTime)
			ids_gadget_recents_ctx.SetItem( ll_find_ctx, "recent_type",as_recent_type )
		ELSE //find the oldest record
			ids_gadget_recents_ctx.SetItem( 10, "user_id",gs_user_id )
			ids_gadget_recents_ctx.SetItem( 10, "data_id",ai_data_id )
			//ids_gadget_recents_ctx.SetItem( 10, "data_ext_id","" )
			ids_gadget_recents_ctx.SetItem( 10, "access_date",ldt_accessDateTime)
			ids_gadget_recents_ctx.SetItem( 10, "recent_type",as_recent_type )
		END IF
	END IF
ELSEIF  as_recent_type = 'PRAC' THEN
	ll_prac_record_cnt = ids_gadget_recents_prac.RowCount( )
	IF ll_prac_record_cnt = 0 THEN //direct insert 
		ids_gadget_recents_prac.InsertRow( 0)
		ids_gadget_recents_prac.SetItem( 1, "user_id",gs_user_id )
		ids_gadget_recents_prac.SetItem( 1, "data_id",ai_data_id )
		ids_gadget_recents_prac.SetItem( 1, "data_ext_id",ai_data_ext_id)
		ids_gadget_recents_prac.SetItem( 1, "access_date",ldt_accessDateTime)
		ids_gadget_recents_prac.SetItem( 1, "recent_type",as_recent_type )
	ELSEIF ll_prac_record_cnt > 0 And ll_prac_record_cnt < 10 THEN //find then insert or update
		ll_find_ctx = ids_gadget_recents_prac.Find("data_id="+String(ai_data_id) +" and data_ext_id="+String(ai_data_ext_id), 1, ll_prac_record_cnt)
		IF ll_find_ctx > 0 THEN
			ids_gadget_recents_prac.SetItem( ll_find_ctx, "user_id",gs_user_id )
			ids_gadget_recents_prac.SetItem( ll_find_ctx, "data_id",ai_data_id )
			ids_gadget_recents_prac.SetItem( ll_find_ctx, "data_ext_id",ai_data_ext_id)
			ids_gadget_recents_prac.SetItem( ll_find_ctx, "access_date",ldt_accessDateTime)
			ids_gadget_recents_prac.SetItem(ll_find_ctx, "recent_type",as_recent_type )
		ELSE
			ids_gadget_recents_prac.InsertRow( 0)
			ids_gadget_recents_prac.SetItem(ll_prac_record_cnt +1, "user_id",gs_user_id )
			ids_gadget_recents_prac.SetItem(ll_prac_record_cnt +1, "data_id",ai_data_id )
			ids_gadget_recents_prac.SetItem(ll_prac_record_cnt +1, "data_ext_id",ai_data_ext_id )
			ids_gadget_recents_prac.SetItem(ll_prac_record_cnt +1, "access_date",ldt_accessDateTime)
			ids_gadget_recents_prac.SetItem(ll_prac_record_cnt +1, "recent_type",as_recent_type )
		END IF
	ELSEIF ll_prac_record_cnt >= 10 THEN //find then insert or update
		ll_find_ctx = ids_gadget_recents_prac.Find("data_id="+String(ai_data_id) +" and data_ext_id="+String(ai_data_ext_id), 1, ll_prac_record_cnt)
		IF ll_find_ctx > 0 THEN
			ids_gadget_recents_prac.SetItem( ll_find_ctx, "user_id",gs_user_id )
			ids_gadget_recents_prac.SetItem( ll_find_ctx, "data_id",ai_data_id )
			ids_gadget_recents_prac.SetItem( ll_find_ctx, "data_ext_id",ai_data_ext_id)
			ids_gadget_recents_prac.SetItem( ll_find_ctx, "access_date",ldt_accessDateTime)
			ids_gadget_recents_prac.SetItem(ll_find_ctx, "recent_type",as_recent_type )
		ELSE
			ids_gadget_recents_prac.SetItem(10, "user_id",gs_user_id )
			ids_gadget_recents_prac.SetItem(10, "data_id",ai_data_id )
			ids_gadget_recents_prac.SetItem(10, "data_ext_id",ai_data_ext_id )
			ids_gadget_recents_prac.SetItem(10, "access_date",ldt_accessDateTime)
			ids_gadget_recents_prac.SetItem(10, "recent_type",as_recent_type )
		END IF
	END IF
END IF

ids_gadget_recents_prac.SetSort('access_date Desc')
ids_gadget_recents_prac.Sort()
ids_gadget_recents_ctx.SetSort('access_date Desc')
ids_gadget_recents_ctx.Sort()

//save ids_gadget_recents_prac
gnv_appeondb.of_autocommitrollback( )
IF ids_gadget_recents_prac.ModifiedCount( ) > 0 THEN
	IF ids_gadget_recents_prac.Update( ) = 1 THEN
		Commit;
		If Isvalid(w_dashboard) Then 
			w_dashboard.Event ue_retrieve_target_gadgets('u_gadget_7')
		End If
		RETURN 1
	ELSE
		Rollback;
		of_retrieve() //Added By Ken.Guo 07/01/2013		
		RETURN -1
	END IF
END IF
//save ids_gadget_recents_ctx
IF ids_gadget_recents_ctx.ModifiedCount( ) > 0 THEN
	IF ids_gadget_recents_ctx.Update( ) = 1 THEN
		Commit;
		If Isvalid(w_dashboard) Then 
			w_dashboard.Event ue_retrieve_target_gadgets('u_gadget_8')
		End If
		RETURN 1
	ELSE
		Rollback;
		of_retrieve() //Added By Ken.Guo 07/01/2013		
		RETURN -1
	END IF
END IF

RETURN 1





end function

public subroutine of_retrieve ();//Added By Ken.Guo 07/01/2013
gnv_appeondb.of_startqueue( )
	ids_gadget_recents_prac.Retrieve(gs_user_id)
	ids_gadget_recents_ctx.Retrieve(gs_user_id)
gnv_appeondb.of_commitqueue( )

end subroutine

on n_cst_dashboard_data.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_dashboard_data.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_gadget_recents_prac = Create n_ds
ids_gadget_recents_prac.Dataobject = 'd_dashb_gadget_recent_prac_data'
ids_gadget_recents_prac.SetTransObject(SQLCA)

ids_gadget_recents_ctx = Create n_ds
ids_gadget_recents_ctx.Dataobject = 'd_dashb_gadget_recent_ctx_data'
ids_gadget_recents_ctx.SetTransObject(SQLCA)

//Added By Ken.Guo 07/01/2013
of_retrieve()
end event

