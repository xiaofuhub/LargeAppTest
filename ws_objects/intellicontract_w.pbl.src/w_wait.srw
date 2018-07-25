$PBExportHeader$w_wait.srw
forward
global type w_wait from w_appeon_gifofwait
end type
end forward

global type w_wait from w_appeon_gifofwait
end type
global w_wait w_wait

event timer;//Overrided - Alfee 06.24.2008
end event

on w_wait.create
call super::create
end on

on w_wait.destroy
call super::destroy
end on

type hpb_1 from w_appeon_gifofwait`hpb_1 within w_wait
end type

type st_1 from w_appeon_gifofwait`st_1 within w_wait
end type

type p_1 from w_appeon_gifofwait`p_1 within w_wait
end type

