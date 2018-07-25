$PBExportHeader$n_cst_message.sru
forward
global type n_cst_message from nonvisualobject
end type
end forward

global type n_cst_message from nonvisualobject autoinstantiate
end type

type variables
//alfee 02.06.2010

string is_err_msg 
long il_processed_cnt

boolean ib_schedule = FALSE



end variables

forward prototypes
public subroutine of_messagebox (string as_title, string as_text, boolean as_flag)
public subroutine of_messagebox (string as_title, string as_text, icon aicon, boolean as_flag)
public subroutine of_messagebox (string as_title, string as_text, icon aicon, button abutton, boolean as_flag)
public function integer of_messagebox (string as_title, string as_text, icon aicon, button abutton, integer adefault, boolean as_flag)
public function string of_get_message ()
public function long of_get_proc_cnt ()
public function integer of_set_proc_cnt (long al_proc_cnt)
public function integer of_set_proc_cnt (long al_proc_cnt, boolean ab_plus)
public function string of_get_message (string as_title, string as_text)
public function integer of_set_schedule (boolean ab_schedule)
public function integer of_set_message (string as_message)
end prototypes

public subroutine of_messagebox (string as_title, string as_text, boolean as_flag);//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
IF gb_AutoSchedule OR ib_schedule THEN
	//is_err_msg += 'Title: '+as_title+' Message:'+as_text+'~r~n'
	if isnull(as_title) then as_title = ''
	if isnull(as_text) then as_text = ''
	is_err_msg += as_title +': ' + as_text + '~r~n'	
ELSE
	IF as_flag THEN
		MessageBox(as_title,as_text)
	END IF
END IF


end subroutine

public subroutine of_messagebox (string as_title, string as_text, icon aicon, boolean as_flag);//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
IF gb_AutoSchedule OR ib_schedule THEN
	//is_err_msg += 'Title: '+as_title+' Message:'+as_text+'~r~n'
	if isnull(as_title) then as_title = ''
	if isnull(as_text) then as_text = ''	
	is_err_msg += as_title +': ' + as_text + '~r~n'		
ELSE
	IF as_flag THEN
		MessageBox(as_title,as_text,aicon)
	END IF
END IF


end subroutine

public subroutine of_messagebox (string as_title, string as_text, icon aicon, button abutton, boolean as_flag);//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
IF gb_AutoSchedule OR ib_schedule THEN
	//is_err_msg += 'Title: '+as_title+' Message:'+as_text+'~r~n'
	if isnull(as_title) then as_title = ''
	if isnull(as_text) then as_text = ''	
	is_err_msg += as_title +': ' + as_text + '~r~n'		
ELSE
	IF as_flag THEN
		MessageBox(as_title,as_text,aicon,abutton)
	END IF
END IF


end subroutine

public function integer of_messagebox (string as_title, string as_text, icon aicon, button abutton, integer adefault, boolean as_flag);//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
IF gb_AutoSchedule OR ib_schedule THEN 
	//is_err_msg +='Title: '+as_title+' Message:'+as_text+'~r~n'
	if isnull(as_title) then as_title = ''
	if isnull(as_text) then as_text = ''	
	is_err_msg += as_title +': ' + as_text + '~r~n'		
	if adefault=1 then
		return 2
	end if
ELSE
	IF as_flag THEN
  		return MessageBox(as_title,as_text,aicon,abutton,adefault)
	END IF
END IF

end function

public function string of_get_message ();//Return the message - (scheduler) alfee 02.06.2010

If isnull(is_err_msg) then is_err_msg ='' //03.16.2010

Return is_err_msg
end function

public function long of_get_proc_cnt ();//Get the count of proceeded records 

return il_processed_cnt
end function

public function integer of_set_proc_cnt (long al_proc_cnt);//Set the count of proceeded records - alfee 02.06.2010

of_set_proc_cnt(al_proc_cnt, false)

return 1
end function

public function integer of_set_proc_cnt (long al_proc_cnt, boolean ab_plus);//Set the count of proceeded records - alfee 02.06.2010

if not gb_AutoSchedule and not ib_schedule then return 1

if ab_plus = true then
	il_processed_cnt += al_proc_cnt
else
	il_processed_cnt = al_proc_cnt
end if

return 1
end function

public function string of_get_message (string as_title, string as_text);//Return the combined message - (Scheduler) alfee 02.06.2010

//Return 'Title: '+as_title+' Message:'+as_text+'~r~n'

Return as_title +': '+as_text+'~r~n'



end function

public function integer of_set_schedule (boolean ab_schedule);//Set the schedule flag - alfee 02.25.2010

ib_schedule = ab_schedule

RETURN 1
end function

public function integer of_set_message (string as_message);//Set the message - (scheduler) alfee 03.17.2010

If isnull(as_message) then as_message =''

is_err_msg = as_message

return 1
end function

on n_cst_message.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_message.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

