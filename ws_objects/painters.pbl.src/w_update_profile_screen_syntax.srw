$PBExportHeader$w_update_profile_screen_syntax.srw
forward
global type w_update_profile_screen_syntax from window
end type
type cb_4 from commandbutton within w_update_profile_screen_syntax
end type
type cb_3 from commandbutton within w_update_profile_screen_syntax
end type
type st_1 from statictext within w_update_profile_screen_syntax
end type
type cb_2 from commandbutton within w_update_profile_screen_syntax
end type
type cb_1 from commandbutton within w_update_profile_screen_syntax
end type
type dw_1 from datawindow within w_update_profile_screen_syntax
end type
end forward

global type w_update_profile_screen_syntax from window
integer width = 1157
integer height = 1932
boolean titlebar = true
string title = "Profile Screen Update"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_4 cb_4
cb_3 cb_3
st_1 st_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_update_profile_screen_syntax w_update_profile_screen_syntax

type variables
string is_syntax
string is_screen
end variables

forward prototypes
public function string of_set_syntax (string as_syntax)
end prototypes

public function string of_set_syntax (string as_syntax);string s
long p1
long p2

s = as_syntax

p1 = PosA(s,"header(height",1 )
p2 = PosA(s,"summary(height",1)

//header(height=176 color="536870912" )

//text(band=header alignment="2" text="ECFMG" border="0" color="0" x="9" y="0" height="80" width="3282" html.valueishtml="0"  name=t_1 visible="1"  font.face="Times New Roman" font.height="-12" font.weight="700"  font.family="1" font.pitch="2" font.charset="0" background.mode="2" background.color="12632256" )




return s
end function

on w_update_profile_screen_syntax.create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_4,&
this.cb_3,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_update_profile_screen_syntax.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;integer li_table
integer li_pos
integer li_pos2
//debugbreak()
is_syntax = message.stringparm

//messagebox("",is_syntax)

li_pos = PosA(is_syntax,"%", 1)
li_pos2 = PosA(is_syntax,"$", 1)

li_table = integer(MidA(is_syntax, 1, li_pos -1))
is_screen = MidA(is_syntax, li_pos + 1, li_pos2 - 1 - li_pos)

//messagebox("screen",is_screen)

is_syntax = MidA(is_syntax,  li_pos2 + 1)
//clipboard(is_syntax)
//openwithparm(w_sql_msg,is_syntax)

dw_1.settransobject(sqlca)
dw_1.retrieve(li_table)
end event

type cb_4 from commandbutton within w_update_profile_screen_syntax
boolean visible = false
integer x = 55
integer y = 2008
integer width = 311
integer height = 72
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Test Syntax"
end type

event clicked;integer j
string errorBuffer
//
////	of_library_check( gs_dir_path + "intellicred\report_temp.pbd") 
//	j = LibraryImport( gs_dir_path + "intellicred\report_temp.pbd","syntax_test", ImportDataWindow!, is_syntax, ErrorBuffer)
//		messagebox(string(j),gs_dir_path + "intellicred\report_temp.pbd")
//		if len(ErrorBuffer ) > 1 then
//			messagebox("Syntax error during LibraryImport", errorBuffer)
////	continue
//		end if

open(w_syntax_test)
end event

type cb_3 from commandbutton within w_update_profile_screen_syntax
boolean visible = false
integer x = 50
integer y = 1920
integer width = 320
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save Syntax"
end type

event clicked;openwithparm(w_sql_msg,is_syntax)
integer ifile
integer li_counter
integer li_loops
long ll_len
long ll_start = 1
string ls_temp
//---------Begin Modified by (Appeon)Stephen 02.17.2014 for file paths modify --------
//string ls_file = "c:\intellicred\syntaxfile.isg"
string ls_file = gs_dir_path + gs_DefDirName+"\syntaxfile.isg"
//---------End Modfiied ------------------------------------------------------

filedelete(ls_file)

ll_len = LenA(is_syntax)

ifile = FileOpen( ls_file , StreamMode!,WRITE!,LOCKWRITE!)

IF ll_len > 32765 THEN 
	IF Mod(ll_len,32765) = 0 THEN 
		li_loops = ll_len/32765 
	ELSE 
		li_loops = (ll_len/32765) + 1 
	END IF 
ELSE 
   	 li_loops = 1 
END IF 



FOR li_counter = 1 to li_loops 
	ls_temp = MidA(is_syntax,ll_start,32765)
	Filewrite( ifile, ls_temp) 
//   	ll_bytes_read = FileRead( li_filenum, ls_temp) 
//		 IF ll_bytes_read = -1 THEN
//			MessageBox("Error", "Error with FileRead command.  Return -1." )
//			Return
//		 END IF
	ll_start = ll_start + 32765 

NEXT 

fileclose(ifile)
end event

type st_1 from statictext within w_update_profile_screen_syntax
integer x = 18
integer y = 24
integer width = 1134
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Select profile views to update and click Update."
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_update_profile_screen_syntax
integer x = 709
integer y = 1720
integer width = 302
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_update_profile_screen_syntax
integer x = 393
integer y = 1720
integer width = 302
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Update"
end type

event clicked;integer i
integer li_vid
integer li_sid

for i = 1 to dw_1.rowcount()
	if dw_1.getitemnumber(i,"selected") = 1 then
		li_vid = dw_1.getitemnumber(i,"profile_view_id")
		li_sid = dw_1.getitemnumber(i,"profile_report_id")
		//field is a blob so must be updated as such
		update profile_view_reports set dw_syntax = :is_syntax where profile_view_id = :li_vid and profile_report_id = :li_sid;
	//	dw_1.setitem(i,"dw_syntax", is_syntax)
	end if
next

commit using sqlca;
//dw_1.update()

close(parent)

end event

type dw_1 from datawindow within w_update_profile_screen_syntax
integer x = 5
integer y = 100
integer width = 1138
integer height = 1612
integer taborder = 10
string title = "none"
string dataobject = "d_profile_syntax_update"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

