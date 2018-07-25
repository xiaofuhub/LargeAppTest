$PBExportHeader$n_tr.sru
$PBExportComments$Extension Transaction class
forward
global type n_tr from pfc_n_tr
end type
end forward

global type n_tr from pfc_n_tr
end type
global n_tr n_tr

type prototypes
SUBROUTINE ProcessExpiringCredentials ( &
	string calling_user, &
	datetime update_dt, &
	ref long existing_verif_count, &
	ref long duplicate_verif_count, &
	ref long letter_count, &
	ref long psv_count, &
	ref long updated_count, &
	ref long fail_count &
) RPCFUNC ALIAS FOR "dbo.up_expiring_credentials"
SUBROUTINE ResendLetters () RPCFUNC ALIAS FOR "dbo.up_resend_letters"

end prototypes

forward prototypes
public function integer of_processexpiringcredentials (string as_calling_user, datetime adt_update, ref long al_existing_verif_count, ref long al_duplicate_verif_count, ref long al_letter_count, ref long al_psv_count, ref long al_updated_count, ref long al_fail_count)
public function integer of_resendletters ()
end prototypes

public function integer of_processexpiringcredentials (string as_calling_user, datetime adt_update, ref long al_existing_verif_count, ref long al_duplicate_verif_count, ref long al_letter_count, ref long al_psv_count, ref long al_updated_count, ref long al_fail_count);//	Function of_processExpiringCredentials
//
//	Arguments:
//		as_calling_user					ID of the user who will be credited with creating expiring credentials
//		adt_update						The timestamp to use to mark newly inserted/updated records. Use client-side timestamp for backward compatability
//		ref al_existing_verif_count	Number of existing notifications encountered for same (rec_id, prac_id, facility_id)
//		ref al_duplicate_verif_count	Number of redundant occurrences of same (rec_id, prac_id, facility_id) which had to be skipped to prevent duplicate verifications
//		ref al_letter_count				Number of letters created
//		ref al_psv_count				Number of primary source verifications created
//		ref al_updated_count			Number of previously existing verif_info records updated with exp_credential_flag = 2
//		ref al_fail_count				Number of verif_info records which failed to be created (for backward compatability; should always be 0)
//
//	Description:
//		Wrapper function to call stored procedure up_expiring_credentials
//		Assume that this function call will be handled as a standalone trasaction with it's own COMMIT or ROLLBACK
//
//	History:
//	4.4.2016		Initial version by <RP>
//
boolean lb_prevAutoCommit

/* Local values to pass as reference args */
long ll_existing_verif_count
long ll_duplicate_verif_count
long ll_letter_count
long ll_psv_count
long ll_updated_count
long ll_fail_count
string ls_msg, ls_sqldbcode, ls_sqlerrtext
integer li_ret

/* Save current value of AutoCommit */
lb_prevAutoCommit = this.AutoCommit
this.AutoCommit = FALSE

this.ProcessExpiringCredentials( &
	as_calling_user, &
	adt_update, &
	ll_existing_verif_count, &
	ll_duplicate_verif_count, &
	ll_letter_count, &
	ll_psv_count, &
	ll_updated_count, &
	ll_fail_count &
)

IF this.sqlcode = -1 Then
	ls_sqldbcode = String(this.sqldbcode)
	ls_sqlerrtext = this.sqlerrtext
	this.of_rollback()

	ls_msg = "An error occurred while executing procedure up_expiring_credentials.~r~n~r~n" &
		+ "SQLDBCode: " + ls_sqldbcode + "~r~n~r~n" &
		+ "SQLErrText: " + ls_sqlerrtext
	messageBox(gnv_app.iapp_object.displayname, ls_msg)
	li_ret = -1
ELSE
	this.of_commit()
	al_existing_verif_count = ll_existing_verif_count
	al_duplicate_verif_count = ll_duplicate_verif_count
	al_letter_count = ll_letter_count
	al_psv_count = ll_psv_count
	al_updated_count = ll_updated_count
	al_fail_count = ll_fail_count
	li_ret = 1
END IF

this.AutoCommit = lb_prevAutoCommit
return li_ret

end function

public function integer of_resendletters ();//	Function of_resendLetters
//
//	Description:
//		Wrapper function to call stored procedure up_resend_letters
//		Assume that this function call will be handled as a standalone trasaction with it's own COMMIT or ROLLBACK
//
//	History:
//	4.8.2016		Initial version by <RP>
//
boolean lb_prevAutoCommit
string ls_sqldbcode, ls_sqlerrtext, ls_msg
integer li_ret

/* Save current value of AutoCommit */
lb_prevAutoCommit = this.AutoCommit
this.AutoCommit = FALSE

this.ResendLetters()

IF this.sqlcode = -1 Then
	ls_sqldbcode = String(this.sqldbcode)
	ls_sqlerrtext = this.sqlerrtext
	this.of_rollback()

	ls_msg = "An error occurred while executing procedure up_resend_letters.~r~n~r~n" &
		+ "SQLDBCode: " + ls_sqldbcode + "~r~n~r~n" &
		+ "SQLErrText: " + ls_sqlerrtext
	messageBox(gnv_app.iapp_object.displayname, ls_msg)
	li_ret = -1
ELSE
	this.of_commit()
	li_ret = 1
END IF

this.AutoCommit = lb_prevAutoCommit
return li_ret

end function

on n_tr.create
call super::create
end on

on n_tr.destroy
call super::destroy
end on

