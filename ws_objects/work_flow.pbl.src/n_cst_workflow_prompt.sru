$PBExportHeader$n_cst_workflow_prompt.sru
forward
global type n_cst_workflow_prompt from nonvisualobject
end type
end forward

global type n_cst_workflow_prompt from nonvisualobject autoinstantiate
end type

type variables
boolean ib_prompt = True
long il_wf_id[], il_empty[]
boolean ib_show_prompt[], ib_empty[]
Integer ii_ai_notes_status[],ii_empty[]  //0: first run, 1: need add notes, -1: need not add notes
String is_ai_notes[],is_empty[]
end variables

forward prototypes
public subroutine of_set_wf_trigger (long al_wf_id, boolean ab_trigger)
public function boolean of_get_prompt_status ()
public subroutine of_set_prompt_status (boolean ab_enable)
public function boolean of_get_wf_trigger (long al_wf_id)
public subroutine of_reset ()
public function boolean of_get_wf_prompt (long al_wf_id)
public subroutine of_set_wf_ai_status (long al_wf_id, integer ai_status)
public function integer of_get_wf_ai_status (long al_wf_id)
public subroutine of_set_wf_ai_notes (long al_wf_id, string as_notes)
public function string of_get_wf_ai_notes (long al_wf_id)
end prototypes

public subroutine of_set_wf_trigger (long al_wf_id, boolean ab_trigger);Long i

If This.of_get_prompt_status( ) Then
	Return
End If

For i = 1 To UpperBound(il_wf_id[])
	If il_wf_id[i] = al_wf_id Then
		ib_show_prompt[i] = ab_trigger
	End If
Next

If i > UpperBound(il_wf_id[]) Then
	il_wf_id[UpperBound(il_wf_id) + 1 ] = al_wf_id
	ib_show_prompt[UpperBound(il_wf_id)] = ab_trigger
End If
end subroutine

public function boolean of_get_prompt_status ();Return ib_prompt
end function

public subroutine of_set_prompt_status (boolean ab_enable);If ib_prompt = True Then
	This.of_reset()
End If
ib_prompt = ab_enable
end subroutine

public function boolean of_get_wf_trigger (long al_wf_id);Long i
If This.of_get_prompt_status( ) Then
	Return True
End If

For i = 1 To UpperBound(il_wf_id[])
	If il_wf_id[i] = al_wf_id Then
		Return ib_show_prompt[i]
	End If
Next

Return True
end function

public subroutine of_reset ();ib_prompt = True
il_wf_id[] = il_empty[]
ib_show_prompt[] = ib_empty[]
ii_ai_notes_status[] = ii_empty[]
is_ai_notes[] = is_empty[]
end subroutine

public function boolean of_get_wf_prompt (long al_wf_id);Long i

If This.of_get_prompt_status( ) Then
	Return True
End If

For i = 1 To UpperBound(il_wf_id[])
	If il_wf_id[i] = al_wf_id Then
		Return False
	End If
Next

Return True

end function

public subroutine of_set_wf_ai_status (long al_wf_id, integer ai_status);//0 : not ini or first run. 1: need add notes, -1: need not add notes
Long i

If This.of_get_prompt_status( ) Then
	Return
End If

For i = 1 To UpperBound(il_wf_id[])
	If il_wf_id[i] = al_wf_id Then
		ii_ai_notes_status[i] = ai_status
		Exit
	End If
Next

Return 

end subroutine

public function integer of_get_wf_ai_status (long al_wf_id);//0 : not ini or first run. 1: need add notes, -1: need not add notes
Long i

If This.of_get_prompt_status( ) Then
	Return 0
End If

For i = 1 To UpperBound(il_wf_id[])
	If il_wf_id[i] = al_wf_id Then
		If UpperBound(ii_ai_notes_status[]) >= i Then
			Return ii_ai_notes_status[i]
		Else
			Return 0
		End If
	End If
Next

Return 0

end function

public subroutine of_set_wf_ai_notes (long al_wf_id, string as_notes);Long i

If This.of_get_prompt_status( ) Then
	Return
End If

For i = 1 To UpperBound(il_wf_id[])
	If il_wf_id[i] = al_wf_id Then
		is_ai_notes[i] = as_notes
		Exit
	End If
Next

Return 

end subroutine

public function string of_get_wf_ai_notes (long al_wf_id);Long i

For i = 1 To UpperBound(il_wf_id[])
	If il_wf_id[i] = al_wf_id Then
		If UpperBound(is_ai_notes[]) >= i Then
			Return is_ai_notes[i]
		End If
		Exit
	End If
Next

Return ''

end function

on n_cst_workflow_prompt.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_workflow_prompt.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

