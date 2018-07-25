$PBExportHeader$appeon_nvo_db_update.sru
forward
global type appeon_nvo_db_update from nonvisualobject
end type
end forward

global type appeon_nvo_db_update from nonvisualobject autoinstantiate
end type

forward prototypes
public subroutine of_autocommit ()
public subroutine of_autocommitrollback ()
public subroutine of_autorollback ()
public subroutine of_commitqueue ()
public subroutine of_imdcall ()
public subroutine of_startqueue ()
public function integer of_update (datawindow adw_1, datawindow adw_2)
public function integer of_update (datawindow dw_1, datastore dw_2)
public function integer of_update (datastore dw_1, datawindow dw_2)
public function integer of_update (datastore dw_1, datastore dw_2)
public function integer of_update (datawindow dw_1, datawindow dw_2, datawindow dw_3)
public function integer of_update (datawindow dw_1, datawindow dw_2, datastore dw_3)
public function integer of_update (datawindow dw_1, datastore dw_2, datawindow dw_3)
public function integer of_update (datawindow dw_1, datastore dw_2, datastore dw_3)
public function integer of_update (datastore dw_1, datastore dw_2, datastore dw_3)
public function integer of_update (datastore dw_1, datawindow dw_2, datawindow dw_3)
public function integer of_update (datastore dw_1, datastore dw_2, datawindow dw_3)
public function integer of_update (datastore dw_1, datawindow dw_2, datastore dw_3)
public function integer of_update (datawindow dw_1, datawindow dw_2, datawindow dw_3, datastore dw_4)
public function integer of_update (datawindowchild dw_1, datawindow dw_2)
public function integer of_update (datawindowchild dw_1, datastore dw_2)
public function integer of_update (datawindow dw_1, datawindowchild dw_2)
public function integer of_update (datastore dw_1, datawindowchild dw_2)
public function integer of_update (datawindow dw_1, datawindow dw_2, datawindowchild dw_3)
public function integer of_update (datastore dw_1, datastore dw_2, datawindowchild dw_3)
public function integer of_update (datawindow dw_1, datastore dw_2, datawindowchild dw_3)
public function integer of_update (datastore dw_1, datawindow dw_2, datawindowchild dw_3)
public function integer of_update (datawindow dw_1, datawindowchild dw_2, datawindow dw_3)
public function integer of_update (datastore dw_1, datawindowchild dw_2, datastore dw_3)
public function integer of_update (datastore dw_1, datawindowchild dw_2, datawindow dw_3)
public function integer of_update (datawindow dw_1, datawindowchild dw_2, datastore dw_3)
public function integer of_update (datawindowchild dw_1, datawindow dw_2, datawindow dw_3)
public function integer of_update (datawindowchild dw_1, datastore dw_2, datastore dw_3)
public function integer of_update (datawindowchild dw_1, datawindow dw_2, datastore dw_3)
public function integer of_update (datawindowchild dw_1, datastore dw_2, datawindow dw_3)
public function integer of_update (datawindowchild dw_1, datawindowchild dw_2, datawindow dw_3)
public function integer of_update (datawindowchild dw_1, datawindowchild dw_2, datastore dw_3)
public function integer of_update (datawindowchild dw_1, datawindow dw_2, datawindowchild dw_3)
public function integer of_update (datawindowchild dw_1, datastore dw_2, datawindowchild dw_3)
public function integer of_update (datawindow dw_1, datawindowchild dw_2, datawindowchild dw_3)
public function integer of_update (datawindowchild dw_1, datawindowchild dw_2, datawindowchild dw_3)
public function integer of_update (datawindowchild dw_1, datawindowchild dw_2)
public function integer of_update (datastore dw_1, datawindowchild dw_2, datawindowchild dw_3)
end prototypes

public subroutine of_autocommit ();/***************************************
* Auto commit label
*
* Use case:
* of_AutoCommit()
* Insert into tab_1 ......
* Commit;
***************************************/
end subroutine

public subroutine of_autocommitrollback ();/***************************************
* Auto commit and rollback label
*
* Use case:
* of_AutoCommitRollback()
* Insert into tab_1 ......
* If SQLCA.SQLCODE = 0 Then
*    Commit;
* Else
*    Rollback;
* End if
***************************************/

end subroutine

public subroutine of_autorollback ();/***************************************
* Auto rollback label
*
* Use case:
* of_AutoRollback()
* Insert into tab_1 ......
* If SQLCA.SQLCODE = 0 Then
* Else
*    Rollback;
* End if
***************************************/
end subroutine

public subroutine of_commitqueue ();/***************************************
* Queue end label
*
***************************************/

end subroutine

public subroutine of_imdcall ();/***************************************
* Immediately send call to server
*
* Use case:
* of_ImdCall()
* Select ...
***************************************/
end subroutine

public subroutine of_startqueue ();/***************************************
* Queue start label
*
***************************************/
end subroutine

public function integer of_update (datawindow adw_1, datawindow adw_2);/******************************************************
* Update 2 Datawindows
******************************************************/
Integer li_Rtn

If adw_1.Update() = 1 Then
	If adw_2.Update() = 1 Then
		COMMIT;
		li_Rtn = 1
	Else
		ROLLBACK;
		li_Rtn = -102
	End if
Else
	ROLLBACK;
	li_Rtn = -101
End if

Return li_Rtn

end function

public function integer of_update (datawindow dw_1, datastore dw_2);if dw_1.Update()= 1 then
    if dw_2.Update()=1 then
       commit;
	    return 1
    else
       rollback;
	    return -102
    end if
else
	rollback;
	return -101
end if


end function

public function integer of_update (datastore dw_1, datawindow dw_2);if dw_1.Update()= 1 then
    if dw_2.Update()=1 then
       commit;
	    return 1
    else
       rollback;
	    return -102
    end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datastore dw_1, datastore dw_2);if dw_1.Update()= 1 then
    if dw_2.Update()=1 then
       commit;
	    return 1
    else
       rollback;
	    return -102
    end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datawindow dw_1, datawindow dw_2, datawindow dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datawindow dw_1, datawindow dw_2, datastore dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datawindow dw_1, datastore dw_2, datawindow dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datawindow dw_1, datastore dw_2, datastore dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datastore dw_1, datastore dw_2, datastore dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datastore dw_1, datawindow dw_2, datawindow dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datastore dw_1, datastore dw_2, datawindow dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datastore dw_1, datawindow dw_2, datastore dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datawindow dw_1, datawindow dw_2, datawindow dw_3, datastore dw_4);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
			if dw_4.update()=1 then
            commit;
	         return 1
		   else
				rollback;
				return -104
			end if
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if

end function

public function integer of_update (datawindowchild dw_1, datawindow dw_2);if dw_1.Update()= 1 then
    if dw_2.Update()=1 then
       commit;
	    return 1
    else
       rollback;
	    return -102
    end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datawindowchild dw_1, datastore dw_2);if dw_1.Update()= 1 then
    if dw_2.Update()=1 then
       commit;
	    return 1
    else
       rollback;
	    return -102
    end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datawindow dw_1, datawindowchild dw_2);if dw_1.Update()= 1 then
    if dw_2.Update()=1 then
       commit;
	    return 1
    else
       rollback;
	    return -102
    end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datastore dw_1, datawindowchild dw_2);if dw_1.Update()= 1 then
    if dw_2.Update()=1 then
       commit;
	    return 1
    else
       rollback;
	    return -102
    end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datawindow dw_1, datawindow dw_2, datawindowchild dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datastore dw_1, datastore dw_2, datawindowchild dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datawindow dw_1, datastore dw_2, datawindowchild dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datastore dw_1, datawindow dw_2, datawindowchild dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datawindow dw_1, datawindowchild dw_2, datawindow dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datastore dw_1, datawindowchild dw_2, datastore dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datastore dw_1, datawindowchild dw_2, datawindow dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datawindow dw_1, datawindowchild dw_2, datastore dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datawindowchild dw_1, datawindow dw_2, datawindow dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datawindowchild dw_1, datastore dw_2, datastore dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datawindowchild dw_1, datawindow dw_2, datastore dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datawindowchild dw_1, datastore dw_2, datawindow dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datawindowchild dw_1, datawindowchild dw_2, datawindow dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datawindowchild dw_1, datawindowchild dw_2, datastore dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datawindowchild dw_1, datawindow dw_2, datawindowchild dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datawindowchild dw_1, datastore dw_2, datawindowchild dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datawindow dw_1, datawindowchild dw_2, datawindowchild dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datawindowchild dw_1, datawindowchild dw_2, datawindowchild dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datawindowchild dw_1, datawindowchild dw_2);if dw_1.Update()= 1 then
    if dw_2.Update()=1 then
       commit;
	    return 1
    else
       rollback;
	    return -102
    end if
else
	rollback;
	return -101
end if
end function

public function integer of_update (datastore dw_1, datawindowchild dw_2, datawindowchild dw_3);if dw_1.Update()= 1 then
   if dw_2.Update()=1 then
	   if dw_3.update()=1 then
         commit;
	      return 1
		else
	      rollback;
			return -103
		end if
   else
      rollback;
	   return -102
   end if
else
	rollback;
	return -101
end if
end function

on appeon_nvo_db_update.create
call super::create
TriggerEvent( this, "constructor" )
end on

on appeon_nvo_db_update.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

