$PBExportHeader$w_dm_autonum_example.srw
forward
global type w_dm_autonum_example from window
end type
type mle_1 from multilineedit within w_dm_autonum_example
end type
type cb_ok from commandbutton within w_dm_autonum_example
end type
end forward

global type w_dm_autonum_example from window
integer width = 3346
integer height = 2092
boolean titlebar = true
string title = "Example"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
mle_1 mle_1
cb_ok cb_ok
end type
global w_dm_autonum_example w_dm_autonum_example

on w_dm_autonum_example.create
this.mle_1=create mle_1
this.cb_ok=create cb_ok
this.Control[]={this.mle_1,&
this.cb_ok}
end on

on w_dm_autonum_example.destroy
destroy(this.mle_1)
destroy(this.cb_ok)
end on

event open;mle_1.text = "" + &
"                                                                  ARTICLE ##    " + '~r~n' + &
"                                                   DEFINITIONS AND AGREEMENT  " + '~r~n' + &
"                                                " + '~r~n' + &
"#.0 Definitions.  For the purposes of this Agreement, the following terms shall have the following meanings:"+ '~r~n' + &
"    (a) System shall include the latest version (Version 5) as of the date of this agreement of the computer ......"  + '~r~n' + &
"    (b) Hardware/Operating System shall mean the required hardware and operating system as set forth and ......" + '~r~n' + &
"                                                    " + '~r~n' + &
"#.# The 'Term' of this Agreement and the License begin on the 'Effective Date' and continue indefinitely until ......" + '~r~n' + &
"                                                " + '~r~n' + &
"#.# if requested by Licesee and as mutually agreeed to by IntelliSoft and Licensee, IntelliSoft shall......" + '~r~n' + &
"               ......                                       " + '~r~n' + & 
"                                                " + '~r~n' + &
"                                                " + '~r~n' + &
"                                                                  ARTICLE ##    " + '~r~n' + &
"                                       CUSTOMER SUPPORT AND SYSTEM MAINTENANCE  " + '~r~n' + &
"                                                " + '~r~n' + &
"#.0 Customer Support. During the Term, IntelliSoft shall provide License with the following:"+ '~r~n' + &
"               ......                                       " + '~r~n' + & 
"                                                " + '~r~n' + &
"                                                " + '~r~n' + &
"                                                                  ARTICLE ##    " + '~r~n' + &
"                                                          FEES AND EXPENSES" + '~r~n' + &
"                                                " + '~r~n' + &
"The financial terms set forth below are an offer, which will expire on        unless, by that date,  Licensee......" + '~r~n' + &
"                                                " + '~r~n' + &
"#.0 License Fee. The one-time License Fee to use the ( )-Concurrent User System, which includes IntelliCred......"+ '~r~n' + &
"               ......                                        " 

end event

type mle_1 from multilineedit within w_dm_autonum_example
integer x = 37
integer y = 28
integer width = 3273
integer height = 1856
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = true
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_ok from commandbutton within w_dm_autonum_example
integer x = 2967
integer y = 1900
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
boolean default = true
end type

event clicked;Close(Parent)
end event

