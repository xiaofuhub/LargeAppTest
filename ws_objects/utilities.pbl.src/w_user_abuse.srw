$PBExportHeader$w_user_abuse.srw
forward
global type w_user_abuse from Window
end type
type st_3 from statictext within w_user_abuse
end type
type st_1 from statictext within w_user_abuse
end type
type cb_1 from commandbutton within w_user_abuse
end type
type st_2 from statictext within w_user_abuse
end type
type cb_3 from commandbutton within w_user_abuse
end type
end forward

global type w_user_abuse from Window
int X=183
int Y=324
int Width=2743
int Height=1880
boolean TitleBar=true
string Title="User Abuse"
long BackColor=16711935
boolean ControlMenu=true
boolean MinBox=true
WindowType WindowType=popup!
st_3 st_3
st_1 st_1
cb_1 cb_1
st_2 st_2
cb_3 cb_3
end type
global w_user_abuse w_user_abuse

type variables
integer ii_click = 0
integer ii_out = 0
integer ii_leave = 0
end variables

on w_user_abuse.create
this.st_3=create st_3
this.st_1=create st_1
this.cb_1=create cb_1
this.st_2=create st_2
this.cb_3=create cb_3
this.Control[]={this.st_3,&
this.st_1,&
this.cb_1,&
this.st_2,&
this.cb_3}
end on

on w_user_abuse.destroy
destroy(this.st_3)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.cb_3)
end on

event open;//SQLCA.DBMS="ODBC"
//SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=DBA;PWD=SQL;',DelimitIdentifier='No'"
//	
//CONNECT USING SQLCA;
//
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Not Logged In", "Login Failed!")
//ELSE
//	MESSAGEBOX("","LOGIN OK")
//END IF
end event

event closequery;if ii_out = 1 then
	return 0
else
	st_2.text = "You didn't think it was going to be that simple to get out did you?"
	st_2.visible = true
	st_1.visible = false
	return 1
end if
end event

type st_3 from statictext within w_user_abuse
int X=878
int Y=1600
int Width=960
int Height=88
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Click here to leave."
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=16776960
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;ii_leave++
st_1.visible = false
st_2.visible = false
choose case ii_leave
	case 1
		this.text = "Missed me."
		this.x = 100
		this.y = 100
	case 2
		this.text = "Missed me again."
		this.x = 300
		this.y = 1000
	case 3
		this.text = "And again."
		this.x = 1400
		this.y = 800
	case 4
		this.text = "Almost got me."
		this.x = 500
		this.y = 500
	case 5
		this.text = " I promise I won't move this time."
		this.x = 750
		this.y = 750
	case 6
		this.text = " I lied."
		this.x = 1400
		this.y = 1400
	case 7
		this.text = "Missed."
		this.x = 1400
		this.y = 100		
	case 8
		this.text = "You stink."
		this.x = 124
		this.y = 900
	case 9
		this.text = "Missed again."
		this.x = 300
		this.y = 750
	case 10
		this.text = "Come on. Try again."
		this.x = 500
		this.y = 1500
	case 11
		this.text = "Missed again."
		this.x = 15
		this.y = 1200
	case 12
		this.text = "One more time!"
		this.x = 645
		this.y = 640
		
		
		
		
		
		
		
		
		
	case else
		ii_out = 1
		this.text = "Got me."

		//close(parent)
		
end choose
end event

type st_1 from statictext within w_user_abuse
int X=59
int Y=296
int Width=2587
int Height=988
boolean Visible=false
boolean Enabled=false
string Text="You Stink!"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=16711935
int TextSize=-48
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_user_abuse
int X=2249
int Y=28
int Width=457
int Height=108
int TabOrder=10
string Text="Quit"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//close(parent)
if ii_out <> 1 then
	st_1.text = "Nya Nya,~n I'm not going to let you quit!"
	st_1.visible = true
	st_2.visible = false
else
	st_1.text = "You're not quitting this way!"
	st_1.visible = true
	st_2.visible = false
end if
end event

type st_2 from statictext within w_user_abuse
int X=183
int Y=164
int Width=2304
int Height=1188
boolean Visible=false
boolean Enabled=false
string Text="none"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=16711935
int TextSize=-16
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_3 from commandbutton within w_user_abuse
int X=855
int Y=24
int Width=599
int Height=108
int TabOrder=20
boolean BringToTop=true
string Text="Click Here for Abuse"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer row_count
integer i
integer m

if ii_click > 10 then ii_click = 0

ii_click++

st_1.visible = false
st_2.visible = false

choose case ii_click
	case 1
		st_1.text = "You Stink!"
		st_1.visible = true
		
	case 2
		st_1.visible = false
		messagebox("User Error","Replace User ~nClick OK to continue.",Question!,Yesno!,1)
	case 3
		st_1.text = "I HATE you! You're always clicking on me."
		st_1.visible = true
	case 4
		st_1.text = "No, Really~n I HATE you!"
		st_1.visible = true
	case 5
		st_1.text = "No, Really~n I do!"
		st_1.visible = true	
	case 6
		st_2.text = gs_user_id + " is so dumb. . .(How dumb is " + gs_user_id + "?)  ~n~n " + gs_user_id + " is so dumb that when brains were being handed out" + gs_user_id + " was in the line for soup."
 		st_2.visible = true	
		st_1.visible = false
	case 7	
		st_1.visible = false
		st_2.visible = false
		
		
		
		
		
		
		
		
		
		

		
		
end choose
end event

