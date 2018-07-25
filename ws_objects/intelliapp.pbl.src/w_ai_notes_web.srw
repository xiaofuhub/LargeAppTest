$PBExportHeader$w_ai_notes_web.srw
forward
global type w_ai_notes_web from w_ai_notes
end type
end forward

global type w_ai_notes_web from w_ai_notes
end type
global w_ai_notes_web w_ai_notes_web

on w_ai_notes_web.create
call super::create
end on

on w_ai_notes_web.destroy
call super::destroy
end on

event open;call super::open;//Make this window inherited from w_ai_notes  and set the Print button to invisible - alfee 09.12.2012
//Note: Printing to Adobe PDF Writer for a RTE control is not supported well by APB. 

end event

type cb_mailed from w_ai_notes`cb_mailed within w_ai_notes_web
end type

type st_len from w_ai_notes`st_len within w_ai_notes_web
end type

type cb_fax from w_ai_notes`cb_fax within w_ai_notes_web
end type

type cb_6 from w_ai_notes`cb_6 within w_ai_notes_web
end type

type cb_email from w_ai_notes`cb_email within w_ai_notes_web
end type

type cb_5 from w_ai_notes`cb_5 within w_ai_notes_web
end type

type cb_1 from w_ai_notes`cb_1 within w_ai_notes_web
end type

type cb_2 from w_ai_notes`cb_2 within w_ai_notes_web
end type

type mle_note from w_ai_notes`mle_note within w_ai_notes_web
end type

type cb_phone from w_ai_notes`cb_phone within w_ai_notes_web
end type

type cb_4 from w_ai_notes`cb_4 within w_ai_notes_web
end type

type gb_1 from w_ai_notes`gb_1 within w_ai_notes_web
end type

