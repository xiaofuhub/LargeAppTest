$PBExportHeader$u_lv_attachment.sru
$PBExportComments$(Appeon)Eugene 06.25.2013 - V141 ISG-CLX
forward
global type u_lv_attachment from u_lv
end type
end forward

global type u_lv_attachment from u_lv
event ue_do ( string as_type )
end type
global u_lv_attachment u_lv_attachment

type variables
String is_emlfile
Long il_mailid
String is_mail_format  //eml, doc format



end variables

forward prototypes
public subroutine of_reset_var ()
public subroutine of_set_var (long al_mailid, string as_emlfile, string as_mail_format)
end prototypes

event ue_do(string as_type);Parent.Dynamic Event ue_do_attachment(is_emlfile ,il_mailid, This.selectedindex(),as_type)
end event

public subroutine of_reset_var ();is_emlfile = ''
il_mailid = 0
is_mail_format = ''


end subroutine

public subroutine of_set_var (long al_mailid, string as_emlfile, string as_mail_format);This.of_reset_var( )
il_mailid = al_mailid
is_emlfile = as_emlfile
is_mail_format = as_mail_format

end subroutine

on u_lv_attachment.create
call super::create
end on

on u_lv_attachment.destroy
call super::destroy
end on

