$PBExportHeader$w_idle_web.srw
$PBExportComments$[pfeapsrv]
forward
global type w_idle_web from window
end type
type st_1 from statictext within w_idle_web
end type
type st_message from u_st within w_idle_web
end type
type cb_1 from u_cb within w_idle_web
end type
end forward

global type w_idle_web from window
integer width = 2487
integer height = 828
boolean titlebar = true
windowtype windowtype = popup!
long backcolor = 32891346
boolean center = true
st_1 st_1
st_message st_message
cb_1 cb_1
end type
global w_idle_web w_idle_web

type prototypes
FUNCTION boolean Beep(long freq,long dur) LIBRARY "Kernel32.dll"
end prototypes

type variables
long il_time = 31
end variables

forward prototypes
public subroutine of_halt_close ()
end prototypes

public subroutine of_halt_close ();//====================================================================
//$<Function>: of_halt_close()
//$<Arguments>:
//$<Return>:  
//$<Description>: It's valid in IE 10.0.9200.16721 (10.0.10 (KB2879017))
//$<Author>: (Appeon) Alfee 12.02.2014 (for bug 4326)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Halt Close
end subroutine

event open;st_message.text = ''

timer(1)
end event

event timer;Integer li_sec
Long ll_freq, ll_dur
Long i //alfee 12.01.2014
Boolean rtn

if  il_time < 32 then 
	this.bringtotop = true
	il_time = il_time - 1
	li_sec = il_time
	st_message.text = "Closing in " + string( li_sec) + ' seconds' 
	ll_freq = 500
	ll_dur = 20
	choose case li_sec
		case 30,29,28,20,19,10
			Beep(1) //alfee 10.25.2012
	end  choose
end if

if il_time < 1 then
	for i = upperbound(gw_response) to 1 step -1
		if isvalid (gw_response[i]) then post close(gw_response[i]) //alfee 12.01.2014 for bug 4326  
	next	
	
	post close( this) //alfee 11.28.2014
	post of_halt_close () //alfee 12.02.2014
	
	halt close
end if


end event

on w_idle_web.create
this.st_1=create st_1
this.st_message=create st_message
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.st_message,&
this.cb_1}
end on

on w_idle_web.destroy
destroy(this.st_1)
destroy(this.st_message)
destroy(this.cb_1)
end on

type st_1 from statictext within w_idle_web
integer x = 5
integer y = 72
integer width = 2482
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32891346
string text = "text set in constructor event"
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;string ls_time

if gnv_app.il_itle_time < 60 then 
     ls_time =  string(gnv_app.il_itle_time) + " seconds."
else
	  ls_time = string(gnv_app.il_itle_time/60) + " minutes."
end if 

text = "The application has been idle for " + ls_time + "  The application will now be closing.~rUNSAVED DATA WILL BE LOST."
end event

type st_message from u_st within w_idle_web
integer y = 256
integer width = 2450
integer height = 204
integer textsize = -18
fontcharset fontcharset = ansi!
long textcolor = 255
long backcolor = 32891346
string text = "message set in timer event"
alignment alignment = center!
end type

type cb_1 from u_cb within w_idle_web
integer x = 1088
integer y = 532
integer taborder = 10
string text = "Resume"
end type

event clicked;call super::clicked;

Idle (0)
Idle (gnv_app.il_itle_time)
close(parent)
end event

