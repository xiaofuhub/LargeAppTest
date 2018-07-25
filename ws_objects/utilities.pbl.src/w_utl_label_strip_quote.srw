$PBExportHeader$w_utl_label_strip_quote.srw
forward
global type w_utl_label_strip_quote from window
end type
type dw_2 from datawindow within w_utl_label_strip_quote
end type
type cb_run from commandbutton within w_utl_label_strip_quote
end type
type dw_1 from datawindow within w_utl_label_strip_quote
end type
type cb_4 from commandbutton within w_utl_label_strip_quote
end type
type cb_3 from commandbutton within w_utl_label_strip_quote
end type
end forward

global type w_utl_label_strip_quote from window
integer x = 123
integer y = 112
integer width = 1966
integer height = 1256
boolean titlebar = true
string title = "Clean Up Quotes"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
dw_2 dw_2
cb_run cb_run
dw_1 dw_1
cb_4 cb_4
cb_3 cb_3
end type
global w_utl_label_strip_quote w_utl_label_strip_quote

type variables
long il_openfor
end variables

on w_utl_label_strip_quote.create
this.dw_2=create dw_2
this.cb_run=create cb_run
this.dw_1=create dw_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.Control[]={this.dw_2,&
this.cb_run,&
this.dw_1,&
this.cb_4,&
this.cb_3}
end on

on w_utl_label_strip_quote.destroy
destroy(this.dw_2)
destroy(this.cb_run)
destroy(this.dw_1)
destroy(this.cb_4)
destroy(this.cb_3)
end on

event open;long ll_mess
string ls_sql
string ls_sql_org
string ls_where
long rows

if message.stringparm = "P" then  //from the intellicred program
	//skip login
	il_openfor = 0
else
	
	SQLCA.DBMS="ODBC"
	SQLCA.DbParm="ConnectString='DSN=Iapp;UID=DBA;PWD=SQL;',DelimitIdentifier='Yes'"
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2007-09-14 By: Scofield
	//$<Reason> Set the connection cache dynamically on Web
	if AppeonGetClientType() = 'WEB' then
		SQLCA.DBMS = gs_CacheType
		SQLCA.DBParm = gs_CacheSet
	end if
	//---------------------------- APPEON END ----------------------------

	CONNECT USING SQLCA;
	
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox("Not Logged In", "Login Failed!")
	ELSE
		//MESSAGEBOX("","LOGIN OK")
	END IF
	il_openfor = 1
	
end if

	dw_1.settransobject(sqlca)
	dw_1.Retrieve()
	dw_2.settransobject(sqlca)
	dw_2.Retrieve()
	
	if dw_1.rowcount() = 0 and dw_2.rowcount() = 0 then
		messagebox("Clean","There are no lables needing to be stripped.")
		close (this)
	end if
end event

event close;if il_openfor = 1 then
	disCONNECT USING SQLCA;
end if
end event

type dw_2 from datawindow within w_utl_label_strip_quote
integer x = 41
integer y = 580
integer width = 1509
integer height = 528
integer taborder = 30
string dataobject = "d_utl_label_strip_quote_text"
boolean livescroll = true
end type

type cb_run from commandbutton within w_utl_label_strip_quote
integer x = 1618
integer y = 48
integer width = 274
integer height = 80
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Run"
end type

event clicked;integer res
//res = messagebox("This operation:","This utility will strip all quote and tilde characters from cred screen field labels.~rContinue?",question!,yesno!,1)
//if res = 2 then return

integer a
integer ac
integer p
integer pc
long c
long cc
string s
string sc
string nc
debugbreak()
//dw_pracaffil.settransobject(sqlca)
ac = dw_1.rowcount()//a list of all active appointments

for a = 1 to ac
	s = dw_1.getitemstring(a,"field_label")
	nc = ""
	cc  = LenA(s)
	//for c = cc to 1 step - 1
	for c = 1 to cc 
		sc = MidA(s,c,1)
		choose case sc
			case "~~","~""
				//if c = 1 then
					//nc = mid(sc,2)
			case else
					nc = nc + MidA(s,c,1) 
				//end if
				
			
				//c = c - 1
		end choose
	next
	dw_1.setitem(a,"field_label",nc)
next


dw_1.update()
commit using sqlca;
			
ac = dw_2.rowcount()//a list of all active appointments

for a = 1 to ac
	s = dw_2.getitemstring(a,"object_text")
	nc = ""
	cc  = LenA(s)
	//for c = cc to 1 step - 1
	for c = 1 to cc 
		sc = MidA(s,c,1)
		choose case sc
			case "~~","~""
				//if c = 1 then
					//nc = mid(sc,2)
			case else
					nc = nc + MidA(s,c,1) 
				//end if
				
			
				//c = c - 1
		end choose
	next
	dw_2.setitem(a,"object_text",nc)
next


dw_2.update()
commit using sqlca;
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 02.23.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
update ids set screen_obj_cache = getdate();
//--------------------------- APPEON END ---------------------------
messagebox("Done"," Update Completed")






end event

type dw_1 from datawindow within w_utl_label_strip_quote
integer x = 41
integer y = 36
integer width = 1513
integer height = 532
integer taborder = 40
string dataobject = "d_utl_label_strip_quote"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_4 from commandbutton within w_utl_label_strip_quote
integer x = 2199
integer y = 108
integer width = 247
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print"
end type

event clicked;//if dw_1.rowcount() < 1 then
//	messagebox("","nothing to print")
//	return
//end if
//
//dw_1.print()
end event

type cb_3 from commandbutton within w_utl_label_strip_quote
integer x = 1618
integer y = 156
integer width = 274
integer height = 80
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Quit"
end type

event clicked;CLOSE(PARENT)
end event

