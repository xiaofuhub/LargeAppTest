$PBExportHeader$w_idle.srw
$PBExportComments$[pfeapsrv]
forward
global type w_idle from w_response
end type
type st_1 from statictext within w_idle
end type
type st_message from u_st within w_idle
end type
type cb_1 from u_cb within w_idle
end type
end forward

global type w_idle from w_response
integer height = 804
string title = "IntelliSoft Program Time Out"
boolean controlmenu = false
long backcolor = 32891346
st_1 st_1
st_message st_message
cb_1 cb_1
end type
global w_idle w_idle

type prototypes
FUNCTION boolean Beep(long freq,long dur) LIBRARY "Kernel32.dll"
end prototypes

type variables
long il_time = 31
end variables

event open;call super::open;st_message.text = ''

timer(1)
end event

event timer;call super::timer;integer li_sec





//il_time = il_time + 1



if  il_time < 32 then 
	il_time = il_time - 1
	li_sec = il_time
	st_message.text = "Closing in " + string( li_sec) + ' seconds' 
	 Boolean rtn
	Long ll_freq, ll_dur
	ll_freq = 500
	//500 + (il_time * 10)
	ll_dur = 20
	choose case li_sec
		case 30,29,28,20,19,10
			//rtn = Beep(ll_freq, ll_dur)
			Beep(1) //alfee 10.25.2012
	end  choose
end if

if il_time < 1 then
	halt close
end if





//il_time = il_time + 1
//
//
//if  il_time < 31 then 
//     st_message.text = string( 31 - il_time) + ' seconds' 
//	  Boolean rtn
//		Long ll_freq, ll_dur
//		ll_freq = 500 + (il_time * 10)
//		ll_dur = 20
//		choose case il_time
//			case 30,29,28,20,10
//				rtn = Beep(ll_freq, ll_dur)
//		end  choose
//else
//	halt close
//end if 
end event

on w_idle.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_message=create st_message
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_message
this.Control[iCurrent+3]=this.cb_1
end on

on w_idle.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_message)
destroy(this.cb_1)
end on

type st_1 from statictext within w_idle
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

type st_message from u_st within w_idle
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

type cb_1 from u_cb within w_idle
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

